import 'package:flutter/material.dart';
import 'package:what_app/common/extensions/custom_theme_extension.dart';
import 'package:what_app/common/utils/app_colors.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final TextInputType? keyBoardType;
  final String? prefixText;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final double? fontSize;
  final bool? autoFocus;

  const CustomTextFieldWidget({
    Key? key,
    this.controller,
    this.hintText,
    this.readOnly,
    this.textAlign,
    this.keyBoardType,
    this.prefixText,
    this.onTap,
    this.suffixIcon,
    this.onChanged,
    this.fontSize,
    this.autoFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly ?? false,
      textAlign: textAlign ?? TextAlign.center,
      keyboardType: readOnly == null ? keyBoardType : null,
      onChanged: onChanged,
      autofocus: autoFocus ?? false,
      cursorColor: AppColors.greenDark,
      style: TextStyle(fontSize: fontSize),
      decoration: InputDecoration(
        isDense: true,
        prefixText: prefixText,
        suffix: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(color: context.color.greyColor),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.greenDark),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.greenDark, width: 2),
        ),
      ),
    );
  }
}