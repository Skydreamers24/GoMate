import 'package:flutter/material.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/widgets/cards/content_card.dart';

class StatisticsCardMedium extends StatelessWidget {
  final String title;
  final int value;
  final int maxValue;
  final String quantifier;
  final String adjective;
  final void Function()? onTap;

  const StatisticsCardMedium(
      {super.key,
      this.title = "Title",
      this.value = 0,
      this.maxValue = 100,
      this.quantifier = "",
      this.adjective = "",
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ContentCard(
      clipBehavior: Clip.hardEdge,
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 130, minWidth: 130),
        child: Padding(
          padding: spaciousTop,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 2,
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: RingIndicator(
                    value: value,
                    maxValue: maxValue,
                    quantifier: quantifier,
                    title: title,
                    adjective: adjective,
                    thickness: 8,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: tight.copyWith(bottom: 0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: subheading(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StatisticsCardWide extends StatelessWidget {
  final String title;
  final String description;
  final int value;
  final int maxValue;
  final String quantifier;
  final String adjective;
  final void Function()? onTap;

  const StatisticsCardWide(
      {super.key,
      this.title = "Title",
      this.description = "Description",
      this.value = 0,
      this.maxValue = 100,
      this.quantifier = "",
      this.adjective = "",
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ContentCard(
      clipBehavior: Clip.hardEdge,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: spaciousCardInset,
            child: SizedBox(
              width: 90,
              height: 90,
              child: RingIndicator(
                  title: title,
                  value: value,
                  maxValue: maxValue,
                  quantifier: quantifier,
                  adjective: adjective),
            ),
          ),
          Expanded(
            child: Padding(
              padding: comfortable,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: heading(context),
                  ),
                  Text(
                    description,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RingIndicator extends StatelessWidget {
  const RingIndicator(
      {super.key,
      this.value = 70,
      this.maxValue = 100,
      this.quantifier = "",
      this.title = "",
      this.adjective = "",
      this.thickness = 12.0});

  final int value;
  final int maxValue;
  final String quantifier;
  final String title;
  final String adjective;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: "$title: $value $quantifier",
      child: Stack(
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: CircularProgressIndicator(
              value: value / maxValue,
              strokeWidth: thickness,
              backgroundColor: theme.isLightMode
                  ? darker(theme.colorScheme.surfaceContainerHighest, 0.07)
                  : lighter(theme.colorScheme.surfaceContainerHighest),
              semanticsLabel: "",
            ),
          ),
          SizedBox(
              width: 90,
              height: 90,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "$value$quantifier",
                    style: data(context),
                  ),
                  adjective.isEmpty
                      ? nothing
                      : ActionChip(
                          label: Text(
                            adjective,
                          ),
                          labelStyle: tiny(context),
                          labelPadding: zero,
                          onPressed: () {},
                        )
                ],
              )))
        ],
      ),
    );
  }
}
