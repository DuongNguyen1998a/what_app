import 'package:flutter/material.dart';
import 'package:what_app/common/extensions/custom_theme_extension.dart';

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
          color: context.color.circleImageColor,
        ),
      ),
    );
  }
}
