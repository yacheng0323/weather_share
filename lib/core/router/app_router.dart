// dart run build_runner watch -d
import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "Page.Route")
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginPageRoute.page, initial: true),
        AutoRoute(page: RegisterPageRoute.page),
        AutoRoute(page: HomePageRoute.page)
      ];
}
