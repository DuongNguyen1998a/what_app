import 'package:flutter/material.dart';
import 'package:what_app/common/extensions/custom_theme_extension.dart';

import '../../common/shared_widgets/custom_icon_button_widget.dart';
import '../../common/shared_widgets/custom_textfield_widget.dart';

class VerificationPage extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const VerificationPage({
    Key? key,
    required this.phoneNumber,
    required this.verificationId,
  }) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Verify your number',
          style: TextStyle(color: context.color.authAppbarTextColor),
        ),
        centerTitle: true,
        actions: [
          CustomIconButtonWidget(
            onTap: () {},
            // icon: Icons.more_vert,
            icon: Icons.more_vert,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(color: context.color.greyColor, height: 1.5),
                  children: [
                    TextSpan(
                      text: "You've tried to register ${widget.phoneNumber}. wait"
                          "before requesting an SMS or call with your code.  ",
                    ),
                    TextSpan(
                      text: "Wrong number?",
                      style: TextStyle(color: context.color.blueColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: CustomTextFieldWidget(
                hintText: '- - -  - - -',
                fontSize: 30,
                autoFocus: true,
                keyBoardType: TextInputType.number,
                onChanged: (value) {},
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Enter 6-digit code',
              style: TextStyle(color: context.color.greyColor),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Icon(Icons.message, color: context.color.greyColor),
                const SizedBox(width: 20),
                Text(
                  'Resend SMS',
                  style: TextStyle(color: context.color.greyColor),
                ),
              ],
            ),
            Divider(color: context.color.blueColor!.withOpacity(0.2)),
            Row(
              children: [
                Icon(Icons.phone, color: context.color.greyColor),
                const SizedBox(width: 20),
                Text(
                  'Call Me',
                  style: TextStyle(color: context.color.greyColor),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
