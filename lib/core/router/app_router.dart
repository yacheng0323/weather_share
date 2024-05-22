// dart run build_runner watch -d
import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

// dart run build_runner build --delete-conflicting-outputs
@AutoRouterConfig(replaceInRouteName: "Page.Route")
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginPageRoute.page, initial: true),
        AutoRoute(page: RegisterPageRoute.page),
        AutoRoute(page: UserProfileRoute.page),
        AutoRoute(page: ShareHomePageRoute.page),
        AutoRoute(page: PublishPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: ForgotPasswordPageRoute.page),
        AutoRoute(page: ChangePasswordPageRoute.page),
      ];
}
