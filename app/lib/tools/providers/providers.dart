import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../screens/messenger/notifiers/chats_notifier.dart';
import '../../screens/messenger/states/chats_state.dart';
import '../router/app_router.dart';

final chatsScreenNotifier =
    NotifierProvider.autoDispose<ChatsNotifier, ChatsState>(ChatsNotifier.new);

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter());
