import 'package:flutter/material.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/pages/page_content.dart';
import 'package:gomate/widgets/other/hero_banner.dart';
import 'package:gomate/widgets/other/image_frame.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static List<Widget> widgets(BuildContext context) {
    return [
      const SizedBox(
        height: 200,
        child: CarouselView.weighted(flexWeights: [3, 2, 1], children: [
          HeroBanner(
            image: "https://hips.hearstapps.com/hmg-prod/images/plant-guide-1663941701.jpg",
            title: "Plants",
            padding: spacious,
          ),
          HeroBanner(
            image: "https://idthefuture.com/wp-content/uploads/sites/4/2023/07/humpback-whale-flipper-scaled.jpg",
            title: "Whale",
            padding: spacious,
          ),
          HeroBanner(
            image: "http://www.baltana.com/files/wallpapers-2/Cute-Cat-Images-07756.jpg",
            title: "Cat",
            padding: spacious,
          )
        ]),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PageContent.withTitleWidget(
      titleWidget: Row(
        children: [
          Expanded(
              child: Text(
            "Home",
            style: pageTitle(context),
          )),
          IconButton.outlined(
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
              icon: const Icon(Icons.info_outline))
        ],
      ),
      children: widgets(context),
    );
  }
}
