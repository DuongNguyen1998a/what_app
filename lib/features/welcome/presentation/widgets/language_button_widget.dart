import 'package:flutter/material.dart';
import 'package:what_app/common/extensions/custom_theme_extension.dart';

import '../../../../common/utils/app_colors.dart';

class LanguageButtonWidget extends StatelessWidget {
  const LanguageButtonWidget({
    Key? key,
  }) : super(key: key);

  showBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 30,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: context.color.greyColor!.withOpacity(0.2),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(width: 15),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      splashRadius: 22,
                      iconSize: 22,
                      padding: EdgeInsets.zero,
                      splashColor: Colors.transparent,
                      constraints: const BoxConstraints(minWidth: 40),
                      icon: Icon(
                        Icons.close_outlined,
                        color: context.color.greyColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'App Language',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: context.color.greyColor!.withOpacity(0.3),
                  thickness: 0.5,
                ),
                RadioListTile(
                  value: true,
                  groupValue: true,
                  activeColor: AppColors.greenDark,
                  onChanged: (value) {},
                  title: const Text('English'),
                  subtitle: Text(
                    '(phone\'s language)',
                    style: TextStyle(color: context.color.greyColor),
                  ),
                ),
                RadioListTile(
                  value: true,
                  groupValue: false,
                  activeColor: AppColors.greenDark,
                  onChanged: (value) {},
                  title: const Text('አማርኛ'),
                  subtitle: Text(
                    'Amharic',
                    style: TextStyle(color: context.color.greyColor),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.color.langBtnBgColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          showBottomSheet(context);
        },
        borderRadius: BorderRadius.circular(20),
        splashFactory: NoSplash.splashFactory,
        highlightColor: context.color.langBtnHighlightColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.language,
                color: AppColors.greenDark,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'English',
                style: TextStyle(
                  color: AppColors.greenDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.greenDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
