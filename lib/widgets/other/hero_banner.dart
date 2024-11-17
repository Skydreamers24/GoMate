import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gomate/misc/values.dart';

class HeroBanner extends StatelessWidget {
  final String? image;
  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final EdgeInsets padding;
  final Widget? child;
  final double? childMaxHeight;
  final Color fadeTo;

  const HeroBanner(
      {super.key,
      this.image,
      this.title = "",
      this.titleStyle,
      this.subtitle,
      this.subtitleStyle,
      this.fadeTo = Colors.black,
      this.padding = comfortable,
      this.childMaxHeight = 50,
      this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRect(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: FittedBox(
                  fit: BoxFit.cover,
                  child: image != null
                      ? (image!.startsWith("http://") ||
                              image!.startsWith("https://"))
                          ? Image.network(image!)
                          : Image.asset(
                              image!,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset("assets/whale_avatar.png"),
                            )
                      : Container(
                          color: theme.colorScheme.surface,
                        ))),
          FadeFilter(
            fadeTo: fadeTo,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: padding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: (titleStyle ??
                                  const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis))
                              .copyWith(
                            color: foreground(fadeTo),
                          ),
                        ),
                        subtitle != null
                            ? OverflowBox(
                                fit: OverflowBoxFit.deferToChild,
                                maxHeight: childMaxHeight,
                                child: Text(
                                  subtitle!,
                                  style: (subtitleStyle ?? footnote(context))
                                      .copyWith(
                                          color: darker(foreground(fadeTo))),
                                  overflow: TextOverflow.fade,
                                ),
                              )
                            : nothing
                      ],
                    ),
                  ),
                  child ?? nothing
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FadeFilter extends StatelessWidget {
  final Color fadeTo;
  const FadeFilter({super.key, this.fadeTo = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
            fadeTo.withOpacity(0),
            fadeTo.withOpacity(0.1),
            fadeTo.withOpacity(0.8)
          ],
              stops: const [
            0.0,
            0.3,
            1.0
          ])),
    );
  }
}
