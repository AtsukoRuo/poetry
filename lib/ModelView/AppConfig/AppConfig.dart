import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppConfig extends Equatable {
  final Color? colorSchemeSeed;
  final bool isInitialized;
  final ThemeMode themeMode;

  const AppConfig({
    this.isInitialized = false,
    this.colorSchemeSeed = Colors.green,
    this.themeMode = ThemeMode.system,
  });

  AppConfig copyWith({
    Color? colorSchemeSeed,
    bool? isInitialized,
    ThemeMode? themeMode,
  }) {
    return AppConfig(
      colorSchemeSeed: colorSchemeSeed ?? this.colorSchemeSeed,
      isInitialized: isInitialized ?? this.isInitialized,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [colorSchemeSeed, isInitialized, themeMode];
}
