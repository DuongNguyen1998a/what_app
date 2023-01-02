import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:what_app/common/extensions/custom_theme_extension.dart';

import '../../../common/helpers/show_alert_dialog.dart';
import '../../../common/shared_widgets/custom_elevated_button_widget.dart';
import '../../../common/shared_widgets/custom_icon_button_widget.dart';
import '../../../common/shared_widgets/custom_textfield_widget.dart';
import '../../../common/utils/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController countryNameController = TextEditingController(text: 'Vietmam');
  TextEditingController countryCodeController = TextEditingController(text: '84');
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    countryNameController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  showCountryCodePicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: ['VN'],
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 600,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        flagSize: 22,
        borderRadius: BorderRadius.circular(20),
        textStyle: TextStyle(color: context.color.greyColor!),
        inputDecoration: InputDecoration(
          labelStyle: TextStyle(color: context.color.greyColor),
          prefixIcon: const Icon(
            Icons.language,
            color: AppColors.greenDark,
          ),
          hintText: 'Search country code or name',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: context.color.greyColor!.withOpacity(0.2)),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.greenDark, width: 2),
          ),
        ),
      ),
      onSelect: (code) {
        countryNameController.text = code.name;
        countryCodeController.text = code.phoneCode;
      },
    );
  }

  sendVerificationCodeToPhone() {
    final phoneNumber = phoneNumberController.text;
    final countryCode = countryCodeController.text;
    final countryName = countryNameController.text;

    // check phone number before requesting login
    if (phoneNumber.isEmpty) {
      return showAlertDialog(
        context: context,
        message: 'Please enter your phone number',
      );
    } else if (phoneNumber.length < 9) {
      return showAlertDialog(
        context: context,
        message: 'The phone number you entered is too short for the country: $countryName.\n\n'
            'Include your area code if you haven\'t',
      );
    } else if (phoneNumber.length > 10) {
      return showAlertDialog(
        context: context,
        message: 'The phone number you entered is too long for the country: $countryName.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                onTap: () {
                  showCountryCodePicker();
                },
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
                      onTap: () {
                        showCountryCodePicker();
                      },
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
        onPressed: () {
          sendVerificationCodeToPhone();
        },
        text: 'NEXT',
        width: 90,
      ),
    );
  }
}
