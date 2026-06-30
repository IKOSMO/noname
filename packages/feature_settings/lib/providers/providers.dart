import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/settings_notifier.dart';
import '../notifiers/user_data_notifier.dart';
import '../states/settings_state.dart';
import '../states/user_data_state.dart';

final userDataNotifier =
    NotifierProvider.autoDispose<UserDataNotifier, UserDataState>(
      UserDataNotifier.new,
    );

final settingsNotifier =
    NotifierProvider.autoDispose<SettingsNotifier, SettingsState>(
      SettingsNotifier.new,
    );