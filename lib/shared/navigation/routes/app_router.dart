import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: HomeRouteDetail.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(
      page: MainRoute.page,
      children: [
        AutoRoute(
          page: BottomTabHomeRouter.page,
          initial: true,
          children: [
            AutoRoute(page: HomeRoute.page, initial: true),
          ],
        ),
        AutoRoute(
          page: BottomTabProfileRouter.page,
          children: [
            AutoRoute(page: ProfileRoute.page, initial: true),
          ],
        ),
      ],
    ),
  ];
}
