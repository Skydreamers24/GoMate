import 'package:flutter/material.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/widgets/other/page_title.dart';

class PageContent extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final EdgeInsets? titlePadding;
  final List<Widget> children;
  final EdgeInsets childrenPadding;
  final MainAxisSize columnSize;
  final MainAxisAlignment verticalAlignment;
  final CrossAxisAlignment horizontalAlignment;
  final bool safeAreaTop;
  final bool safeAreaBottom;
  final bool scrollable;

  const PageContent(
      {super.key,
      this.title,
      this.children = const [],
      this.childrenPadding = comfortableListChildren,
      this.titlePadding,
      this.verticalAlignment = MainAxisAlignment.start,
      this.horizontalAlignment = CrossAxisAlignment.center,
      this.columnSize = MainAxisSize.max,
      this.safeAreaTop = true,
      this.scrollable = true,
      this.safeAreaBottom = false})
      : titleWidget = null;

  const PageContent.withTitleWidget( 
      {super.key,
      this.titleWidget,
      this.titlePadding,
      this.children = const [],
      this.childrenPadding = comfortableListChildren,
      this.verticalAlignment = MainAxisAlignment.start,
      this.horizontalAlignment = CrossAxisAlignment.center,
      this.columnSize = MainAxisSize.max,
      this.safeAreaTop = true,
      this.scrollable = true,
      this.safeAreaBottom = false})
      : title = null;

  @override
  Widget build(BuildContext context) {
    final filteredChildren =
        children.where((widget) => !widget.isNothing).toList();
    final column = Column(
      mainAxisAlignment: verticalAlignment,
      crossAxisAlignment: horizontalAlignment,
      mainAxisSize: columnSize,
      children: [
        titleWidget != null
            ? PageTitle.withTitleWidget(
                titleWidget,
                padding: titlePadding,
              )
            : title != null
                ? PageTitle(
                    title,
                    padding: titlePadding,
                  )
                : nothing,
        for (var child in filteredChildren)
          Padding(
            padding: childrenPadding,
            child: child,
          ),
      ],
    );
    return SafeArea(
        top: safeAreaTop,
        bottom: safeAreaBottom,
        child: scrollable
            ? SingleChildScrollView(
                child: column,
              )
            : column);
  }
}
