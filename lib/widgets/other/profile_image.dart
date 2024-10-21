import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gomate/widgets/other/image_frame.dart';
import 'package:uuid/uuid.dart';

class ProfileImage extends StatelessWidget {
  final String profileImage;
  final String? heroTag;
  const ProfileImage({super.key, this.heroTag, required this.profileImage});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag ?? (const Uuid()).v4(),
      child: ImageFrame(
        elevation: 2,
        aspectRatio: 0.8,
        image: profileImage.isEmpty
            ? Image.asset("assets/whale_avatar.png")
            : profileImage.startsWith("https://")
                ? Image.network(
                    profileImage,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset("assets/whale_avatar.png"),
                  )
                : Image.file(File(profileImage)),
      ),
    );
  }
}
