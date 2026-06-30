import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/screens/messenger/notifiers/chats_notifier.dart';
import 'package:noname/screens/messenger/states/chats_state.dart';
import 'package:noname/screens/settings/notifiers/settings_notifier.dart';
import 'package:noname/screens/settings/notifiers/user_data_notifier.dart';
import 'package:noname/screens/settings/states/settings_state.dart';
import 'package:noname/screens/settings/states/user_data_state.dart';
import 'package:noname/tools/router/app_router.dart';

final chatsScreenNotifier =
    NotifierProvider.autoDispose<ChatsNotifier, ChatsState>(ChatsNotifier.new);

final userDataNotifier =
    NotifierProvider.autoDispose<UserDataNotifier, UserDataState>(
      UserDataNotifier.new,
    );

final settingsNotifier =
    NotifierProvider.autoDispose<SettingsNotifier, SettingsState>(
      SettingsNotifier.new,
    );

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter());
