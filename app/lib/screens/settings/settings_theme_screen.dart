import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../tools/l10n/app_localizations.dart';
import 'components/settings_buttons_widgets.dart';
import 'components/settings_item.dart';
import 'states/settings_state.dart';
import '../../tools/providers/providers.dart';

@RoutePage()
class SettingsThemeScreen extends ConsumerStatefulWidget {
  const SettingsThemeScreen({super.key});

  @override
  ConsumerState<SettingsThemeScreen> createState() =>
      _SettingsThemeScreenState();
}

class _SettingsThemeScreenState extends ConsumerState<SettingsThemeScreen> {
  List<SettingsItem> _settings({
    required BuildContext context,
    required SettingsState state,
  }) {
    final t = AppLocalizations.of(context)!;

    return [
      SettingsGroup(
        title: t.themes_subtitle,
        items: [
          SettingsSwitchButton(
            title: t.light_theme,
            isOn: state.themeMode == ThemeMode.light,
            showChevron: false,
            onChanged: (bool value) {
              ref
                  .read(settingsNotifier.notifier)
                  .changeTheme(value: ThemeMode.light);
            },
          ),
          SettingsSwitchButton(
            title: t.dark_theme,
            isOn: state.themeMode == ThemeMode.dark,
            showChevron: false,
            onChanged: (bool value) {
              ref
                  .read(settingsNotifier.notifier)
                  .changeTheme(value: ThemeMode.dark);
            },
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(settingsNotifier);
    final t = AppLocalizations.of(context)!;

    final settings = _settings(context: context, state: state);

    return Scaffold(
      key: ValueKey(state.themeMode),
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
                  t.themes_title,
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
