import 'package:flutter/material.dart';

class AutoImage extends StatelessWidget {
  final String image;
  final double cornerRadius;
  const AutoImage({super.key, this.image = "", this.cornerRadius=0});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: FittedBox(
          fit: BoxFit.cover,
          clipBehavior: Clip.antiAlias,
          child: image.isNotEmpty
              ? image.startsWith("https://")
                  ? Image.network(image)
                  : Image.asset(image)
              : Image.asset("assets/blank.png"),
        ),
      ),
    );
  }
}
