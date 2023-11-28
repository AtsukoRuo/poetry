import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetry/ModelView/AppConfig/AppConfigBloc.dart';

import 'SplashPage.dart';

Map<String, WidgetBuilder> routes = {
  "splash_page": (_) => const SplashPage(),
};


class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Color? color = context
        .select<AppConfigBloc, Color?>((value) => value.state.colorSchemeSeed);
    ThemeMode themeMode = context
        .select<AppConfigBloc, ThemeMode>((value) => value.state.themeMode);

    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: color, brightness: Brightness.light),
      darkTheme: ThemeData(colorSchemeSeed: color, brightness: Brightness.dark),
      themeMode: themeMode,
      routes: routes,
      initialRoute: "splash_page",
      debugShowCheckedModeBanner: false,
    );
  }
}
