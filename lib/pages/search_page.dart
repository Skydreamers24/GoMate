import 'package:flutter/material.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/pages/page_content.dart';
import 'package:gomate/widgets/cards/content_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static List<Widget> widgets(BuildContext context) {
    return [
      const ContentCard(
        height: 180,
        child: Padding(
          padding: comfortable,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'hi',
            ),
          ),
        ),
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
            "Search",
            style: pageTitle(context),
          )),
        ],
      ),
      children: widgets(context)
    );
  }
}
