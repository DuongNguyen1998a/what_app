import 'package:flutter/material.dart';

class CustomIconButtonWidget extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;
  final VoidCallback? onTap;
  final double? minWidth;
  final BoxBorder? border;
  final Color? background;
  const CustomIconButtonWidget({
    Key? key,
    required this.icon,
    this.iconColor,
    this.iconSize,
    this.onTap,
    this.minWidth,
    this.border,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: border,
      ),
      child: IconButton(
        onPressed: onTap,
        splashColor: Colors.transparent,
        splashRadius: iconSize ?? 22,
        iconSize: iconSize ?? 22,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(minWidth: minWidth ?? 40, minHeight: minWidth ?? 40),
        icon: Icon(
          icon,
          color: iconColor ?? Theme.of(context).appBarTheme.iconTheme!.color,
        ),
      ),
    );
  }
}