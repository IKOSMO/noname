import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:variable_blur/variable_blur.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _buildHeader(),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 1.2,
      child: Stack(
        children: [
          Positioned.fill(
            child: VariableBlur(
              sigma: 14.0,
              blurSides: BlurSides.vertical(top: 0.0, bottom: 0.4),
              quality: BlurQuality.high,
              isYFlipNeed: true,
              child: Image.asset('assets/images/person.png', fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 15,
            right: 15,
            left: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => context.router.pop(),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      // gradient: const LinearGradient(
                      //   colors: [
                      //     Color.fromARGB(120, 146, 228, 194),
                      //     Color.fromARGB(120, 182, 142, 226),
                      //   ],
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      // ),
                      color: const Color.fromARGB(100, 0, 0, 0),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/images/arrow_back.svg',
                      height: 40,
                    ),
                  ),
                ),
                InkWell(
                  // onTap: () => context.router.pop(),
                  child: Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      // gradient: const LinearGradient(
                      //   colors: [
                      //     Color.fromARGB(120, 146, 228, 194),
                      //     Color.fromARGB(120, 182, 142, 226),
                      //   ],
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      // ),
                      color: const Color.fromARGB(100, 0, 0, 0),
                      borderRadius: BorderRadius.circular(25),
                    ),
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
          Positioned(
            bottom: 15,
            left: 15,
            right: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Алексей Грумцин',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width * 0.065,
                          height: 1,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Text(
                  'был(а) недавно',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: _buttonMenu(
                        text: 'звонок',
                        icon: Icons.call,
                        onTap: () {},
                        iconSize: 25,
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: _buttonMenu(
                        text: 'видео',
                        icon: Icons.videocam,
                        onTap: () {},
                        iconSize: 25,
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: _buttonMenu(
                        text: 'звук',
                        icon: Icons.notifications,
                        onTap: () {},
                        iconSize: 25,
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: _buttonMenu(
                        text: 'поиск',
                        icon: Icons.search,
                        onTap: () {},
                        iconSize: 25,
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: _buttonMenu(
                        text: 'ещё',
                        icon: Icons.more_horiz,
                        onTap: () {},
                        iconSize: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonMenu({
    required String text,
    required IconData icon,
    required double iconSize,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        margin: EdgeInsets.only(),
        decoration: BoxDecoration(
          color: const Color.fromARGB(71, 0, 0, 0),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: iconSize),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildAccountInformation(),
      ],
    );
  }

  Widget _buildAccountInformation() {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      width: MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color.fromARGB(255, 34, 34, 34),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'мобильный',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: MediaQuery.of(context).size.width * 0.025,
            ),
          ),
          Text(
            '+7 963 849 1045',
            style: TextStyle(color: const Color.fromARGB(255, 182, 142, 226)),
          ),
          Divider(color: const Color.fromARGB(20, 255, 255, 255)),
          Text(
            'имя пользователя',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: MediaQuery.of(context).size.width * 0.025,
            ),
          ),
          Text(
            '@alekse',
            style: TextStyle(color: const Color.fromARGB(255, 182, 142, 226)),
          ),
          Divider(color: const Color.fromARGB(20, 255, 255, 255)),
          Text(
            'дата рождения',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: MediaQuery.of(context).size.width * 0.025,
            ),
          ),
          Text(
            '25 апреля',
            style: TextStyle(color: const Color.fromARGB(255, 182, 142, 226)),
          ),
        ],
      ),
    );
  }
}
