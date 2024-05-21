// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:weather_share/feature/account/account_page.dart' as _i1;
import 'package:weather_share/feature/account/change_password/persentation/change_password_page.dart'
    as _i2;
import 'package:weather_share/feature/account/user_profile/presentation/user_profile.dart'
    as _i8;
import 'package:weather_share/feature/forgotpassword/presentation/forgot_password_page.dart'
    as _i3;
import 'package:weather_share/feature/login/presentation/login_page.dart'
    as _i4;
import 'package:weather_share/feature/publish/presentation/publish_page.dart'
    as _i5;
import 'package:weather_share/feature/register/presentation/register_page.dart'
    as _i6;
import 'package:weather_share/feature/sharehome/presentation/share_home_page.dart'
    as _i7;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    AccountPageRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AccountPage(),
      );
    },
    ChangePasswordPageRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ChangePasswordPage(),
      );
    },
    ForgotPasswordPageRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ForgotPasswordPage(),
      );
    },
    LoginPageRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    PublishPageRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.PublishPage(),
      );
    },
    RegisterPageRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.RegisterPage(),
      );
    },
    ShareHomePageRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ShareHomePage(),
      );
    },
    UserProfileRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.UserProfile(),
      );
    },
  };
}

/// generated route for
/// [_i1.AccountPage]
class AccountPageRoute extends _i9.PageRouteInfo<void> {
  const AccountPageRoute({List<_i9.PageRouteInfo>? children})
      : super(
          AccountPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountPageRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ChangePasswordPage]
class ChangePasswordPageRoute extends _i9.PageRouteInfo<void> {
  const ChangePasswordPageRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ChangePasswordPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordPageRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ForgotPasswordPage]
class ForgotPasswordPageRoute extends _i9.PageRouteInfo<void> {
  const ForgotPasswordPageRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ForgotPasswordPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordPageRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginPage]
class LoginPageRoute extends _i9.PageRouteInfo<void> {
  const LoginPageRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LoginPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginPageRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PublishPage]
class PublishPageRoute extends _i9.PageRouteInfo<void> {
  const PublishPageRoute({List<_i9.PageRouteInfo>? children})
      : super(
          PublishPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'PublishPageRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.RegisterPage]
class RegisterPageRoute extends _i9.PageRouteInfo<void> {
  const RegisterPageRoute({List<_i9.PageRouteInfo>? children})
      : super(
          RegisterPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterPageRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ShareHomePage]
class ShareHomePageRoute extends _i9.PageRouteInfo<void> {
  const ShareHomePageRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ShareHomePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShareHomePageRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.UserProfile]
class UserProfileRoute extends _i9.PageRouteInfo<void> {
  const UserProfileRoute({List<_i9.PageRouteInfo>? children})
      : super(
          UserProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
