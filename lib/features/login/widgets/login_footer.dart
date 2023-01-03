import 'package:flutter/material.dart';
import 'package:what_app/common/extensions/custom_theme_extension.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Carrier charges may apply',
      style: TextStyle(color: context.color.greyColor),
    );
  }
}
