import 'package:flutter/material.dart';
import 'package:gomate/backend/account.dart';
import 'package:gomate/backend/database.dart';
import 'package:gomate/misc/journey.dart';
import 'package:gomate/misc/show_popup.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/pages/add_missing_page.dart';
import 'package:gomate/pages/page_content.dart';
import 'package:gomate/widgets/cards/journey_card.dart';
import 'package:gomate/widgets/other/filtered_list_view.dart';

class AllJourneysPage extends StatelessWidget {
  final Map<String, Journey> journeys;
  final List<String> plannedJourneyIds;
  const AllJourneysPage(
      {super.key, this.journeys = const {}, this.plannedJourneyIds = const []});

  @override
  Widget build(BuildContext context) {
    final account = Account.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add an experience"),
        actions: [
          MenuAnchor(
            menuChildren: [
              MenuItemButton(
                onPressed: showNewPage(context, const AddMissingPage()),
                child: const Text("Add missing"),
              )
            ],
            builder: (context, controller, child) => IconButton(
              icon: const Icon(Icons.menu),
              tooltip: "More actions",
              onPressed: () {
                controller.isOpen ? controller.close() : controller.open();
              },
            ),
          )
        ],
      ),
      body: PageContent.withChildWidget(
        child: FilteredListView<String>(
          addSeparator: false,
          data: journeys.keys.toList(),
          searchFilter: ListFilter(
              name: "Search",
              test: (pair) => journeys[pair.$2]!
                  .name
                  .toLowerCase()
                  .contains(pair.$1.toLowerCase())),
          filters: [
            ListFilter(name: "All", test: (journeyId) => true),
            for (final journeyType in JourneyType.values)
              ListFilter(
                  name: journeyType.toString(),
                  test: (journeyId) => journeys[journeyId]!.type == journeyType)
          ],
          builder: (journeyId) => Padding(
            padding: comfortableListChildren,
            child: JourneyCard(
              journey: journeys[journeyId]!,
              actions: [
                plannedJourneyIds.contains(journeyId)
                    ? null
                    : FilledButton.icon(
                        onPressed: () {
                          toDatabaseSync(account.copyWith(
                              plannedJourneyIds:
                                  plannedJourneyIds + [journeyId]));
                          Navigator.pop(context);
                        },
                        label: const Text("Add"),
                        icon: const Icon(Icons.add),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
