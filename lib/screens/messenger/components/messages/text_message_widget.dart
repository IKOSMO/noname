import 'package:flutter/material.dart';
import 'package:noname/models/messages/base_message_model.dart';

class TextMessageWidget extends StatefulWidget {
  const TextMessageWidget({super.key, required this.message});

  final TextMessageModel message;

  @override
  State<TextMessageWidget> createState() => _TextMessageWidgetState();
}

class _TextMessageWidgetState extends State<TextMessageWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.message.isYou) {
      return _messageContainer(
        text: widget.message.text,
        alignment: Alignment.centerRight,
        color: Color.fromARGB(115, 60, 61, 63),
      );
    } else {
      return _messageContainer(
        text: widget.message.text,
        alignment: Alignment.centerLeft,
        color: Color.fromARGB(62, 255, 255, 255),
      );
    }
  }

  Widget _messageContainer({
    required String text,
    required Alignment alignment,
    required Color? color,
  }) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: IntrinsicWidth(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.only(bottom: 3, top: 3),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: _messageText(),
          ),
        ),
      ),
    );
  }

  Widget _messageText() {
    final double stringWidth = _getStringWidth(
      text: widget.message.text,
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
            widget.message.text,
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
              if (widget.message.isYou) ...[
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
        crossAxisAlignment: widget.message.isYou
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: Text(
              widget.message.text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: MediaQuery.of(context).size.width * 0.035,
              ),
              textWidthBasis: TextWidthBasis.longestLine,
            ),
          ),
          Row(
            mainAxisAlignment: widget.message.isYou
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
              if (widget.message.isYou) ...[
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

  double _getStringWidth({required String text, required TextStyle textStyle}) {
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
