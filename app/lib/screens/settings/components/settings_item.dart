import 'package:flutter/material.dart';

sealed class SettingsItem {
  const SettingsItem();
}

sealed class BaseSettingsButton extends SettingsItem {
  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool showChevron;

  const BaseSettingsButton({
    required this.title,
    this.icon,
    this.onTap,
    this.showChevron = true,
  });
}

class SettingsButton extends BaseSettingsButton {
  final String? description;
  const SettingsButton({
    required super.title,
    super.icon,
    required super.onTap,
    super.showChevron = true,
    this.description,
  });
}

class SettingsSwitchButton extends BaseSettingsButton {
  final String? description;
  final bool isOn;
  final Function(bool) onChanged;

  const SettingsSwitchButton({
    required super.title,
    super.icon,
    super.onTap,
    super.showChevron = true,
    required this.isOn,
    this.description,
    required this.onChanged,
  });

  SettingsSwitchButton copyWith({required bool isOn}) {
    return SettingsSwitchButton(
      title: title,
      icon: icon,
      onTap: onTap,
      isOn: isOn,
      onChanged: onChanged,
    );
  }
}

class NotificationButton extends BaseSettingsButton {
  final String status;

  const NotificationButton({
    required super.title,
    super.icon,
    required super.onTap,
    super.showChevron = true,
    required this.status,
  });
}

class LanguageButton extends BaseSettingsButton {
  final String language;

  const LanguageButton({
    required super.title,
    super.icon,
    required super.onTap,
    super.showChevron = true,
    required this.language,
  });
}

class SettingsGroup extends SettingsItem {
  final List<BaseSettingsButton> items;
  final String? title;
  const SettingsGroup({required this.items, this.title});
}
