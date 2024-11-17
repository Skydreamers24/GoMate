import 'package:flutter/material.dart';
import 'package:gomate/misc/sort_option.dart';
import 'package:gomate/pages/page_content.dart';
import 'package:gomate/widgets/other/filtered_list_view.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContent.withChildWidget(
      title: "Plan",
      trailing: IconButton.filled(onPressed: () {}, icon: Icon(Icons.add)),
      child: FilteredListView<String>(
        data: ["a", "B", "c"],
        filters: [
          ListFilter(name: "All", test: (str) => true),
          ListFilter(name: "Upper", test: (str) => str.toUpperCase() == str),
          ListFilter(name: "Lower", test: (str) => str.toLowerCase() == str)
        ],
        searchFilter: ListFilter(
            name: "Search",
            test: (pair) => pair.$1.isEmpty
                ? true
                : pair.$1.toLowerCase().contains(pair.$2.toLowerCase())),
        sortOptions: [
          SortOption(
              name: "Alphabetical",
              sortFunction: (str1, str2) =>
                  str1.toLowerCase().compareTo(str2.toLowerCase())),
          SortOption(
              name: "Reverse Alphabetical",
              sortFunction: (str1, str2) =>
                  -str1.toLowerCase().compareTo(str2.toLowerCase()))
        ],
        builder: (str) => ListTile(
          leading: Icon(Icons.dangerous),
          title: Text(str),
        ),
      ),
    );
  }
}
