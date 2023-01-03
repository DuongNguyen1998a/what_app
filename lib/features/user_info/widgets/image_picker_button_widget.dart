import 'package:flutter/material.dart';
import 'package:what_app/common/extensions/custom_theme_extension.dart';

import '../../../common/utils/app_colors.dart';

class ImagePickerButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final String text;

  const ImagePickerButtonWidget({
    Key? key,
    required this.onTap,
    required this.iconData,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: context.color.greyColor!.withOpacity(0.2),
                  width: 1,
                ),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: onTap,
                icon: Icon(iconData),
                padding: EdgeInsets.zero,
                iconSize: 22,
                splashColor: Colors.transparent,
                splashRadius: 22,
                color: AppColors.greenDark,
                constraints: const BoxConstraints(minWidth: 50, minHeight: 50),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              text,
              style: TextStyle(color: context.color.greyColor),
            ),
          ],
        )
      ],
    );
  }
}
