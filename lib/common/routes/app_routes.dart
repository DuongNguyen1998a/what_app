import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/chats_contacts_container.dart';
import '../../features/home/home_page.dart';
import '../../features/login/page/login_page.dart';
import '../../features/user_info/user_info_page.dart';
import '../../features/verification/verification_page.dart';

class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String userInfo = '/user-info';
  static const String verification = '/verification';
  static const String home = '/home';
  static const String chatsContactsContainer = '/chat-contacts';

  static final router = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(
          path: login,
          builder: (context, state) => const LoginPage(),
          redirect: (context, state) {
            if (FirebaseAuth.instance.currentUser != null) {
              return home;
            } else {
              return login;
            }
          }),
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
      GoRoute(
        path: chatsContactsContainer,
        builder: (context, state) {
          return const ChatsContactsContainer();
        }
      ),
    ],
  );
}
