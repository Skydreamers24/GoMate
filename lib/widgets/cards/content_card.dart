import 'package:flutter/material.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/widgets/other/tappable.dart';

class ContentCard extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final Clip? clipBehavior;
  final EdgeInsets? padding;
  final void Function()? onTap;
  const ContentCard(
      {super.key,
      this.child,
      this.width,
      this.height,
      this.clipBehavior,
      this.padding,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tappable(
      onTap: onTap,
      extendTapEventForMilliseconds: 130,
      builder: (isTapped, isHovering) => AnimatedContainer(
          duration: const Duration(milliseconds: 130),
          curve: Curves.fastOutSlowIn,
          clipBehavior: clipBehavior ?? Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isTapped ? 50 : 20),
              color: isTapped || isHovering
                  ? theme.colorScheme.secondaryContainer
                  : theme.colorScheme.surfaceContainer),
          child: Padding(
            padding: padding ?? zero,
            child: SizedBox(width: width, height: height, child: child),
          )),
    );
  }
}
