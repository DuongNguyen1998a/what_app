import 'package:flutter/material.dart';

import '../../../../common/shared_widgets/custom_elevated_button_widget.dart';
import '../../../../common/utils/app_colors.dart';
import '../widgets/circle_image_widget.dart';
import '../widgets/language_button_widget.dart';
import '../widgets/privacy_policy_widget.dart';
import '../widgets/welcome_text_widget.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleImageWidget(),
          const SizedBox(height: 45,),
          Expanded(
            child: Column(
              children: [
                const WelcomeTextWidget(),
                const PrivacyPolicyWidget(),
                CustomElevatedButtonWidget(
                  onPressed: () {},
                  text: 'AGREE AND CONTINUE',
                ),
                const SizedBox(height: 50,),
                const LanguageButtonWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
