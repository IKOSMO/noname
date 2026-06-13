import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:noname/tools/router/app_router.gr.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isFocused = false;
  final TextEditingController searchController = TextEditingController();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  List<Map<String, dynamic>> settings({required BuildContext context}) => [
    {
      "name": 'Данные аккаунта',
      "description": 'Редактирование данных аккаунта',
      "icon": Icons.person_outline_rounded,
      "onTap": () => context.router.push(EditAccountDataRoute()),
    },
    {
      "name": 'Конфиденциальность',
      "description": 'Настройки приватности, видимости и т.п.',
      "icon": Icons.privacy_tip_outlined,
      "onTap": () {},
    },
    {
      "name": 'Уведомления',
      "description": 'Настройки уведомлений',
      "icon": Icons.notifications_active_outlined,
      "onTap": () {},
    },
    {
      "name": 'Темы',
      "description": 'Изменение темы приложения',
      "icon": Icons.format_paint_outlined,
      "onTap": () {},
    },
    {
      "name": 'Язык',
      "description": 'Изменения языка приложения',
      "icon": Icons.language,
      "onTap": () {},
    },
    {
      "name": 'Обратная связь',
      "description": 'Оставить отзыв, сообщить об ошибке и т.п.',
      "icon": Icons.feedback_outlined,
      "onTap": () {},
    },
  ];

  List<Map<String, dynamic>> animateSettings = [];

  @override
  void initState() {
    super.initState();
    animateSettings = List.from(settings(context: context));
  }

  void _filterSettings(String query) {
    final oldList = List<Map<String, dynamic>>.from(animateSettings);

    if (query.isEmpty) {
      animateSettings = List.from(settings(context: context));
    } else {
      animateSettings = settings(context: context).where((setting) {
        return setting['name'].toString().toLowerCase().contains(
              query.toLowerCase(),
            ) ||
            setting['description'].toString().toLowerCase().contains(
              query.toLowerCase(),
            );
      }).toList();
    }

    final newList = animateSettings;

    for (int i = oldList.length - 1; i >= 0; i--) {
      if (!newList.contains(oldList[i])) {
        _listKey.currentState?.removeItem(
          i,
          (context, animation) => _buildAnimatedItem(oldList[i], animation),
          duration: const Duration(milliseconds: 300),
        );
      }
    }

    for (int i = 0; i < newList.length; i++) {
      if (!oldList.contains(newList[i])) {
        _listKey.currentState?.insertItem(
          i,
          duration: const Duration(milliseconds: 300),
        );
      }
    }
  }

  Widget _buildAnimatedItem(
    Map<String, dynamic> item,
    Animation<double> animation,
  ) {
    return SizeTransition(
      sizeFactor: animation,
      child: _settingsButton(
        name: item['name'],
        description: item['description'],
        onTap: item['onTap'],
        icon: item['icon'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(child: _buildBody()),
            _buildHeader(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        bottom: 18,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
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
      child: Container(
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
                        ((MediaQuery.of(context).size.width * 0.05) + 64)
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
                  hintText: 'Поиск...',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(193, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                ),
                onChanged: (value) {
                  log(value);
                  _filterSettings(value);
                  setState(() {});
                },
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
    );
  }

  Widget _buildBody() {
    return AnimatedList(
      key: _listKey,
      initialItemCount: animateSettings.length,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 100, top: 155),
      itemBuilder: (context, index, animation) {
        return _buildAnimatedItem(animateSettings[index], animation);
      },
    );
  }

  Widget _settingsButton({
    required String name,
    String? description,
    required IconData? icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                  Text(
                    description ?? '',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 212, 212, 212),
                      fontSize: MediaQuery.of(context).size.width * 0.028,
                    ),
                  ),
                ],
              ),
              Icon(
                icon ?? Icons.accessible_forward,
                color: Colors.white,
                size: MediaQuery.of(context).size.width * 0.08,
              ),
            ],
          ),
          Divider(color: const Color.fromARGB(66, 255, 255, 255)),
        ],
      ),
    );
  }
}
