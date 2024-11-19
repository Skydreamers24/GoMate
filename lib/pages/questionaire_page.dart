import 'package:flutter/material.dart';
import 'package:gomate/backend/account.dart';
import 'package:gomate/backend/database.dart';
import 'package:gomate/misc/show_popup.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/pages/page_content.dart';
import 'package:gomate/pages/results_page.dart';
import 'package:gomate/widgets/other/rounded_rectangle.dart';
import 'package:gomate/widgets/other/form_fields.dart';

class QuestionairePage extends StatefulWidget {
  const QuestionairePage({super.key});

  @override
  State<QuestionairePage> createState() => _QuestionairePageState();
}

class _QuestionairePageState extends State<QuestionairePage> {
  int page = 1;
  double budgetSlider = 0;

  void nextPage() {
    if (page + 1 <= 5) {
      setState(() {
        page += 1;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final account = Account.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: PageContent(
        title: "Quiz",
        childrenPadding: comfortable.copyWith(left: 0, right: 0),
        children: [
          RoundedRectangle(
            cornerRadius: 40,
            color: theme.colorScheme.surfaceContainerHigh,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 1; i <= 5; i++)
                  Padding(
                    padding: tight,
                    child: i <= page
                        ? IconButton.filled(
                            onPressed: () {
                              setState(() {
                                page = i;
                              });
                            },
                            icon: Text(
                              i.toString(),
                              style: subheading(context)
                                  .copyWith(color: theme.colorScheme.onPrimary),
                            ))
                        : IconButton.outlined(
                            onPressed: () {
                              setState(() {
                                page = i;
                              });
                            },
                            icon: Text(
                              i.toString(),
                              style: subheading(context)
                                  .copyWith(color: theme.colorScheme.onSurface),
                            )),
                  )
              ],
            ),
          ),
          page < 6
              ? Padding(
                  padding: const EdgeInsets.all(60),
                  child: () {
                    switch (page) {
                      case 1:
                        return Column(
                          children: [
                            Text(
                              "Where to?",
                              style: heading(context),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(border: OutlineInputBorder(), label: Text("Country/region")),
                                value: account.region,
                                items: const [
                                  DropdownMenuItem(
                                    value: "",
                                    child: Text(""),
                                  ),
                                  DropdownMenuItem(
                                    value: "China",
                                    child: Text("China"),
                                  ),
                                  DropdownMenuItem(
                                    value: "United States",
                                    child: Text("United States"),
                                  ),
                                  DropdownMenuItem(
                                    value: "United Kingdom",
                                    child: Text("United Kingdom"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Macao",
                                    child: Text("Macao"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Hong Kong",
                                    child: Text("Hong Kong"),
                                  )
                                ],
                                onChanged: (region) {
                                  toDatabaseSync(
                                      account.copyWith(region: region));
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                            FloatingActionButton.extended(
                                label: const Text("Find places"),
                                onPressed: showNewPage(context, const ResultsPage()))
                          ],
                        );
                      default:
                        return const Placeholder();
                    }
                  }())
              : nothing,
        ],
      ),
    );
  }
}