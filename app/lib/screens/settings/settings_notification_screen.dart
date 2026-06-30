import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../tools/l10n/app_localizations.dart';
// import 'package:noname/gen/i18n.g.dart';
import 'components/settings_buttons_widgets.dart';
import 'components/settings_item.dart';
import 'states/settings_state.dart';
import '../../tools/providers/providers.dart';

@RoutePage()
class SettingsNotificationScreen extends ConsumerStatefulWidget {
  const SettingsNotificationScreen({super.key});

  @override
  ConsumerState<SettingsNotificationScreen> createState() =>
      _SettingsNotificationScreenState();
}

class _SettingsNotificationScreenState
    extends ConsumerState<SettingsNotificationScreen> {
  List<SettingsItem> _settings({
    required BuildContext context,
    required SettingsState state,
  }) {
    final state = ref.watch(settingsNotifier);
    final t = AppLocalizations.of(context)!;

    return [
      SettingsGroup(
        title: t.notification_of_message_title,
        items: [
          NotificationButton(
            title:
                t.notification_of_message_personal_chats,
            icon: Icons.person_outline_rounded,
            status: 'Вкл.',
            onTap: () {},
          ),
          NotificationButton(
            title: t.notification_of_message_groups,
            icon: Icons.people_outline_rounded,
            status: 'Вкл.',
            onTap: () {},
          ),
          NotificationButton(
            title: t.notification_of_message_channels,
            icon: Icons.campaign_outlined,
            status: 'Вкл.',
            onTap: () {},
          ),
          NotificationButton(
            title: t.notification_of_message_stories,
            icon: Icons.history_toggle_off_rounded,
            status: 'Вкл.',
            onTap: () {},
          ),
          NotificationButton(
            title: t.notification_of_message_reactions,
            icon: Icons.favorite_border_rounded,
            status: 'Вкл.',
            onTap: () {},
          ),
        ],
      ),

      SettingsGroup(
        title: t.notification_in_app_title,
        items: [
          SettingsSwitchButton(
            title: t.notification_in_app_volume,
            isOn: false,
            showChevron: false,
            onChanged: (bool value) {},
          ),
          SettingsSwitchButton(
            title: t.notification_in_app_vibration,
            isOn: false,
            showChevron: false,
            onChanged: (bool value) {},
          ),
          SettingsSwitchButton(
            title: t.notification_in_app_show_text,
            isOn: true,
            showChevron: false,
            onChanged: (bool value) {},
          ),
        ],
      ),

      SettingsSwitchButton(
        title: t.username_in_notification_title,
        isOn: state.isOnNameInNotification,
        onChanged: (bool value) {
          ref
              .read(settingsNotifier.notifier)
              .changeIsOnNameInNotification(value: value);
        },
        description:
            t.username_in_notification_description,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final state = ref.watch(settingsNotifier);
    final settings = _settings(context: context, state: state);
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
                  t.notifications_title,
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
