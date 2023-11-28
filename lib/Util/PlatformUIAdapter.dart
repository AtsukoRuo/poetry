import 'dart:io';

import 'package:flutter/material.dart';

/// 平台适配器
class PlatformUIAdapter extends StatelessWidget {
  final Widget desktopWidget;
  final Widget mobileWidget;

  const PlatformUIAdapter({
    super.key,
    required this.desktopWidget,
    required this.mobileWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      return mobileWidget;
    }
    return desktopWidget;
  }
}
