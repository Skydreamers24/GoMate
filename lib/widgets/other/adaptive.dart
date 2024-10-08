import 'package:flutter/material.dart';
import 'package:gomate/misc/dimensions.dart';

class Adaptive extends StatefulWidget {
  final Widget? horizontal;
  final Widget? vertical;
  final Widget Function(Dimensions)? builder;
  final Widget? child;

  const Adaptive(
      {super.key, this.horizontal, this.vertical}): builder = null, child = null;
  
  const Adaptive.builder({super.key, this.builder}): horizontal = null, vertical = null, child = null;

  const Adaptive.child({super.key, this.child}): horizontal = null, vertical = null, builder = null;

  static AdaptiveData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AdaptiveData>()!;
  }

  @override
  State<Adaptive> createState() => _AdaptiveState();
}

class _AdaptiveState extends State<Adaptive> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: widget.builder != null
            ? (context, constraints) {
                final dimensions = Dimensions.fromConstraints(constraints);
                return AdaptiveData(
                    dimensions: dimensions, child: widget.builder!(dimensions));
              }
            : widget.horizontal != null && widget.vertical != null
                ? (context, constraints) {
                    final dimensions = Dimensions.fromConstraints(constraints);
                    return AdaptiveData(
                      dimensions: dimensions,
                      child: dimensions.isWide
                          ? widget.horizontal!
                          : widget.vertical!,
                    );
                  }
                : (context, constraints) => AdaptiveData(
                    dimensions: Dimensions.fromConstraints(constraints),
                    child: widget.child!));
  }
}

class AdaptiveData extends InheritedWidget {
  final Dimensions dimensions;
  const AdaptiveData(
      {super.key, required this.dimensions, required super.child});
  @override
  bool updateShouldNotify(AdaptiveData oldWidget) {
    return dimensions != oldWidget.dimensions;
  }
}
