import 'package:flutter/material.dart';
import 'package:gomate/misc/journey.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/pages/page_content.dart';
import 'package:gomate/widgets/other/debug_border.dart';
import 'package:gomate/widgets/other/hero_banner.dart';

class JourneyDetailSheet extends StatelessWidget {
  const JourneyDetailSheet({super.key, this.journey = const Journey()});
  final Journey journey;

  @override
  Widget build(BuildContext context) {
    return DebugBorder(
      child: PageContent.withTitleWidget(
        safeAreaTop: false,
        titlePadding: zero,
        titleWidget: SizedBox(
            height: 200,
            child: HeroBanner(
              image: journey.image,
              title: journey.name,
              subtitle: journey.description,
            )),
        children: [
          Text("We're not going back")
        ],
      ),
    );
  }
}
