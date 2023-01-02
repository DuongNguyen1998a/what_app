import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:what_app/features/login/page/login_page.dart';
import 'package:what_app/features/verificaction/verification_page.dart';
/// themes
import 'common/themes/dark_theme.dart';
import 'common/themes/light_theme.dart';
import 'features/user_info/user_info_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Clone',
      darkTheme: darkTheme(),
      theme: lightTheme(),
      themeMode: ThemeMode.system,
      home: const UserInfoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
