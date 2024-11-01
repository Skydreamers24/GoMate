import 'package:flutter/material.dart';
import 'package:gomate/pages/page_content.dart';
import 'package:gomate/widgets/other/filtered_list_view.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContent.withChildWidget(
      title: "Plan",
      trailing: IconButton.filled(onPressed: () {}, icon: Icon(Icons.add)),
      child: FilteredListView(
        
      ),
    );
  }
  
}