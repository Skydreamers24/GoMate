import 'package:flutter/material.dart';
import 'package:gomate/misc/sort_option.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/pages/page_content.dart';
import 'package:gomate/widgets/cards/content_card.dart';
import 'package:gomate/widgets/other/filtered_list_view.dart';

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
    return PageContent.withChildWidget(
      title: "Search?",
      child: FilteredListView<String>(
        data: const ["a", "b", "c", "a", "b", "c", "a", "b", "c", "a", "b", "c"],
        searchFilter: ListFilter(
          name: "Search",
          test: (pair) => true,
        ),
        filters: [
          ListFilter(name: "All", test: (item) => true),
        ],
        sortOptions: [
          SortOption(
            name: "Sort: Ascending",
            sortFunction: (item1, item2) => 1,
          ),
          SortOption(
            name: "Sort: Descending",
            sortFunction: (item1, item2) => 2,
          ),
        ],
        builder: (item) => ListTile(
          title: Text(item),
        ),
      ),
    );
  }
}

/*

import 'package:flutter/material.dart';
import 'package:gomate/misc/sort_option.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/pages/page_content.dart';
import 'package:gomate/widgets/other/filtered_list_view.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static List<Widget> widgets(BuildContext context) {
    return [
      SizedBox(
        height: 400,
        child: FilteredListView<Text>(
          data: const [Text("a"), Text("b"), Text("c"), Text("d"), Text("e")],
          searchFilter: ListFilter(
            name: "Search",
            test: (pair) => pair.$2.data!.toLowerCase().contains(pair.$1.toLowerCase()),
          ),
          filters: [
            ListFilter(name: "All", test: (item) => true),
          ],
          sortOptions: [
            SortOption(
              name: "Sort: Ascending",
              sortFunction: (item1, item2) => item1.data!.compareTo(item2.data!),
            ),
            SortOption(
              name: "Sort: Descending",
              sortFunction: (item1, item2) => item2.data!.compareTo(item1.data!),
            ),
          ],
          builder: (item) => ListTile(
            title: item,
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PageContent.withTitleWidget(
      titleWidget: Row(
        children: [
          Expanded(
            child: Text(
              "Search?",
              style: pageTitle(context),
            ),
          ),
        ],
      ),
      children: widgets(context),
    );
  }
}

*/