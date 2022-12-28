import 'package:flutter/material.dart';
/// themes
import 'common/themes/dark_theme.dart';
import 'common/themes/light_theme.dart';

import 'features/welcome/presentation/page/welcome_page.dart';

void main() {
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
      home: const WelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
