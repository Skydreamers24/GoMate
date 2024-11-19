import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gomate/backend/account.dart';
import 'package:gomate/backend/database.dart';
import 'package:gomate/misc/journey.dart';
import 'package:gomate/misc/show_popup.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/pages/all_journeys_page.dart';
import 'package:gomate/pages/page_content.dart';
import 'package:gomate/widgets/cards/journey_card.dart';
import 'package:gomate/widgets/other/hero_banner.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final account = Account.of(context);
    final plannedJourneyIds = Account.of(context).plannedJourneyIds;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("journeys")
            .doc("journeyList")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.data() == null) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          final data = snapshot.data!.data()!;

          Map<String, Journey> journeys = data.map((journeyId, journeyMap) =>
              MapEntry(journeyId,
                  Journey.fromMap(journeyMap as Map<String, dynamic>)));

          return PageContent.withTitleWidget(
            safeAreaTop: false,
            titlePadding: zero,
            titleWidget: SizedBox(
              height: 200,
              child: HeroBanner(
                image:
                    "https://www.discoverhongkong.com/content/dam/dhk/intl/explore/tips-for-making-your-trip-to-hong-kong/tips-for-making-your-trip-to-hong-kong-1920x1080.jpg",
                title: "Hong Kong",
                titleStyle: pageTitle(context),
                child: IconButton.filled(
                    onPressed: showNewPage(
                        context,
                        AllJourneysPage(
                          plannedJourneyIds: plannedJourneyIds,
                          journeys: journeys,
                        )),
                    icon: const Icon(Icons.add)),
              ),
            ),
            children: [
              const SizedBox(),
              for (final (index, journeyId) in plannedJourneyIds.indexed)
                JourneyCard(
                  journey: journeys[journeyId]!,
                  maxLines: 3,
                  actions: [
                    FilledButton.icon(onPressed: () {
                      final newPlannedJourneyIds = List<String>.from(account.plannedJourneyIds);
                      newPlannedJourneyIds.removeAt(index);
                      toDatabaseSync(account.copyWith(plannedJourneyIds: newPlannedJourneyIds));
                    }, label: const Text("Remove"), icon: const Icon(Icons.remove),),
                    FilledButton.icon(onPressed: () {}, label: const Text("Book"), icon: const Icon(Icons.book_online_rounded),)
                  ],
                )
            ],
          );
        });
  }
}
