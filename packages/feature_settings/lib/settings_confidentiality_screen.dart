import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core/l10n/app_localizations.dart';
import 'components/settings_buttons_widgets.dart';
import 'components/settings_item.dart';

import 'providers/providers.dart';

@RoutePage()
class SettingsConfidentialityScreen extends ConsumerStatefulWidget {
  const SettingsConfidentialityScreen({super.key});

  @override
  ConsumerState<SettingsConfidentialityScreen> createState() =>
      _SettingsNotificationScreenState();
}

class _SettingsNotificationScreenState
    extends ConsumerState<SettingsConfidentialityScreen> {
  List<SettingsItem> _settings({required BuildContext context}) {
    final t = AppLocalizations.of(context)!;
    
    return [
      SettingsGroup(
        items: [
          SettingsButton(
            title: t.black_list,
            icon: Icons.block_rounded,
            onTap: () {},
          ),
          SettingsButton(
            title: t.cloud_password,
            icon: Icons.lock_outline_rounded,
            onTap: () {},
          ),
          SettingsButton(
            title: t.auto_delete_messages,
            icon: Icons.timer_outlined,
            onTap: () {},
          ),
        ],
      ),

      SettingsSwitchButton(
        title: t.button_sos_title,
        isOn: false,
        onChanged: (bool value) {
          ref
              .read(settingsNotifier.notifier)
              .changeIsOnNameInNotification(value: value);
        },
        description: t.button_sos_description,
      ),

      SettingsGroup(
        title: t.confidentiality_title,
        items: [
          SettingsButton(
            title: t.phone_number,
            onTap: () {},
          ),
          SettingsButton(
            title: t.entry_time,
            onTap: () {},
          ),
          SettingsButton(
            title: t.profile_images,
            onTap: () {},
          ),
          SettingsButton(
            title: t.groups_and_channels,
            onTap: () {},
          ),
          SettingsButton(
            title: t.date_of_birthday,
            onTap: () {},
          ),
        ],
      ),

      SettingsButton(
        title: t.login_email,
        icon: Icons.alternate_email_rounded,
        onTap: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final settings = _settings(context: context);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.paddingOf(context).top + 10),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(160, 0, 0, 0),
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                title: Text(
                  t.confidentiality_title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.sizeOf(context).width * 0.05,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                centerTitle: true,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: settings.length,
        itemBuilder: ((context, index) {
          final item = settings[index];
          return switch (item) {
            SettingsSwitchButton() => SettingsSwitchButtonWidget(
              item: item,
              isFirst: index == 0,
            ),
            BaseSettingsButton() => SettingsButtonWidget(
              item: item,
              isFirst: index == 0,
            ),
            SettingsGroup() => SettingsButtonsGroupWidget(
              item: item,
              isFirst: index == 0,
            ),
          };
        }),
      ),
    );
  }
}
