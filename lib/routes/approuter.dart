import 'package:debtmate/ui/stats/statspage.dart';
import 'package:go_router/go_router.dart';
import '../ui/login/login_page.dart';
import '../ui/register/register_page.dart';
import '../ui/home/home_page.dart';
import '../ui/verification/verification_loading_screen.dart';

class Approuter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/', builder: (context, state) => HomePage()),
      GoRoute(path: '/login', builder: (context, state) => LoginPage()),
      GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
      GoRoute(path: '/home', builder: (context, state) => HomePage()),
      GoRoute(
        path: '/verificationloading',
        builder: (context, state) {
          final email = state.extra as String?;
          if (email != null) {
            return VerificationLoadingScreen(email: email);
          } else {
            return LoginPage();
          }
        },
      ),
      GoRoute(path: '/stats', builder: (context, state) => Statspage()),
    ],
  );
}
