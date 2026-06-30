import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../tools/providers/providers.dart';
import '../../tools/router/app_router.gr.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TabsRouter? _tabsRouter;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        final tabs = _tabsRouter;
        log('${tabs?.activeIndex}');
        if (tabs != null && tabs.activeIndex != 0) {
          tabs.setActiveIndex(0);
          return;
        }
      },
      child: AutoTabsScaffold(
        routes: const [ChatsRoute(), SettingsRoute()],
        extendBody: true,
        backgroundColor: Colors.black,
        bottomNavigationBuilder: (_, tabsRouter) {
          _tabsRouter = tabsRouter;
          return _NavigationBar(tabsRouter: tabsRouter);
        },
      ),
    );
  }
}

class _NavigationBar extends ConsumerWidget {
  const _NavigationBar({required this.tabsRouter});

  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSlide(
      offset: Offset(0, 0),
      duration: Duration(milliseconds: 300),
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 10,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(200, 146, 228, 194),
                    Color.fromARGB(200, 182, 142, 226),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  _NavIcon(
                    icon: "assets/images/chat_1.svg",
                    selected: tabsRouter.activeIndex == 0,
                    onTap: () {
                      if (tabsRouter.activeIndex == 0) {
                        ref.read(chatsScreenNotifier.notifier).scrollToTop();
                        return;
                      }
                      tabsRouter.setActiveIndex(0);
                    },
                  ),
                  const SizedBox(width: 15),
                  // _NavIcon(
                  //   icon: Icons.call,
                  //   selected: tabsRouter.activeIndex == 1,
                  //   onTap: () => tabsRouter.setActiveIndex(1),
                  // ),
                  // const SizedBox(width: 15),
                  _NavIcon(
                    icon: "assets/images/settings.svg",
                    selected: tabsRouter.activeIndex == 1,
                    onTap: () => tabsRouter.setActiveIndex(1),
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

class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      child: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          selected ? Colors.white : Colors.white.withValues(alpha: 0.5),
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
