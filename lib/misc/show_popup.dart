import 'package:flutter/material.dart';
import 'package:gomate/widgets/other/adaptive.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

void Function() showPopup(BuildContext context, {Widget? heroWidget, required Widget Function(BuildContext) sheet}) {
  final theme = Theme.of(context);
  return () {
    WoltModalSheet.show(
      context: context,
      pageListBuilder: (context) => [
        SliverWoltModalSheetPage(
          heroImage: heroWidget,
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          hasTopBarLayer: false,
          mainContentSliversBuilder: (context) => [
            SliverList.list(children: [
              Adaptive.child(
                child: sheet(context),
              )
            ])
          ],
        )
      ],
    );
  };
}

void Function() showNewPage(BuildContext context, Widget page) {
  return () {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Adaptive.child(
              child: page,
            )));
  };
}
