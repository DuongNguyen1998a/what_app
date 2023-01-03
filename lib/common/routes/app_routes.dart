import 'package:go_router/go_router.dart';
import 'package:what_app/features/home/home_page.dart';

import '../../features/login/page/login_page.dart';
import '../../features/user_info/user_info_page.dart';
import '../../features/verification/verification_page.dart';

class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String userInfo = '/user-info';
  static const String verification = '/verification';
  static const String home = '/home';

  static final router = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: userInfo,
        builder: (context, state) => const UserInfoPage(),
      ),
      GoRoute(
        path: verification,
        builder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          return VerificationPage(
            phoneNumber: params['phone'],
            verificationId: params['verificationId'],
          );
        },
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
