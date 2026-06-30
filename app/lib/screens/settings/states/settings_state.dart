import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(true) bool isOnNameInNotification,
    @Default(ThemeMode.system) ThemeMode themeMode,
    required Locale locale,
  }) = _SettingsState;
}
