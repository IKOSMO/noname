import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core/l10n/app_localizations.dart';

import '../../../models/messages/base_message_model.dart';
import '../components/messages/base_message_widget.dart';
import '../../../tools/router/app_router.gr.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

@RoutePage()
class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  final List<BaseMessageModel> _messages = [
    BaseMessageModel.text(
      id: 0,
      chatId: 0,
      userId: 0,
      text: 'text',
      username: 'username',
      isYou: false,
      dateTime: DateTime.now(),
    ),
    BaseMessageModel.text(
      id: 0,
      chatId: 0,
      userId: 0,
      text: 'text',
      username: 'username',
      isYou: true,
      dateTime: DateTime.now(),
    ),
    BaseMessageModel.text(
      id: 0,
      chatId: 0,
      userId: 0,
      text: 'text',
      username: 'username',
      isYou: false,
      dateTime: DateTime.now(),
    ),
    BaseMessageModel.text(
      id: 0,
      chatId: 0,
      userId: 0,
      text: 'text',
      username: 'username',
      isYou: true,
      dateTime: DateTime.now(),
    ),
    BaseMessageModel.text(
      id: 0,
      chatId: 0,
      userId: 0,
      text: 'text',
      username: 'username',
      isYou: false,
      dateTime: DateTime.now(),
    ),
    BaseMessageModel.text(
      id: 0,
      chatId: 0,
      userId: 0,
      text: 'text',
      username: 'username',
      isYou: true,
      dateTime: DateTime.now(),
    ),
    BaseMessageModel.text(
      id: 0,
      chatId: 0,
      userId: 0,
      text: 'text',
      username: 'username',
      isYou: false,
      dateTime: DateTime.now(),
    ),
    BaseMessageModel.text(
      id: 0,
      chatId: 0,
      userId: 0,
      text: 'text',
      username: 'username',
      isYou: true,
      dateTime: DateTime.now(),
    ),
    BaseMessageModel.text(
      id: 0,
      chatId: 0,
      userId: 0,
      text: 'text',
      username: 'username',
      isYou: false,
      dateTime: DateTime.now(),
    ),
    BaseMessageModel.text(
      id: 0,
      chatId: 0,
      userId: 0,
      text: 'text',
      username: 'username',
      isYou: true,
      dateTime: DateTime.now(),
    ),
    BaseMessageModel.text(
      id: 0,
      chatId: 0,
      userId: 0,
      text: 'text',
      username: 'username',
      isYou: false,
      dateTime: DateTime.now(),
    ),
    BaseMessageModel.text(
      id: 0,
      chatId: 0,
      userId: 0,
      text: 'text',
      username: 'username',
      isYou: true,
      dateTime: DateTime.now(),
    ),
    BaseMessageModel.text(
      id: 0,
      chatId: 0,
      userId: 0,
      text: 'text',
      username: 'username',
      isYou: false,
      dateTime: DateTime.now(),
    ),
    BaseMessageModel.text(
      id: 0,
      chatId: 0,
      userId: 0,
      text: 'text',
      username: 'username',
      isYou: true,
      dateTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {

    final messages = _messages.reversed.toList();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 146, 228, 194),
                    const Color.fromARGB(255, 182, 142, 226),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ScrollablePositionedList.builder(
                      itemCount: messages.length,
                      reverse: true,
                      padding: EdgeInsets.only(
                        top: 150,
                        bottom: 40,
                        left: 10,
                        right: 10,
                      ),
                      itemBuilder: (context, index) {
                        final message = messages[index];

                        return BaseMessageWidget(message: message);
                      },
                      itemScrollController: itemScrollController,
                      scrollOffsetController: scrollOffsetController,
                      itemPositionsListener: itemPositionsListener,
                      scrollOffsetListener: scrollOffsetListener,
                    ),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SoftEdgeBlur(
                        edges: [
                          EdgeBlur(
                            type: EdgeType.topEdge,
                            tintColor: Color.fromARGB(255, 143, 187, 169),
                            size: 200,
                            sigma: 0,
                            controlPoints: [
                              ControlPoint(
                                position: 0.5,
                                type: ControlPointType.visible,
                              ),
                              ControlPoint(
                                position: 1,
                                type: ControlPointType.transparent,
                              ),
                            ],
                          ),
                        ],
                        child: Container(height: 200),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: MediaQuery.of(context).padding.top + 10,
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () => context.router.pop(),
                              child: SvgPicture.asset(
                                'assets/images/arrow_back.svg',
                                height: 40,
                              ),
                            ),
                            SizedBox(width: 25),
                            Expanded(
                              child: InkWell(
                                onTap: () =>
                                    context.router.push(ProfileRoute()),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      padding: EdgeInsets.all(1.5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        child: Image.asset(
                                          'assets/images/person.png',
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'Алексей Грумцин',
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2,
                                          fontSize:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.055,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 70,
                              height: 50,
                              margin: EdgeInsets.only(
                                left: 10,
                                right: 3,
                                top: 3,
                                bottom: 3,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color.fromARGB(157, 60, 61, 63),
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/images/call.svg',
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).padding.bottom + 40,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: const Color.fromARGB(255, 60, 61, 63),
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    maxLines: 10,
                    minLines: 1,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: AppLocalizations.of(context)?.input_placeholder ?? '',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 60, 61, 63),
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    itemScrollController.scrollTo(
                      index: 150,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOutCubic,
                    );
                  },
                  child: Container(
                    width: 80,
                    height: 50,
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 3,
                      top: 3,
                      bottom: 3,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromARGB(255, 60, 61, 63),
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/images/send.svg',
                      colorFilter: ColorFilter.mode(
                        const Color.fromARGB(216, 255, 255, 255),
                        BlendMode.srcIn,
                      ),
                      width: 27,
                      height: 27,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
