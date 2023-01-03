import 'package:flutter/material.dart';
import 'package:what_app/common/extensions/custom_theme_extension.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            color: context.color.greyColor,
            height: 1.3,
          ),
          children: [
            const TextSpan(
              text: 'WhatsApp will need to verify your phone number. ',
            ),
            TextSpan(
              text: "What's my number?",
              style: TextStyle(color: context.color.blueColor),
            ),
          ],
        ),
      ),
    );
  }
}
