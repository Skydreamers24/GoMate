import 'package:flutter/material.dart';
import 'package:gomate/misc/journey.dart';
import 'package:gomate/misc/show_popup.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/pages/page_content.dart';
import 'package:gomate/pages/questionaire_page.dart';
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
            "https://images.ctfassets.net/hszr9c7mxtcf/Xz4EXWX6uFfbHDPflX70e/46a43ff7407cdbde0fb1a929188928ef/guide_dog.jpg?w=1200&h=675&fl=progressive&q=50&fm=jpg",
        title: "Guide dog support",
        padding: spacious,
      ),
      HeroBanner(
        image:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Mantelb%C3%B6gen.JPG/1200px-Mantelb%C3%B6gen.JPG",
        title: "Assistance Request Form",
        padding: spacious,
      ),
      HeroBanner(
        image:
            "https://lh3.googleusercontent.com/zGNhMbYp2REhC5aW96QcqHy7_NEq815M4fOWnzwmA5xHpUdpzIPnETyC4lI4_JjCbCuKLPFkkzgu_tZF8ETFsSzxLJO2zc72eDqt_5Y2jzw_ITFm58Ab7wZXrH_yWxHrRsbxlVuEUdugxVCS7K3oE4s",
        title: "Insurance",
        padding: spacious,
      )
    ];
    const reminder = [
      HeroBanner(
        image:
            "https://superhandyus.com/cdn/shop/files/superhandy-electric-wheelchair-24v-6ah-battery-220lbs-max-weight-gut155-fba-43471160312086.jpg?v=1706556966&width=1500",
        title: "REMINDER: Charge wheelchair before trip",
        padding: spacious,
      )
    ];
    return [
      SizedBox(
        height: 200,
        child: CarouselView.weighted(
            flexWeights: const [1],
            children: reminder,
            onTap: (index) => showPopup(context,
                sheet: (context) => SizedBox(
                      height: 400,
                      child: reminder[index],
                    ))()),
      ),
      Text("Docs"),
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
      FloatingActionButton.extended(
          label: const Text("New Trip"),
          onPressed: showNewPage(context, const QuestionairePage())),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PageContent(
      title: "Report Card",
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
