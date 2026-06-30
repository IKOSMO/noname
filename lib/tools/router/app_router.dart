import 'package:auto_route/auto_route.dart';
import 'package:noname/tools/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    CustomRoute(
      page: ChatRoute.page,
      transitionsBuilder: TransitionsBuilders.slideLeft,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
    ),

    AutoRoute(page: ProfileRoute.page),

    AutoRoute(page: AuthRoute.page),
    AutoRoute(page: AuthCodeOtpRoute.page),
    AutoRoute(page: AuthCloudPasswordRoute.page),

    AutoRoute(page: RegistrationRoute.page),
    AutoRoute(page: RegCodeOtpRoute.page),
    AutoRoute(page: RegCloudPasswordRoute.page),

    AutoRoute(page: SettingsNotificationRoute.page),
    AutoRoute(page: SettingsConfidentialityRoute.page),
    AutoRoute(page: SettingsThemeRoute.page),
    AutoRoute(page: SettingsLanguageRoute.page),

    AutoRoute(
      page: HomeRoute.page,
      initial: true,
      children: [
        AutoRoute(page: ChatsRoute.page, initial: true),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
  ];
}
