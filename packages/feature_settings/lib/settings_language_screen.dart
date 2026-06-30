import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'components/settings_buttons_widgets.dart';
import 'components/settings_item.dart';
import 'providers/providers.dart';

@RoutePage()
class SettingsLanguageScreen extends ConsumerStatefulWidget {
  const SettingsLanguageScreen({super.key});

  @override
  ConsumerState<SettingsLanguageScreen> createState() =>
      _SettingsThemeScreenState();
}

class _SettingsThemeScreenState extends ConsumerState<SettingsLanguageScreen> {
  List<SettingsItem> _settings({required BuildContext context}) {
    final state = ref.watch(settingsNotifier);
    final notifier = ref.watch(settingsNotifier.notifier);
    final allLocales = notifier.supportedLocales;

    final t = AppLocalizations.of(context)!;

    return [
      SettingsGroup(
        title: t.language_subtitle,
        items: List<BaseSettingsButton>.generate(allLocales.length, (index) {
          return SettingsSwitchButton(
            title: notifier.getLanguageName(allLocales[index].languageCode),
            isOn: state.locale == allLocales[index],
            showChevron: false,
            onChanged: (bool value) {
              ref
                  .read(settingsNotifier.notifier)
                  .changeLocale(value: allLocales[index]);
            },
          );
        }),
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
                  t.language_title,
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
