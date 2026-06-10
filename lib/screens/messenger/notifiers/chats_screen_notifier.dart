import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/screens/messenger/states/chats_screen_state.dart';

class ChatsScreenNotifier extends Notifier<ChatsScreenState> {
  @override
  build() {
    return ChatsScreenState(chatsListScrollController: ScrollController());
  }

  Future<void> scrollToTop() async {
    await state.chatsListScrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
}
