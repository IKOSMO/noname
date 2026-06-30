import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/settings_state.dart';

class SettingsNotifier extends Notifier<SettingsState> {
  @override
  SettingsState build() {
    return SettingsState(isOnNameInNotification: true, locale: Locale('ru'), themeMode: ThemeMode.dark);
  }

  void changeIsOnNameInNotification({required bool value}) {
    state = state.copyWith(isOnNameInNotification: value);
  }

  void changeLocale({required Locale value}) {
    state = state.copyWith(locale: value);
  }

  void changeTheme({required ThemeMode value}) {
    state = state.copyWith(themeMode: value);
  }

  List<Locale> get supportedLocales => const [Locale('en'), Locale('ru')];

  String getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'ru':
        return 'Русский';
      default:
        return code;
    }
  }
}
