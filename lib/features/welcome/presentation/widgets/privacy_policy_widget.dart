import 'package:flutter/material.dart';

import '../../../../common/utils/app_colors.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  const PrivacyPolicyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          text: 'Read our ',
          style: TextStyle(
            color: AppColors.greyDark,
            height: 1.5,
          ),
          children: [
            TextSpan(
              text: 'Privacy Policy. ',
              style: TextStyle(
                color: AppColors.blueDark,
              ),
            ),
            TextSpan(
                text: 'Tap "Agree and countinue" to accept the '),
            TextSpan(
              text: 'Terms of Services.',
              style: TextStyle(
                color: AppColors.blueDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
