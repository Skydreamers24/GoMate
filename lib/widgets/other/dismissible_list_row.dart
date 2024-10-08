import 'package:flutter/material.dart';

import 'package:gomate/misc/values.dart';

class DismissibleListRow extends StatefulWidget {
  const DismissibleListRow({
    super.key,
    required this.child,
    required this.dismissibleKey,
    this.remove,
  });

  final Widget child;
  final Key dismissibleKey;
  final void Function()? remove;

  @override
  State<DismissibleListRow> createState() => _DismissibleListRowState();
}

class _DismissibleListRowState extends State<DismissibleListRow> {
  DismissDirection dismissDirection = DismissDirection.none;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return widget.remove != null
        ? Dismissible(
            key: widget.dismissibleKey,
            onUpdate: (details) {
              setState(() {
                dismissDirection = details.direction;
              });
            },
            onDismissed: (direction) {
              widget.remove!();
            },
            background: Container(
              color: theme.colorScheme.errorContainer,
              child: Row(
                children: [
                  RemoveIconText(
                    shouldShow: dismissDirection == DismissDirection.startToEnd,
                  ),
                  const Expanded(child: SizedBox()),
                  RemoveIconText(
                      shouldShow:
                          dismissDirection == DismissDirection.endToStart)
                ],
              ),
            ),
            child: widget.child,
          )
        : widget.child;
  }
}

class RemoveIconText extends StatelessWidget {
  const RemoveIconText({super.key, required this.shouldShow});

  final bool shouldShow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
        padding: spaciousHorizontal,
        child: Builder(builder: (context) {
          final color = shouldShow
              ? theme.colorScheme.error
              : const Color.fromARGB(0, 0, 0, 0);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.delete,
                color: color,
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                "Remove",
                style: footnote(context).copyWith(color: color),
              )
            ],
          );
        }));
  }
}
