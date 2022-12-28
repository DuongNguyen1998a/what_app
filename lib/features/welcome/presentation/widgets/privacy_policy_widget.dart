import 'package:flutter/material.dart';
import 'package:what_app/common/extensions/custom_theme_extension.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  const PrivacyPolicyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Read our ',
          style: TextStyle(
            color: context.color.greyColor,
            height: 1.5,
          ),
          children: [
            TextSpan(
              text: 'Privacy Policy. ',
              style: TextStyle(
                color: context.color.blueColor,
              ),
            ),
            TextSpan(
              text: 'Tap "Agree and Continue" to accept the ',
              style: TextStyle(
                color: context.color.greyColor,
                height: 1.5,
              ),
            ),
            TextSpan(
              text: 'Terms of Services.',
              style: TextStyle(
                color: context.color.blueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
