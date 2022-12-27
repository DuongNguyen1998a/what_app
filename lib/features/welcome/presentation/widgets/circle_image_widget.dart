import 'package:flutter/material.dart';

import '../../../../common/utils/app_colors.dart';

class CircleImageWidget extends StatelessWidget {
  const CircleImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Image.asset(
          'assets/images/circle.png',
          alignment: Alignment.bottomCenter,
          color: AppColors.greenDark,
        ),
      ),
    );
  }
}
