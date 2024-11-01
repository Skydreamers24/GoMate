import 'package:flutter/material.dart';
import 'package:gomate/misc/journey.dart';
import 'package:gomate/misc/show_popup.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/pages/page_content.dart';
import 'package:gomate/widgets/cards/content_card.dart';
import 'package:gomate/widgets/other/auto_image.dart';
import 'package:gomate/widgets/sheets/journey_detail_sheet.dart';

class JourneyCard extends StatelessWidget {
  final Journey journey;

  const JourneyCard({super.key, this.journey = const Journey()});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                          journey.icon,
                          color: lessIntense(textColor(theme), theme),
                        )
                      ],
                    ),
                    journey.description.isNotEmpty
                        ? Text(
                            journey.description,
                            textAlign: TextAlign.start,
                            style: body(context),
                          )
                        : nothing,
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
