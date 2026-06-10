import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/screens/messenger/notifiers/chats_screen_notifier.dart';
import 'package:noname/screens/messenger/states/chats_screen_state.dart';
import 'package:noname/tools/router/app_router.dart';

final chatsScreenNotifier =
    NotifierProvider.autoDispose<ChatsScreenNotifier, ChatsScreenState>(
      ChatsScreenNotifier.new,
    );

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter());