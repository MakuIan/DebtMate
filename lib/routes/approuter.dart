import 'package:go_router/go_router.dart';
import '../ui/login/login_page.dart';

class Approuter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => LoginPage()),
      // GoRoute(path: '/home, builder: (context, state) => HomePage()'),
    ],
  );
}
