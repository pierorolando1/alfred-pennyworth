import 'package:alfred/features/auth/pages/loading_page.dart';
import 'package:alfred/features/auth/pages/login_page.dart';
import 'package:alfred/main.dart';
import 'package:go_router/go_router.dart';

final mainRouter = GoRouter(routes: [
  GoRoute(
    path: "/home",
    builder: (context, state) =>
        const MyHomePage(title: 'Flutter Demo Home Page'),
  ),
  GoRoute(
    path: "/",
    builder: (context, state) => const LoadingPage()
  ),
  GoRoute(
    path: "/login",
    builder: (context, state) => const LoginPage(),
  ),
]);
