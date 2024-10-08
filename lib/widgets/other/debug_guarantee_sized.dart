import 'package:flutter/material.dart';

class DebugGuaranteeSized extends StatelessWidget {
  const DebugGuaranteeSized({super.key, this.child});

  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 500,
      child: child,
    );
  }
}