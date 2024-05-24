// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/cupertino.dart' as _i11;
import 'package:weather_share/feature/account/account_page.dart' as _i1;
import 'package:weather_share/feature/account/change_password/persentation/change_password_page.dart'
    as _i2;
import 'package:weather_share/feature/account/manage_article/presentation/manage_article.dart'
    as _i5;
import 'package:weather_share/feature/account/user_profile/presentation/user_profile.dart'
    as _i9;
import 'package:weather_share/feature/forgotpassword/presentation/forgot_password_page.dart'
    as _i3;
import 'package:weather_share/feature/login/presentation/login_page.dart'
    as _i4;
import 'package:weather_share/feature/publish/presentation/publish_page.dart'
    as _i6;
import 'package:weather_share/feature/register/presentation/register_page.dart'
    as _i7;
import 'package:weather_share/feature/sharehome/domain/share_home_view_model.dart'
    as _i12;
import 'package:weather_share/feature/sharehome/presentation/share_home_page.dart'
    as _i8;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    AccountPageRoute.name: (routeData) {
      final args = routeData.argsAs<AccountPageRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AccountPage(
          key: args.key,
          shareHomeViewModel: args.shareHomeViewModel,
        ),
      );
    },
    ChangePasswordPageRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ChangePasswordPage(),
      );
    },
    ForgotPasswordPageRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ForgotPasswordPage(),
      );
    },
    LoginPageRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    ManageArticleRoute.name: (routeData) {
      final args = routeData.argsAs<ManageArticleRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.ManageArticle(
          key: args.key,
          shareHomeViewModel: args.shareHomeViewModel,
        ),
      );
    },
    PublishPageRoute.name: (routeData) {
      final args = routeData.argsAs<PublishPageRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.PublishPage(
          key: args.key,
          shareHomeViewModel: args.shareHomeViewModel,
        ),
      );
    },
    RegisterPageRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.RegisterPage(),
      );
    },
    ShareHomePageRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.ShareHomePage(),
      );
    },
    UserProfileRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.UserProfile(),
      );
    },
  };
}

/// generated route for
/// [_i1.AccountPage]
class AccountPageRoute extends _i10.PageRouteInfo<AccountPageRouteArgs> {
  AccountPageRoute({
    _i11.Key? key,
    required _i12.ShareHomeViewModel shareHomeViewModel,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          AccountPageRoute.name,
          args: AccountPageRouteArgs(
            key: key,
            shareHomeViewModel: shareHomeViewModel,
          ),
          initialChildren: children,
        );

  static const String name = 'AccountPageRoute';

  static const _i10.PageInfo<AccountPageRouteArgs> page =
      _i10.PageInfo<AccountPageRouteArgs>(name);
}

class AccountPageRouteArgs {
  const AccountPageRouteArgs({
    this.key,
    required this.shareHomeViewModel,
  });

  final _i11.Key? key;

  final _i12.ShareHomeViewModel shareHomeViewModel;

  @override
  String toString() {
    return 'AccountPageRouteArgs{key: $key, shareHomeViewModel: $shareHomeViewModel}';
  }
}

/// generated route for
/// [_i2.ChangePasswordPage]
class ChangePasswordPageRoute extends _i10.PageRouteInfo<void> {
  const ChangePasswordPageRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ChangePasswordPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordPageRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ForgotPasswordPage]
class ForgotPasswordPageRoute extends _i10.PageRouteInfo<void> {
  const ForgotPasswordPageRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ForgotPasswordPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordPageRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginPage]
class LoginPageRoute extends _i10.PageRouteInfo<void> {
  const LoginPageRoute({List<_i10.PageRouteInfo>? children})
      : super(
          LoginPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginPageRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ManageArticle]
class ManageArticleRoute extends _i10.PageRouteInfo<ManageArticleRouteArgs> {
  ManageArticleRoute({
    _i11.Key? key,
    required _i12.ShareHomeViewModel shareHomeViewModel,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          ManageArticleRoute.name,
          args: ManageArticleRouteArgs(
            key: key,
            shareHomeViewModel: shareHomeViewModel,
          ),
          initialChildren: children,
        );

  static const String name = 'ManageArticleRoute';

  static const _i10.PageInfo<ManageArticleRouteArgs> page =
      _i10.PageInfo<ManageArticleRouteArgs>(name);
}

class ManageArticleRouteArgs {
  const ManageArticleRouteArgs({
    this.key,
    required this.shareHomeViewModel,
  });

  final _i11.Key? key;

  final _i12.ShareHomeViewModel shareHomeViewModel;

  @override
  String toString() {
    return 'ManageArticleRouteArgs{key: $key, shareHomeViewModel: $shareHomeViewModel}';
  }
}

/// generated route for
/// [_i6.PublishPage]
class PublishPageRoute extends _i10.PageRouteInfo<PublishPageRouteArgs> {
  PublishPageRoute({
    _i11.Key? key,
    required _i12.ShareHomeViewModel shareHomeViewModel,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          PublishPageRoute.name,
          args: PublishPageRouteArgs(
            key: key,
            shareHomeViewModel: shareHomeViewModel,
          ),
          initialChildren: children,
        );

  static const String name = 'PublishPageRoute';

  static const _i10.PageInfo<PublishPageRouteArgs> page =
      _i10.PageInfo<PublishPageRouteArgs>(name);
}

class PublishPageRouteArgs {
  const PublishPageRouteArgs({
    this.key,
    required this.shareHomeViewModel,
  });

  final _i11.Key? key;

  final _i12.ShareHomeViewModel shareHomeViewModel;

  @override
  String toString() {
    return 'PublishPageRouteArgs{key: $key, shareHomeViewModel: $shareHomeViewModel}';
  }
}

/// generated route for
/// [_i7.RegisterPage]
class RegisterPageRoute extends _i10.PageRouteInfo<void> {
  const RegisterPageRoute({List<_i10.PageRouteInfo>? children})
      : super(
          RegisterPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterPageRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.ShareHomePage]
class ShareHomePageRoute extends _i10.PageRouteInfo<void> {
  const ShareHomePageRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ShareHomePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShareHomePageRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i9.UserProfile]
class UserProfileRoute extends _i10.PageRouteInfo<void> {
  const UserProfileRoute({List<_i10.PageRouteInfo>? children})
      : super(
          UserProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
