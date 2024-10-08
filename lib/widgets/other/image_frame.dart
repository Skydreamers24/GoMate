import 'package:flutter/material.dart';

class ImageFrame extends StatelessWidget {
  final Widget? image;
  final double aspectRatio;
  final double elevation;
  final ShapeBorder? shape;
  final Color? backgroundColor;
  const ImageFrame(
      {super.key,
      this.image,
      this.aspectRatio = 1.0,
      this.shape,
      this.backgroundColor,
      this.elevation = 0});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Card(
        elevation: elevation,
        clipBehavior: Clip.antiAlias,
        shape: shape,
        color: backgroundColor,
        child: FittedBox(
          fit: BoxFit.cover,
          child: image,
        ),
      ),
    );
  }
}
