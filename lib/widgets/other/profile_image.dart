import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gomate/widgets/other/image_frame.dart';

class ProfileImage extends StatelessWidget {
  final String profileImage;
  const ProfileImage({super.key, required this.profileImage});

  @override
  Widget build(BuildContext context) {
    return ImageFrame(
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
    );
  }
}
