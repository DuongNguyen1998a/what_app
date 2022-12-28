import 'package:flutter/material.dart';
import 'package:what_app/common/extensions/custom_theme_extension.dart';
import 'package:what_app/common/utils/app_colors.dart';

import '../../../common/shared_widgets/custom_elevated_button_widget.dart';
import '../../../common/shared_widgets/custom_icon_button_widget.dart';
import '../../../common/shared_widgets/custom_textfield_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextEditingController countryNameController = TextEditingController();
    TextEditingController countryCodeController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Enter your phone number',
          style: TextStyle(color: context.color.authAppbarTextColor),
        ),
        centerTitle: true,
        actions: [
          CustomIconButtonWidget(
            onTap: () {},
            icon: Icons.more_vert,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
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
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomTextFieldWidget(
                onTap: () {},
                controller: countryNameController,
                readOnly: true,
                suffixIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.greenDark,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: CustomTextFieldWidget(
                      onTap: () {},
                      controller: countryCodeController,
                      prefixText: ' +',
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextFieldWidget(
                      controller: phoneNumberController,
                      hintText: 'phone number',
                      textAlign: TextAlign.left,
                      autoFocus: true,
                      keyBoardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Carrier charges may apply',
              style: TextStyle(color: context.color.greyColor),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButtonWidget(
        onPressed: () {},
        text: 'NEXT',
        width: 90,
      ),
    );
  }
}
