import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetry/View/RootWidget.dart';
import 'package:window_manager/window_manager.dart';

import 'ModelView/AppConfig/AppConfigBloc.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      minimumSize: Size(800, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  } catch (error) {}

  runApp(const PoetryApp());
}

class PoetryApp extends StatelessWidget {
  const PoetryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 注册全局Bloc对象
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppConfigBloc>(create: (_) => AppConfigBloc()),
      ],
      child: const RootWidget(),
      //child: MultiBlocListener(listeners: [], child: RootWidget()),
    );
  }
}
