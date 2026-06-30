import 'dart:developer';

import 'package:feature_settings/components/gradient_icon.dart';
import 'package:flutter/material.dart';
import '../../../../models/messages/base_message_model.dart';
import 'text_message_widget.dart';
// import '../../../../../../packages/feature_settings/lib/components/gradient_icon.dart';

class BaseMessageWidget extends StatefulWidget {
  const BaseMessageWidget({super.key, required this.message});

  final BaseMessageModel message;

  @override
  State<BaseMessageWidget> createState() => _BaseMessageWidgetState();
}

class _BaseMessageWidgetState extends State<BaseMessageWidget> {
  Offset _messageOffset = Offset(0, 0);
  Size size = Size(0, 0);
  final GlobalKey _messageKey = GlobalKey();

  bool _isLongPress = false;

  @override
  Widget build(BuildContext context) {
    final message = widget.message;
    final messageRenderBox =
        _messageKey.currentContext?.findRenderObject() as RenderBox?;

    if (messageRenderBox != null && messageRenderBox.hasSize) {
      size = messageRenderBox.size;
    }

    return GestureDetector(
      onLongPress: () {
        final messageRenderBox =
            _messageKey.currentContext?.findRenderObject() as RenderBox?;
        double targetY = -50;

        if (messageRenderBox != null && messageRenderBox.hasSize) {
          log(messageRenderBox.localToGlobal(Offset.zero).toString());
          log(MediaQuery.sizeOf(context).height.toString());
          if (MediaQuery.sizeOf(context).height -
                  messageRenderBox.localToGlobal(Offset.zero).dy <
              MediaQuery.sizeOf(context).height * 0.3) {
            targetY = -110;
          }
          setState(() {
            _isLongPress = true;
            _messageOffset = Offset(0, targetY);
          });
        }
      },
      onLongPressEnd: (details) {
        setState(() {
          _isLongPress = false;
          _messageOffset = Offset(0, 0);
        });
      },
      child: TweenAnimationBuilder<Offset>(
        tween: Tween(begin: Offset(0, 0), end: _messageOffset),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        builder: (context, offset, child) {
          return Transform.translate(
            offset: offset,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                switch (message) {
                  TextMessageModel() => TextMessageWidget(
                    key: _messageKey,
                    message: message,
                  ),
                },
                if (_isLongPress)
                  Positioned(
                    left: message.isYou ? null : 0,
                    right: message.isYou ? 0 : null,
                    top: size.height,
                    child: _contextMenuWidget(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _contextMenuWidget() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.4,
        maxHeight: MediaQuery.sizeOf(context).height * 0.4,
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 58, 58, 58),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _contextMenuButton(text: 'Копировать', icon: Icons.copy),
          _contextMenuButton(text: 'Копировать', icon: Icons.copy),
          _contextMenuButton(text: 'Копировать', icon: Icons.copy),
          _contextMenuButton(text: 'Копировать', icon: Icons.copy),
        ],
      ),
    );
  }

  Widget _contextMenuButton({required String text, required IconData icon}) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.sizeOf(context).width * 0.035,
            ),
          ),
          GradientIcon(icon: icon, size: 30),
        ],
      ),
    );
  }
}
