import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetry/Repository/LocalDatabase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppConfig.dart';

class AppConfigBloc extends Cubit<AppConfig> {
  AppConfigBloc() : super(AppConfig());

  late SharedPreferences _sharedPreferences;
  SharedPreferences get sharedPreferences => _sharedPreferences;

  // 必须是一个异步方法
  void initApp() async {
    // 连接数据库
    await LocalDatabase.localDatabase.connect();

    // 连接本地Key-Value
    _sharedPreferences = await SharedPreferences.getInstance();

    AppConfig newAppConfig = state.copyWith(isInitialized: true);
    // 为了避免发送信号后Widget尚未构建完成，我们需要在帧结束后再调用emit()，
    final widgetsBinding = WidgetsBinding.instance;
    widgetsBinding.addPostFrameCallback((_) {
      emit(newAppConfig);
    });
    // 强制触发一帧的更新
    widgetsBinding.scheduleFrame();
  }
}
