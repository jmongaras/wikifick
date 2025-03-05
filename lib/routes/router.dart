import 'package:auto_route/auto_route.dart';
import 'package:wikifick/routes/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Screen')
class AppRouter extends RootStackRouter {

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashScreen.page,initial: true),
    AutoRoute(page: HomeScreen.page),
    AutoRoute(page: LikePostsScreen.page),
    AutoRoute(page: AboutScreen.page),
    AutoRoute(page: LikedPostDetailsScreen.page),
  ];

  @override
  List<AutoRouteGuard> get guards => [];
}