import 'package:flutter/material.dart';
import 'package:gomate/misc/journey.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/pages/page_content.dart';
import 'package:gomate/widgets/other/hero_banner.dart';

class JourneyDetailSheet extends StatelessWidget {
  const JourneyDetailSheet({super.key, this.journey = const Journey()});
  final Journey journey;

  @override
  Widget build(BuildContext context) {
    return PageContent.withTitleWidget(
      safeAreaTop: false,
      titlePadding: zero,
      titleWidget: SizedBox(
          height: 200,
          child: HeroBanner(
            image: journey.image,
            title: journey.name,
            titleStyle: heading(context),
            subtitle:
                journey.location.isNotEmpty ? "@${journey.location}" : null,
            subtitleStyle: subheading(context),
          )),
      horizontalAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(),
        journey.description.isNotEmpty ? Text(journey.description) : nothing,
        journey.incompatibleDisabilities.isNotEmpty
            ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.warning_rounded),
                  const Text("Incompatible with")
                ].spacedOut(by: 3, direction: Axis.horizontal),
              )
            : nothing,
        journey.incompatibleDisabilities.isNotEmpty
            ? Wrap(
                children: [
                  for (final disability in journey.incompatibleDisabilities)
                    Chip(
                      avatar: Icon(disability.icon()),
                      label: Text(disability.toString()),
                    ),
                ],
              )
            : nothing
      ],
    );
  }
}
