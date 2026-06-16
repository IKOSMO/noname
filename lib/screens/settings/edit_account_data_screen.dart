import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:variable_blur/variable_blur.dart';

@RoutePage()
class EditAccountDataScreen extends StatefulWidget {
  const EditAccountDataScreen({super.key});

  @override
  State<EditAccountDataScreen> createState() => _EditAccountDataScreenState();
}

class _EditAccountDataScreenState extends State<EditAccountDataScreen> {
  final ScrollController _scrollController = ScrollController();
  double _offsetBlur = 0.4;

  List<Map<String, dynamic>> _settingsConfig({required BuildContext context}) =>
      [
        {
          "type": "button",
          "name": "Изменить фотографию",
          "icon": Icons.add_a_photo_outlined,
          "onTap": () {},
          "showRightChevron": false,
        },
        {
          "type": "button",
          "name": "Мой профиль",
          "icon": Icons.person_outline_rounded,
          "onTap": () {},
          "showRightChevron": true,
        },
        {
          "type": "button_collection",
          "buttons": [
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
          ],
        },
        {
          "type": "button_collection",
          "buttons": [
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
          ],
        },
        {
          "type": "button_collection",
          "buttons": [
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
          ],
        },
        {
          "type": "button_collection",
          "buttons": [
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
          ],
        },
        {
          "type": "button_collection",
          "buttons": [
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
            {
              "name": "Мой профиль",
              "icon": Icons.person_outline_rounded,
              "onTap": () {},
              "showRightChevron": true,
            },
          ],
        },
      ];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    double progress =
        (_scrollController.position.pixels *
                3 /
                MediaQuery.of(context).size.height)
            .clamp(0.0, 1.0);

    _offsetBlur = 0.4 + (0.6 * progress);
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: VariableBlur(
                sigma: 14.0,
                blurSides: BlurSides.vertical(top: 0.0, bottom: _offsetBlur),
                quality: BlurQuality.high,
                isYFlipNeed: true,
                child: Image.asset(
                  'assets/images/person.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 0),
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBody(),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 15,
              right: 15,
              left: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    // onTap: () => context.router.pop(),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(100, 0, 0, 0),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.qr_code_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(100, 0, 0, 0),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Изм.',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: StickyMenuHeaderDelegate(
            maxHeight: MediaQuery.of(context).size.height * 0.50,
            minHeight: MediaQuery.of(context).size.height * 0.15,
            name: 'Алексей Грумцин',
            phone: '+7 (996) 445 2928',
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 50,
          ),
          sliver: SliverList.builder(
            itemCount: _settingsConfig(context: context).length,
            itemBuilder: ((context, index) {
              if (_settingsConfig(context: context)[index]['type'] ==
                  'button') {
                return _button(
                  name: _settingsConfig(context: context)[index]['name'],
                  icon: _settingsConfig(context: context)[index]['icon'],
                  onTap: _settingsConfig(context: context)[index]['onTap'],
                  showRightChevron: _settingsConfig(
                    context: context,
                  )[index]['showRightChevron'],
                  index: index,
                );
              } else {
                return _buttonCollection(
                  index: index,
                  buttons: _settingsConfig(context: context)[index]['buttons'],
                );
              }
            }),
          ),
        ),
      ],
    );
  }

  Widget _button({
    required String name,
    required IconData icon,
    required VoidCallback onTap,
    required bool showRightChevron,
    required int index,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Container(
        margin: EdgeInsets.only(
          top: index == 0 ? 20 : 15,
          bottom: 5,
          left: 15,
          right: 15,
        ),
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 5),
        width: MediaQuery.of(context).size.width - 30,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromARGB(255, 34, 34, 34),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 146, 228, 194),
                    Color.fromARGB(255, 182, 142, 226),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcIn,
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (showRightChevron) ...[
              Icon(
                Icons.chevron_right_rounded,
                color: const Color.fromARGB(62, 255, 255, 255),
                size: 30,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buttonCollection({
    required int index,
    required List<Map<String, dynamic>> buttons,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Container(
        margin: EdgeInsets.only(
          top: index == 0 ? 20 : 15,
          bottom: 5,
          left: 15,
          right: 15,
        ),
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 5),
        width: MediaQuery.of(context).size.width - 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromARGB(255, 34, 34, 34),
        ),
        child: Column(
          children: [
            for (int i = 0; i < buttons.length; i++)
              Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 146, 228, 194),
                            Color.fromARGB(255, 182, 142, 226),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.srcIn,
                      child: Icon(buttons[i]['icon'], color: Colors.white, size: 30),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  buttons[i]['name'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (buttons[i]['showRightChevron']) ...[
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: const Color.fromARGB(
                                    62,
                                    255,
                                    255,
                                    255,
                                  ),
                                  size: 30,
                                ),
                              ],
                            ],
                          ),
                          if (i != buttons.length - 1) ...[
                            Divider(
                              color: const Color.fromARGB(62, 255, 255, 255),
                              endIndent: 10.0,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class StickyMenuHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final String name;
  final String phone;

  StickyMenuHeaderDelegate({
    required this.maxHeight,
    required this.minHeight,
    required this.name,
    required this.phone,
  });

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxHeight ||
        oldDelegate.minExtent != minHeight;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double scrollProgress = (shrinkOffset / (maxHeight - minHeight))
        .clamp(0.0, 1.0);

    final bool isPinned = scrollProgress >= 0.9;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            isPinned ? Colors.black : Colors.transparent,
            Colors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.7, 1.0],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: isPinned ? 35 : 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: isPinned
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: isPinned
                          ? MediaQuery.of(context).size.width * 0.04
                          : MediaQuery.of(context).size.width * 0.065,
                      height: 1,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: isPinned ? TextAlign.center : TextAlign.start,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            SizedBox(
              height: (1.0 - scrollProgress) * 30.0,
              child: AnimatedOpacity(
                opacity: 1.0 - scrollProgress,
                duration: const Duration(milliseconds: 50),
                child: Text(
                  phone,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    height: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
