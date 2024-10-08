import 'dart:math';
import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/widgets/other/adaptive.dart';

class CustomLineChart extends StatefulWidget {
  const CustomLineChart(
      {super.key, required this.data, required this.keys, this.axisTitle});

  final List<double> data;
  final List<String> keys;
  final String? axisTitle;

  @override
  State<CustomLineChart> createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  Color color() {
    return Theme.of(context).colorScheme.primary;
  }

  Color textColor() {
    return Theme.of(context).colorScheme.onPrimary;
  }

  List<int> showingTooltipOnSpots() =>
      [for (final (index, _) in widget.data.indexed) index];

  List<FlSpot> get allSpots => [
        for (var (index, datum) in widget.data.indexed)
          FlSpot(index.toDouble(), datum)
      ];

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    try {
      final text = widget.keys[value.toInt()];
      return SideTitleWidget(
          axisSide: meta.axisSide,
          child: Text(
            text,
          ));
    } on IndexError {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
          showingIndicators: showingTooltipOnSpots(),
          spots: allSpots,
          isCurved: false,
          barWidth: 7,
          belowBarData: BarAreaData(
            show: false,
            color: color(),
          ),
          dotData: const FlDotData(show: false),
          color: color()),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return AspectRatio(
      aspectRatio: 2.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 10,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return LineChart(
            LineChartData(
              showingTooltipIndicators: showingTooltipOnSpots().map((index) {
                return ShowingTooltipIndicators([
                  LineBarSpot(
                    tooltipsOnBar,
                    lineBarsData.indexOf(tooltipsOnBar),
                    tooltipsOnBar.spots[index],
                  ),
                ]);
              }).toList(),
              lineTouchData: LineTouchData(
                enabled: true,
                handleBuiltInTouches: false,
                getTouchedSpotIndicator:
                    (LineChartBarData barData, List<int> spotIndexes) {
                  return spotIndexes.map((index) {
                    return TouchedSpotIndicatorData(
                      FlLine(
                        color: color(),
                      ),
                      FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                          radius: 8,
                          color: color(),
                          strokeWidth: 2,
                          strokeColor: color(),
                        ),
                      ),
                    );
                  }).toList();
                },
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (touchedSpot) => color(),
                  tooltipRoundedRadius: 8,
                  getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                    return lineBarsSpot.map((lineBarSpot) {
                      return LineTooltipItem(lineBarSpot.y.toString(),
                          TextStyle(color: textColor()));
                    }).toList();
                  },
                ),
              ),
              lineBarsData: lineBarsData,
              minY: 0,
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  axisNameWidget: Text(widget.axisTitle ?? ""),
                  axisNameSize: 24,
                  sideTitles: const SideTitles(
                    showTitles: false,
                    reservedSize: 0,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      return bottomTitleWidgets(
                        value,
                        meta,
                        constraints.maxWidth,
                      );
                    },
                    reservedSize: 30,
                  ),
                ),
                rightTitles: const AxisTitles(
                  axisNameWidget: Text(''),
                  sideTitles: SideTitles(
                    showTitles: false,
                    reservedSize: 0,
                  ),
                ),
                topTitles: const AxisTitles(
                  axisNameWidget: Text(
                    '',
                    textAlign: TextAlign.left,
                  ),
                  axisNameSize: 24,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 0,
                  ),
                ),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(
                show: false,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class CustomPieChart extends StatefulWidget {
  const CustomPieChart(
      {super.key,
      this.data = const [],
      this.show = 5,
      this.tappedSectionRadius = 40,
      this.defaultRadius = 30,
      this.adaptiveData,
      this.color = Colors.teal});

  final List<(String, double)> data;
  final int show;
  final MaterialColor color;
  final double tappedSectionRadius;
  final double defaultRadius;
  final AdaptiveData? adaptiveData;

  @override
  State<CustomPieChart> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  int touchedSection = 0;
  List<(String, double)> selectedData = const [];
  double othersValue = 100.0;

  @override
  void initState() {
    super.initState();
    List<(String, double)> data = List.from(widget.data);
    data.sort((entry1, entry2) => -entry1.$2.compareTo(entry2.$2));
    selectedData = data.getRange(0, min(widget.show, data.length)).toList();
    othersValue = 100.0;
    for (final (_, value) in selectedData) {
      othersValue -= value;
    }
    othersValue = max(0.0, othersValue);
  }

  @override
  void didUpdateWidget(CustomPieChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    List<(String, double)> data = List.from(widget.data);
    data.sort((entry1, entry2) => -entry1.$2.compareTo(entry2.$2));
    selectedData = data.getRange(0, min(widget.show, data.length)).toList();
    othersValue = 100.0;
    for (final (_, value) in selectedData) {
      othersValue -= value;
    }
    othersValue = max(0.0, othersValue);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: comfortable,
            child: PieChart(
              swapAnimationDuration: Duration.zero,
              swapAnimationCurve: Curves.fastOutSlowIn,
              PieChartData(
                startDegreeOffset: -45,
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (event is! FlTapDownEvent ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        return;
                      }
                      if (pieTouchResponse
                              .touchedSection!.touchedSectionIndex ==
                          touchedSection) {
                        touchedSection = -1;
                        return;
                      }
                      touchedSection =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 2,
                centerSpaceRadius: double.nan,
                sections: showingSections(selectedData),
              ),
            ),
          ),
        ),
        AnimateWidget(
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          builder: (context, animate) => Container(
            decoration: BoxDecoration(
                color: theme.colorScheme.tertiaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            width: animate(
                touchedSection >= 0 && touchedSection <= selectedData.length - 1
                    ? widget.adaptiveData != null &&
                            widget.adaptiveData!.dimensions.isWide
                        ? 170
                        : 120
                    : 0),
            height: double.infinity,
            padding: comfortable,
            child:
                touchedSection >= 0 && touchedSection <= selectedData.length - 1
                    ? OverflowBox(
                        maxHeight: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              selectedData[touchedSection].$1,
                              textAlign: TextAlign.start,
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${selectedData[touchedSection].$2}%",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      )
                    : nothing,
          ),
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections(
      List<(String, double)> selectedData) {
    return [
      for (final (index, (_, value)) in selectedData.indexed)
        PieChartSectionData(
          color: widget.color[max(100, min(7, widget.show - index) * 100)],
          value: value,
          title: "",
          radius: touchedSection == index
              ? widget.tappedSectionRadius
              : widget.defaultRadius,
        ),
      PieChartSectionData(
        color: Colors.grey,
        value: othersValue,
        title: "",
        radius: widget.defaultRadius,
      )
    ];
  }
}
