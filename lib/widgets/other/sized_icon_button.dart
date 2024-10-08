import 'package:flutter/material.dart';

import 'package:gomate/misc/values.dart';

class SizedIconButton extends StatelessWidget {
  const SizedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.padding = zero,
    this.width = 35,
    this.height = 35,
  });

  final void Function()? onPressed;
  final IconData? icon;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
          onPressed: onPressed,
          style: const ButtonStyle(padding: WidgetStatePropertyAll(zero)),
          child: Padding(
            padding: padding,
            child: Icon(icon),
          )),
    );
  }
}