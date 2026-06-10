import 'dart:developer';

import 'package:flutter/material.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({
    super.key,
    required this.id,
    required this.name,
    required this.text,
    required this.isYou,
  });

  final String text;
  final String name;
  final int id;
  final bool isYou;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isYou) {
      return myMessage(text: widget.text, name: widget.name, id: widget.id);
    } else {
      return elsesMessage(text: widget.text, name: widget.name, id: widget.id);
    }
  }

  Widget myMessage({
    required String text,
    required String name,
    required int id,
  }) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: IntrinsicWidth(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.only(right: 20, bottom: 3, top: 3),
            decoration: const BoxDecoration(
              color: Color.fromARGB(115, 60, 61, 63),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
            ),
            child: messageText(text: text),
          ),
        ),
      ),
    );
  }

  Widget elsesMessage({
    required String text,
    required String name,
    required int id,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: IntrinsicWidth(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.only(left: 20, bottom: 3, top: 3),
            decoration: const BoxDecoration(
              color: Color.fromARGB(62, 255, 255, 255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: messageText(text: text),
          ),
        ),
      ),
    );
  }

  Widget messageText({required String text}) {
    final double stringWidth = getStringWidth(
      text: widget.text,
      textStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: MediaQuery.of(context).size.width * 0.035,
      ),
    );

    if (stringWidth < MediaQuery.of(context).size.width * 0.5) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: MediaQuery.of(context).size.width * 0.035,
            ),
          ),
          SizedBox(width: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '11:09',
                style: TextStyle(
                  color: const Color.fromARGB(117, 255, 255, 255),
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.width * 0.025,
                ),
              ),
              if (widget.isYou) ...[
                SizedBox(width: 5),
                Icon(
                  Icons.done_all_rounded,
                  color: const Color.fromARGB(117, 255, 255, 255),
                  size: 15,
                ),
              ],
            ],
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: widget.isYou
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: MediaQuery.of(context).size.width * 0.035,
              ),
              textWidthBasis: TextWidthBasis.longestLine,
            ),
          ),
          Row(
            mainAxisAlignment: widget.isYou
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Text(
                '11:09',
                style: TextStyle(
                  color: const Color.fromARGB(117, 255, 255, 255),
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.width * 0.025,
                ),
              ),
              if (widget.isYou) ...[
                SizedBox(width: 5),
                Icon(
                  Icons.done_all_rounded,
                  color: const Color.fromARGB(117, 255, 255, 255),
                  size: 15,
                ),
              ],
            ],
          ),
        ],
      );
    }
  }

  double getStringWidth({required String text, required TextStyle textStyle}) {
    final textSpan = TextSpan(text: text, style: textStyle);

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );

    textPainter.layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size.width;
  }
}
