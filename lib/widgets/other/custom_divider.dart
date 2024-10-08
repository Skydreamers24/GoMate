import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1.3,
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.13),
    );
  }
}
