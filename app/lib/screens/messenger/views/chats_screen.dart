import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../tools/l10n/app_localizations.dart';
import '../notifiers/chats_notifier.dart';
import '../states/chats_state.dart';
import '../../../tools/providers/providers.dart';
import '../../../tools/router/app_router.gr.dart';

@RoutePage()
class ChatsScreen extends ConsumerStatefulWidget {
  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isFocused = false;
  bool isExpanded = false;
  bool isVisibleStories = false;

  @override
  Widget build(BuildContext context) {
    final chatsNotifier = ref.read(chatsScreenNotifier.notifier);
    final chatsState = ref.watch(chatsScreenNotifier);

    return _build(chatsNotifier: chatsNotifier, chatsState: chatsState,);
  }

  Widget _build({
    required ChatsNotifier chatsNotifier,
    required ChatsState chatsState,
  }) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: AnimatedPadding(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.only(
                  top:
                      (isExpanded ? 0.24 : 0.15) *
                          MediaQuery.of(context).size.height -
                      24,
                ),
                child: _buildChatsList(
                  chatsNotifier: chatsNotifier,
                  chatsState: chatsState,
                ),
              ),
            ),
            _buildHeader(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
      width: MediaQuery.of(context).size.width,
      height: isExpanded
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.15,
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
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(38, 0, 0, 0),
                    borderRadius: BorderRadius.circular(25),
                    border: isFocused
                        ? Border.all(
                            color: const Color.fromARGB(137, 255, 255, 255),
                            width: 2,
                          )
                        : Border.all(color: Colors.transparent, width: 2),
                  ),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.05,
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        width: isFocused
                            ? MediaQuery.of(context).size.width -
                                  ((MediaQuery.of(context).size.width * 0.05) +
                                      64)
                            : MediaQuery.of(context).size.width * 0.4,
                        height: 50,
                        child: TextFormField(
                          controller: searchController,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            height: 1.0,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            // isCollapsed: true,
                            hintText: AppLocalizations.of(context)?.search_placeholder ?? '',
                            hintStyle: TextStyle(
                              color: const Color.fromARGB(193, 255, 255, 255),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                            contentPadding: EdgeInsets.only(left: 10),
                          ),
                          onTap: () {
                            setState(() {
                              isFocused = true;
                            });
                          },
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            setState(() {
                              isFocused = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => setState(() {
                    isExpanded = !isExpanded;
                    if (isExpanded) {
                      Future.delayed(Duration(milliseconds: 100), () {
                        if (mounted) {
                          setState(() {
                            isVisibleStories = !isVisibleStories;
                          });
                        }
                      });
                    } else {
                      Future.delayed(Duration(milliseconds: 100), () {
                        if (mounted) {
                          setState(() {
                            isVisibleStories = !isVisibleStories;
                          });
                        }
                      });
                    }
                  }),
                  splashColor: Colors.transparent,
                  child: AnimatedRotation(
                    turns: isExpanded ? 0.5 : 1,
                    duration: Duration(milliseconds: 200),
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: isFocused
                          ? const SizedBox.shrink()
                          : Icon(
                              Icons.expand_more,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.07,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedOpacity(
            opacity: isExpanded ? 1 : 0,
            duration: Duration(milliseconds: 200),
            child: Visibility(
              visible: isVisibleStories,
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.only(left: 20, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromARGB(38, 0, 0, 0),
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 70,
                          child: ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 70,
                                height: 70,
                                margin: EdgeInsets.only(
                                  left: index == 0 ? 0 : 5,
                                  right: index == 9 ? 20 : 5,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.asset(
                                    'assets/images/person.png',
                                    colorBlendMode: BlendMode.darken,
                                    color: const Color.fromARGB(24, 0, 0, 0),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatsList({
    required ChatsNotifier chatsNotifier,
    required ChatsState chatsState,
  }) {
    return ListView.builder(
      controller: chatsState.chatsListScrollController,
      itemCount: 30,
      shrinkWrap: true,
      padding: EdgeInsets.only(
        top: 35,
        bottom: MediaQuery.of(context).size.height * 0.3,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => context.router.push(ChatRoute()),
          behavior: HitTestBehavior.opaque,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 65,
                  height: 65,
                  margin: EdgeInsets.only(right: 10),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset('assets/images/person.png'),
                        ),
                      ),
                      Visibility(
                        visible: index % 2 == 0 ? true : false,
                        child: Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 17,
                            height: 17,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(color: Colors.black, width: 3),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Алексей Грумцин',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                          Text(
                            index % 2 == 0
                                ? 'Только что'
                                : index % 3 == 0
                                ? '5 минут назад'
                                : '18:54',
                            style: TextStyle(
                              color: const Color.fromARGB(183, 255, 255, 255),
                              fontWeight: FontWeight.w400,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Привет! Как дела?',
                        style: TextStyle(
                          color: const Color.fromARGB(183, 255, 255, 255),
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
