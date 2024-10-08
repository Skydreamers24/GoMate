import 'package:flutter/material.dart';
import 'package:gomate/widgets/other/image_frame.dart';

class IconListTile extends StatelessWidget {
  const IconListTile(
      {super.key,
      this.imageUrl,
      this.title,
      this.trailing,
      this.iconShape,
      this.onTap,
      this.padding});

  final String? imageUrl;
  final String? title;
  final Widget? trailing;
  final ShapeBorder? iconShape;
  final EdgeInsets? padding;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        contentPadding: padding,
        leading: ImageFrame(
          elevation: 1,
          shape: iconShape,
          image: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset("assets/whale_avatar.png"),
                )
              : Image.asset("assets/whale_avatar.png"),
        ),
        title: Text(title ?? ""),
        trailing: trailing,
      ),
    );
  }
}
