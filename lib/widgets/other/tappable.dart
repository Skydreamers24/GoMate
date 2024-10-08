import 'package:flutter/material.dart';

class Tappable extends StatefulWidget {
  const Tappable(
      {super.key,
      this.builder,
      this.onTap,
      this.extendTapEventForMilliseconds = 0,
      this.extendHoverEventForMilliseconds = 0});
  final Widget? Function(bool, bool)? builder;
  final void Function()? onTap;
  final int extendTapEventForMilliseconds;
  final int extendHoverEventForMilliseconds;

  @override
  State<Tappable> createState() => _TappableState();
}

class _TappableState extends State<Tappable> {
  bool isTapped = false;
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTap != null
          ? (details) {
              setState(() {
                isTapped = true;
              });
            }
          : null,
      onTapUp: widget.onTap != null
          ? (details) {
              Future.delayed(
                  Duration(milliseconds: widget.extendTapEventForMilliseconds),
                  () {
                setState(() {
                  isTapped = false;
                });
              });
              widget.onTap!();
            }
          : null,
      onTapCancel: widget.onTap != null
          ? () {
              Future.delayed(
                  Duration(milliseconds: widget.extendTapEventForMilliseconds),
                  () {
                setState(() {
                  isTapped = false;
                });
              });
            }
          : null,
      child: MouseRegion(
        onEnter: widget.onTap != null
            ? (event) {
                setState(() {
                  isHovering = true;
                });
              }
            : null,
        onExit: widget.onTap != null
            ? (event) {
                Future.delayed(
                    Duration(
                        milliseconds: widget.extendHoverEventForMilliseconds),
                    () {
                  setState(() {
                    isHovering = false;
                  });
                });
              }
            : null,
        cursor: isHovering ? SystemMouseCursors.click : MouseCursor.defer,
        child: widget.builder != null
            ? widget.builder!(isTapped, isHovering)
            : null,
      ),
    );
  }
}
