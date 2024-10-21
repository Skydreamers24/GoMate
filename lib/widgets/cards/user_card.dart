import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gomate/backend/account.dart';
import 'package:gomate/misc/gender.dart';
import 'package:gomate/misc/show_popup.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/pages/edit_profile_page.dart';
import 'package:gomate/widgets/other/image_frame.dart';
import 'package:gomate/widgets/other/profile_image.dart';

class UserCardFront extends StatelessWidget {
  const UserCardFront({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageFrame(
          aspectRatio: 1.588,
          elevation: 10,
          backgroundColor: Colors.blueGrey[600],
          image: SvgPicture.asset("assets/card_face.svg"),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: comfortableCardInset,
            child: Text(
              "Tap to reveal profile",
              style: subheading(context).copyWith(color: Colors.grey[100]),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: comfortableCardInset,
            child: Icon(Icons.person, size: 35, color: Colors.grey[100]),
          ),
        )
      ],
    );
  }
}

class UserCardBack extends StatefulWidget {
  const UserCardBack({super.key, required this.account});
  final AccountData account;

  @override
  State<UserCardBack> createState() => _UserCardBackState();
}

class _UserCardBackState extends State<UserCardBack> {
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final account = Account.of(context);
    final theme = Theme.of(context);
    return Card.outlined(
      elevation: 10,
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.surfaceContainerLowest,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        constraints: const BoxConstraints(maxHeight: 30),
                        child: SvgPicture.asset("assets/logo_text.svg")),
                  ],
                ),
              ),
              Flexible(
                flex: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ProfileImage(
                        heroTag: "profileImage",
                        profileImage: account.profileImage,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: comfortableVertical.copyWith(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              account.name.toLocalizedString(context),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: heading(context),
                            ),
                            account.gender != Gender.ratherNotSay ||
                                    account.age > 0
                                ? Text(
                                    "${account.gender != Gender.ratherNotSay ? account.gender : ""}${account.gender != Gender.ratherNotSay && account.age > 0 ? ", " : ""}${account.age > 0 ? "${account.age}" : ""}",
                                    textAlign: TextAlign.start,
                                    style: subheading(context),
                                  )
                                : nothing,
                            account.email.isNotEmpty
                                ? Text(
                                    account.email,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : nothing,
                            account.phoneNo.isNotEmpty
                                ? Text(
                                    account.phoneNo,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : nothing,
                            const Spacer(),
                            Column(
                              children: [
                                FilledButton.tonalIcon(
                                  onPressed: showNewPage(
                                      context,
                                      EditProfilePage(
                                          account: account, onSave: update)),
                                  label: const Text("Edit"),
                                  icon: const Icon(Icons.edit),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: comfortable,
              child: SizedBox(
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset("assets/logo_square.svg")),
            ),
          )
        ],
      ),
    );
  }
}
