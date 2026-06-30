import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../extensions/string_extensions.dart';
import '../../tools/l10n/app_localizations.dart';
// import 'package:noname/gen/i18n.g.dart';
import 'components/gradient_text.dart';
import 'components/settings_buttons_widgets.dart';
import 'components/settings_item.dart';
import 'states/user_data_state.dart';
import '../../tools/providers/providers.dart';
import '../../tools/router/app_router.gr.dart';

@RoutePage()
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final ScrollController _scrollController = ScrollController();

  static const double headerHeightRatio = 0.17;
  static const double blurHeightRatio = 0.14;

  static const Color backgroundColor = Colors.black;

  static const double fullnameFontSize = 0.065;
  static const double titleFontSize = 0.04;
  static const double subtitleFontSize = 0.035;

  final _isPinned = ValueNotifier<bool>(false);
  final _offsetName = ValueNotifier<double>(15.0);

  List<SettingsItem> _settings({required BuildContext context}) {
    final t = AppLocalizations.of(context)!;
    final state = ref.watch(settingsNotifier);
    final notifier = ref.watch(settingsNotifier.notifier);

    return [
      SettingsButton(
        title: t.change_image,
        icon: Icons.add_a_photo_outlined,
        showChevron: false,
        onTap: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return DraggableScrollableSheet(
                initialChildSize: 0.6,
                minChildSize: 0.6,
                maxChildSize: 0.9,
                expand: false,
                snap: true,
                snapSizes: [0.6, 0.9],
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Stack(
                      children: [
                        GridView.builder(
                          controller: scrollController,
                          padding: EdgeInsets.only(top: 70),
                          itemCount: 30,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 1.0,
                                mainAxisSpacing: 1.0,
                                childAspectRatio: 1.0,
                              ),
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.blue[100],
                              child: Center(child: Text('Элемент $index')),
                            );
                          },
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(41, 0, 0, 0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      SettingsButton(
        title: t.favourites,
        icon: Icons.bookmark_outline,
        showChevron: false,
        onTap: () {},
      ),
      SettingsGroup(
        items: [
          NotificationButton(
            title: t.notifications_title,
            icon: Icons.notifications_none,
            status: 'Все',
            onTap: () => context.router.push(SettingsNotificationRoute()),
          ),
          SettingsButton(
            title: t.confidentiality_title,
            icon: Icons.lock_outline,
            onTap: () => context.router.push(SettingsConfidentialityRoute()),
          ),
          SettingsButton(
            title: t.memory,
            icon: Icons.storage_rounded,
            onTap: () {},
          ),
          SettingsButton(
            title: t.themes_title,
            icon: Icons.style_outlined,
            onTap: () => context.router.push(SettingsThemeRoute()),
          ),
          LanguageButton(
            title: t.language_title,
            icon: Icons.language,
            language: notifier.getLanguageName(state.locale.languageCode),
            onTap: () => context.router.push(SettingsLanguageRoute()),
          ),
        ],
      ),
      SettingsButton(
        title: t.support,
        icon: Icons.support_agent_rounded,
        showChevron: false,
        onTap: () {},
      ),
    ];
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    final pixels = _scrollController.position.pixels;
    final screenHeight = MediaQuery.sizeOf(context).height;

    _offsetName.value = 15 + (pixels / 1.3);
    _isPinned.value = pixels >= screenHeight * 0.3;
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollListener);
    _scrollController.dispose();

    _isPinned.dispose();
    _offsetName.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final userState = ref.watch(userDataNotifier);
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenPaddingTop = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox.expand(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _buildBody(
              userState: userState,
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),

            ValueListenableBuilder<bool>(
              valueListenable: _isPinned,
              builder: (context, isPinned, child) {
                return AnimatedPositioned(
                  top: isPinned ? 0 : -screenHeight * headerHeightRatio,
                  duration: const Duration(milliseconds: 200),
                  child: child!,
                );
              },
              child: ShaderMask(
                shaderCallback: (boudns) {
                  return LinearGradient(
                    colors: [
                      const Color.fromARGB(200, 0, 0, 0),
                      const Color.fromARGB(150, 0, 0, 0),
                      const Color.fromARGB(130, 0, 0, 0),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.3, 0.5, 0.7, 1.0],
                  ).createShader(boudns);
                },
                child: Container(
                  color: Colors.white,
                  height: screenHeight * headerHeightRatio,
                ),
              ),
            ),

            ValueListenableBuilder<bool>(
              valueListenable: _isPinned,
              builder: (context, isPinned, child) {
                return AnimatedPositioned(
                  top: isPinned ? 0 : -screenHeight * blurHeightRatio,
                  left: 0,
                  right: 0,
                  duration: Duration(milliseconds: 200),
                  child: child!,
                );
              },
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: const Color.fromARGB(0, 0, 0, 0),
                    height: screenHeight * blurHeightRatio,
                  ),
                ),
              ),
            ),

            Positioned(
              top: screenPaddingTop + 15,
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
                      child: const Icon(
                        Icons.qr_code_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: _isPinned,
                      builder: (context, isPinned, child) {
                        return AnimatedOpacity(
                          opacity: isPinned ? 1 : 0,
                          duration: Duration(milliseconds: 200),
                          child: child!,
                        );
                      },
                      child: Text(
                        userState.user.username,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * titleFontSize,
                          height: 1,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
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
                        t.settings_edit,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth * titleFontSize,
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

  Widget _buildBody({
    required UserDataState userState,
    required double screenHeight,
    required double screenWidth,
  }) {
    final settings = _settings(context: context);

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          surfaceTintColor: Colors.transparent,
          expandedHeight: screenHeight * 0.5,
          pinned: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/images/person.png', fit: BoxFit.cover),
                ValueListenableBuilder<double>(
                  valueListenable: _offsetName,
                  builder: (context, offset, child) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: _isPinned,
                      builder: (context, isPinned, child) {
                        return Transform.translate(
                          offset: Offset(
                            0,
                            isPinned ? screenHeight * 0.2 : -offset + 30,
                          ),
                          child: child!,
                        );
                      },
                      child: ShaderMask(
                        shaderCallback: (boudns) {
                          return LinearGradient(
                            colors: [
                              const Color.fromARGB(130, 0, 0, 0),
                              const Color.fromARGB(80, 0, 0, 0),
                              const Color.fromARGB(50, 0, 0, 0),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.3, 0.5, 0.7, 1.0],
                          ).createShader(boudns);
                        },
                        child: Container(
                          color: Colors.white,
                          height: screenHeight * 0.2,
                        ),
                      ),
                    );
                  },
                ),

                ValueListenableBuilder<double>(
                  valueListenable: _offsetName,
                  builder: (context, offset, child) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: _isPinned,
                      builder: (context, isPinned, child) {
                        return Transform.translate(
                          offset: Offset(
                            0,
                            isPinned ? screenHeight * 0.2 : -offset,
                          ),
                          child: child!,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    userState.user.fullname ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: screenWidth * fullnameFontSize,
                                      height: 1,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            Row(
                              children: [
                                GradientText(
                                  text: '@${userState.user.username}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: screenWidth * titleFontSize,
                                    height: 1.2,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '•',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: screenWidth * subtitleFontSize,
                                    height: 1.2,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  userState.user.phoneNumber.formattedPhone,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: screenWidth * subtitleFontSize,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.paddingOf(context).bottom + 50,
          ),
          sliver: SliverList.builder(
            itemCount: settings.length,
            itemBuilder: ((context, index) {
              final item = settings[index];

              return switch (item) {
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
        ),
      ],
    );
  }
}
