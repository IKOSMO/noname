import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/chats_state.dart';

class ChatsNotifier extends Notifier<ChatsState> {
  @override
  build() {
    return ChatsState(chatsListScrollController: ScrollController());
  }

  Future<void> scrollToTop() async {
    await state.chatsListScrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
}
