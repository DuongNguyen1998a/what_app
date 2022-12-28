import 'package:flutter/material.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  final double? width;
  final String text;
  final VoidCallback onPressed;

  const CustomElevatedButtonWidget({
    Key? key,
    this.width,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: width ?? MediaQuery.of(context).size.width - 100,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
        ),
      ),
    );
  }
}
