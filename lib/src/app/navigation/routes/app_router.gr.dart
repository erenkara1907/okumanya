// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:okumanya/src/app/navigation/routes/empty_routes.dart' as _i1;
import 'package:okumanya/src/app/pages/home/view/home_page.dart' as _i2;
import 'package:okumanya/src/app/pages/home/view/home_page_detail.dart' as _i3;
import 'package:okumanya/src/app/pages/login/view/login_view.dart' as _i4;
import 'package:okumanya/src/app/pages/main/main_page.dart' as _i5;
import 'package:okumanya/src/app/pages/profile/view/profile_page.dart' as _i6;
import 'package:okumanya/src/app/pages/splash/splash_view.dart' as _i7;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    BottomTabAddTransferRouter.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BottomTabAddTransferPage(),
      );
    },
    BottomTabHomeRouter.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BottomTabHomePage(),
      );
    },
    BottomTabProfileRouter.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BottomTabProfilePage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    HomeRouteDetail.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePageDetail(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MainPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ProfilePage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SplashPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.BottomTabAddTransferPage]
class BottomTabAddTransferRouter extends _i8.PageRouteInfo<void> {
  const BottomTabAddTransferRouter({List<_i8.PageRouteInfo>? children})
      : super(
          BottomTabAddTransferRouter.name,
          initialChildren: children,
        );

  static const String name = 'BottomTabAddTransferRouter';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i1.BottomTabHomePage]
class BottomTabHomeRouter extends _i8.PageRouteInfo<void> {
  const BottomTabHomeRouter({List<_i8.PageRouteInfo>? children})
      : super(
          BottomTabHomeRouter.name,
          initialChildren: children,
        );

  static const String name = 'BottomTabHomeRouter';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i1.BottomTabProfilePage]
class BottomTabProfileRouter extends _i8.PageRouteInfo<void> {
  const BottomTabProfileRouter({List<_i8.PageRouteInfo>? children})
      : super(
          BottomTabProfileRouter.name,
          initialChildren: children,
        );

  static const String name = 'BottomTabProfileRouter';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePageDetail]
class HomeRouteDetail extends _i8.PageRouteInfo<void> {
  const HomeRouteDetail({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRouteDetail.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouteDetail';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.MainPage]
class MainRoute extends _i8.PageRouteInfo<void> {
  const MainRoute({List<_i8.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ProfilePage]
class ProfileRoute extends _i8.PageRouteInfo<void> {
  const ProfileRoute({List<_i8.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SplashPage]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}
