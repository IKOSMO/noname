// file: settings_buttons_widgets.dart.dart

import 'package:flutter/material.dart';
import 'package:noname/screens/settings/components/gradient_icon.dart';
import 'package:noname/screens/settings/components/settings_item.dart';

const Color backgroundColor = Colors.black;
const Color cardColor = Color.fromARGB(255, 34, 34, 34);
const Color dividerColor = Color.fromARGB(62, 255, 255, 255);
const double titleFontSize = 0.04;
const double subtitleFontSize = 0.035;

class SettingsButtonWidget extends StatelessWidget {
  const SettingsButtonWidget({
    super.key,
    this.isFirst = false,
    required this.item,
  });

  final bool isFirst;
  final BaseSettingsButton item;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return InkWell(
      onTap: item.onTap,
      child: Container(
        width: screenWidth,
        color: backgroundColor,
        child: Container(
          margin: EdgeInsets.only(
            top: isFirst ? 20 : 15,
            bottom: 5,
            left: 15,
            right: 15,
          ),
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 15,
            right: 5,
          ),
          width: screenWidth - 30,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: cardColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (item.icon != null) GradientIcon(icon: item.icon!, size: 30),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  item.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: screenWidth * titleFontSize,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (item.showChevron)
                Icon(
                  Icons.chevron_right_rounded,
                  color: dividerColor,
                  size: 30,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsSwitchButtonWidget extends StatelessWidget {
  const SettingsSwitchButtonWidget({
    super.key,
    this.isFirst = false,
    required this.item,
  });

  final bool isFirst;
  final SettingsSwitchButton item;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return InkWell(
      onTap: item.onTap,
      child: Container(
        width: screenWidth,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: isFirst ? 20 : 15,
                bottom: 5,
                left: 15,
                right: 15,
              ),
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 15,
                right: 5,
              ),
              width: screenWidth - 30,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: cardColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (item.icon != null)
                    GradientIcon(icon: item.icon!, size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: screenWidth * titleFontSize,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Switch(
                    value: item.isOn,
                    onChanged: item.onChanged,
                    inactiveThumbColor: dividerColor,
                    trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((
                      states,
                    ) {
                      return dividerColor;
                    }),
                    activeThumbColor: Color(0xFFB68EE2),
                  ),
                ],
              ),
            ),
            if (item.description != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  item.description!,
                  style: TextStyle(
                    color: const Color.fromARGB(122, 255, 255, 255),
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.03,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SettingsButtonsGroupWidget extends StatelessWidget {
  const SettingsButtonsGroupWidget({
    super.key,
    required this.item,
    this.isFirst = false,
  });

  final bool isFirst;
  final SettingsGroup item;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    final List<Widget> items = [];
    for (int i = 0; i < item.items.length; i++) {
      final button = item.items[i];
      final isLast = i == item.items.length - 1;
      items.add(
        _settingsButtonForGroup(
          button: button,
          isLast: isLast,
          screenWidth: screenWidth,
        ),
      );
    }

    if (item.title != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 25,
              top: isFirst ? 20 : 15,
              bottom: 5,
            ),
            child: Text(
              item.title!.toUpperCase(),
              style: TextStyle(
                color: const Color.fromARGB(122, 255, 255, 255),
                fontWeight: FontWeight.w400,
                height: 1.0,
                fontSize: screenWidth * 0.03,
              ),
            ),
          ),
          _buildContainer(
            screenWidth: screenWidth,
            itemHaveTitle: true,
            children: items,
            context: context,
          ),
        ],
      );
    }

    return _buildContainer(
      screenWidth: screenWidth,
      children: items,
      context: context,
    );
  }

  Widget _buildContainer({
    required double screenWidth,
    bool itemHaveTitle = false,
    required List<Widget> children,
    required BuildContext context,
  }) {
    return Container(
      width: screenWidth,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        margin: EdgeInsets.only(
          top: itemHaveTitle
              ? 0
              : isFirst
              ? 20
              : 15,
          bottom: 5,
          left: 15,
          right: 15,
        ),
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 5),
        width: screenWidth - 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: cardColor,
        ),
        child: Column(children: children),
      ),
    );
  }

  Widget _settingsButtonForGroup({
    required BaseSettingsButton button,
    bool isLast = false,
    required double screenWidth,
  }) {
    final trailingStyle = TextStyle(
      color: const Color.fromARGB(122, 255, 255, 255),
      fontWeight: FontWeight.w500,
      fontSize: screenWidth * subtitleFontSize,
    );

    Widget trailingSwitch({required SettingsSwitchButton button}) => Switch(
      value: button.isOn,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onChanged: button.onChanged,
      inactiveThumbColor: dividerColor,
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((states) {
        return dividerColor;
      }),
      activeThumbColor: Color(0xFFB68EE2),
    );

    final trailing = switch (button) {
      NotificationButton() => Text(button.status, style: trailingStyle),
      SettingsSwitchButton() => trailingSwitch(button: button),
      LanguageButton() => Text(button.language, style: trailingStyle),
      SettingsButton() => null,
    };

    return InkWell(
      onTap: button.onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (button.icon != null) ...[
              GradientIcon(icon: button.icon!, size: 30),
              SizedBox(width: 10),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          button.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: screenWidth * titleFontSize,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ?trailing,
                      if (button.showChevron)
                        Icon(
                          Icons.chevron_right_rounded,
                          color: dividerColor,
                          size: 30,
                        ),
                    ],
                  ),
                  if (!isLast) Divider(color: dividerColor, endIndent: 10.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
