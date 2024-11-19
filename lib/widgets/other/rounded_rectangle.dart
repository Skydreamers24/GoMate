import 'package:flutter/material.dart';
import 'package:gomate/misc/values.dart';

class RoundedRectangle extends StatelessWidget {
  const RoundedRectangle({
    super.key,
    this.color,
    this.cornerRadius = 10,
    this.padding = zero,
    this.child,
  });

  final Color? color;
  final double cornerRadius;
  final Widget? child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(cornerRadius), color: color),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}