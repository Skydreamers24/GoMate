import 'package:flutter/material.dart';
import 'package:gomate/misc/journey.dart';
import 'package:gomate/misc/show_popup.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/pages/page_content.dart';
import 'package:gomate/widgets/cards/content_card.dart';
import 'package:gomate/widgets/cards/journey_card.dart';
import 'package:gomate/widgets/other/chart.dart';
import 'package:gomate/widgets/other/hero_banner.dart';
import 'package:gomate/widgets/other/image_frame.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static List<Widget> widgets(BuildContext context) {
    final theme = Theme.of(context);
    const banners = [
      HeroBanner(
        image:
            "https://hips.hearstapps.com/hmg-prod/images/plant-guide-1663941701.jpg",
        title: "Plants",
        padding: spacious,
      ),
      HeroBanner(
        image:
            "https://idthefuture.com/wp-content/uploads/sites/4/2023/07/humpback-whale-flipper-scaled.jpg",
        title: "Whale",
        padding: spacious,
      ),
      HeroBanner(
        image:
            "http://www.baltana.com/files/wallpapers-2/Cute-Cat-Images-07756.jpg",
        title: "Cat",
        padding: spacious,
      )
    ];
    return [
      SizedBox(
        height: 200,
        child: CarouselView.weighted(
            flexWeights: const [3, 2, 1],
            children: banners,
            onTap: (index) => showPopup(context,
                sheet: (context) => SizedBox(
                      height: 400,
                      child: banners[index],
                    ))()),
      ),
      ContentCard(
        height: 180,
        child: Padding(
          padding: comfortable,
          child: CustomPieChart(
            color: Colors.purple,
            otherColor: theme.isLightMode
                ? darker(theme.colorScheme.surfaceContainerHighest)
                : lighter(theme.colorScheme.surfaceContainerHighest),
            data: const [("Data1", 30), ("Data2", 20), ("Data3", 10)],
          ),
        ),
      ),
      const JourneyCard(
        journey: Journey(
            name: "Shopping",
            description: "Shout out to capitalism",
            image:
                "https://a.cdn-hotels.com/gdcs/production116/d593/d4e5cbfe-6d65-4abd-851b-222ff95a3b66.jpg",
            type: JourneyType.activity),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PageContent(
      title: "Home",
      trailing: IconButton.outlined(
          onPressed: () {
            showAboutDialog(
                context: context,
                applicationName: "GoMate",
                applicationVersion: "1.0",
                useRootNavigator: false,
                applicationIcon: SizedBox(
                    width: 90,
                    height: 90,
                    child: ImageFrame(
                      shape: const CircleBorder(),
                      image: Image.asset("assets/app_icons/web_192.png"),
                    )));
          },
          icon: const Icon(Icons.info_outline)),
      children: widgets(context),
    );
  }
}
