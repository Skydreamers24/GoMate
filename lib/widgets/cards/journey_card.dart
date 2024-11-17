import 'package:flutter/material.dart';
import 'package:gomate/backend/account.dart';
import 'package:gomate/misc/journey.dart';
import 'package:gomate/misc/show_popup.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/widgets/cards/content_card.dart';
import 'package:gomate/widgets/other/auto_image.dart';
import 'package:gomate/widgets/sheets/journey_detail_sheet.dart';

class JourneyCard extends StatelessWidget {
  final Journey journey;
  final List<Widget?> actions;
  final int? maxLines;

  const JourneyCard(
      {super.key, this.journey = const Journey(), this.actions = const [], this.maxLines});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final account = Account.of(context);
    return ContentCard(
        width: double.infinity,
        onTap: showPopup(context,
            sheet: (context) => JourneyDetailSheet(
                  journey: journey,
                )),
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: AutoImage(
                image: journey.image,
                cornerRadius: 20,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: spaciousCardInset,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: journey.name.isNotEmpty
                                ? Text(
                                    journey.name,
                                    textAlign: TextAlign.start,
                                    style: title(context),
                                  )
                                : nothing),
                        Icon(
                          journey.type.icon(),
                          color: lessIntense(textColor(theme), theme),
                        )
                      ],
                    ),
                    journey.location.isNotEmpty
                        ? Text(
                            "@${journey.location}",
                            textAlign: TextAlign.start,
                            style: subheading(context),
                          )
                        : nothing,
                    Text(
                      "${journey.universalStayScore(account.disabilities).toString()} ⭐️",
                      style: subheading(context),
                    ),
                    journey.description.isNotEmpty
                        ? Text(
                            journey.description,
                            textAlign: TextAlign.start,
                            style: body(context),
                            maxLines: maxLines,
                            overflow: TextOverflow.ellipsis,
                          )
                        : nothing,
                    actions.isNotEmpty
                        ? const SizedBox(
                            height: 8,
                          )
                        : nothing,
                    for (final action in actions)
                      action != null
                          ? Padding(
                              padding:
                                  comfortableListChildren.copyWith(left: 0),
                              child: action,
                            )
                          : nothing
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
