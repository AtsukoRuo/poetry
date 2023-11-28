import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetry/Util/PlatformUIAdapter.dart';
import 'package:poetry/ModelView/AppConfig/AppConfig.dart';
import 'package:poetry/ModelView/AppConfig/AppConfigBloc.dart';

const int minimumLoadTime = 1000; // 启动页的最小时间，单位毫秒

/// 启动页
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late int _initTimestamp;
  @override
  void initState() {
    super.initState();
    _initTimestamp = DateTime.now().millisecondsSinceEpoch;

    // 由于initApp是一个异步方法，不通过await调用异步方法并不会阻塞，任务交给后台来处理
    // initApp通过Bloc对象来通知数据加载完毕的事件
    context.read<AppConfigBloc>().initApp();
  }

  @override
  Widget build(BuildContext context) {
    // 监听数据加载完成的事件
    return BlocListener<AppConfigBloc, AppConfig>(
      listener: _listenInitialization,
      child: buildSplashPage(context),
    );
  }

  // 启动页的构建逻辑
  Widget buildSplashPage(BuildContext context) {
    return Container(color: Colors.green);
  }

  void _listenInitialization(BuildContext context, AppConfig state) async {
    // 保证启动页的最小时间
    int now = DateTime.now().millisecondsSinceEpoch;
    int delay = minimumLoadTime - (now - _initTimestamp);
    if (delay > 0) {
      await Future.delayed(Duration(milliseconds: delay));
    }

    if (state.isInitialized) {
      Widget mainWidget = PlatformUIAdapter(
        desktopWidget: Container(color: Colors.red),
        mobileWidget: Container(color: Colors.yellow),
      );

      // 通过Navigator将启动页替换为主界面
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => mainWidget),
      );
    }
  }
}
