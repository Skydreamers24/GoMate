import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gomate/backend/account.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/widgets/other/profile_image.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageEditBox extends StatefulWidget {
  const ProfileImageEditBox(
      {super.key,
      required this.profileImage,
      required this.unsetProfileImage,
      required this.onProfileImageChanged});

  final String profileImage;
  final void Function() unsetProfileImage;
  final void Function(String) onProfileImageChanged;

  @override
  State<ProfileImageEditBox> createState() => _ProfileImageEditBoxState();
}

class _ProfileImageEditBoxState extends State<ProfileImageEditBox> {
  @override
  Widget build(BuildContext context) {
    final account = Account.of(context);
    final theme = Theme.of(context);
    return SizedBox(
      width: 221,
      height: 260,
      child: Stack(
        children: [
          Padding(
            padding: comfortable,
            child: ProfileImage(
              heroTag: "profileImage",
              profileImage: widget.profileImage,
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 40,
                height: 40,
                child: IconButton(
                  onPressed: widget.unsetProfileImage,
                  icon: const Icon(Icons.delete_forever),
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(theme.colorScheme.errorContainer),
                      foregroundColor: WidgetStatePropertyAll(theme.colorScheme.onErrorContainer)),
                ),
              )),
          Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 40,
                height: 40,
                child: IconButton.filled(
                  onPressed: () async {
                    var result = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (kIsWeb) {
                      if (result != null) {
                        final storageRef = FirebaseStorage.instance.ref();
                        var profileImageRef =
                            storageRef.child("profileImages/${account.uid}");
                        await profileImageRef
                            .putData(await result.readAsBytes());
                        final downloadURL =
                            await profileImageRef.getDownloadURL();
                        widget.onProfileImageChanged(downloadURL);
                      }
                      return;
                    }
                    if (result != null) {
                      widget.onProfileImageChanged(result.path);
                    }
                  },
                  icon: const Icon(Icons.edit),
                ),
              )),
        ],
      ),
    );
  }
}
