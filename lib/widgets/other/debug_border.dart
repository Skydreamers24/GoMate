import 'package:flutter/material.dart';

class DebugBorder extends StatelessWidget {
  final Widget? child;

  const DebugBorder({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      child: child,
    );
  }
}
