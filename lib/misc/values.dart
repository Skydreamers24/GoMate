import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const int adaptiveWidthThreshold = 580;
const int adaptiveWidthExtendedThreshold = 900;
const int adaptiveWidthWideThreshold = 1300;

TextStyle pageTitle(BuildContext context) {
  final theme = Theme.of(context);
  return (theme.textTheme.headlineLarge ?? const TextStyle()).copyWith(fontWeight: FontWeight.bold);
}

TextStyle heading(BuildContext context) {
  final theme = Theme.of(context);
  return (theme.textTheme.titleLarge ?? const TextStyle()).copyWith(fontWeight: FontWeight.bold);
}

TextStyle subheading(BuildContext context) {
  final theme = Theme.of(context);
  return (theme.textTheme.bodyLarge ?? const TextStyle())
      .copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold);
}

TextStyle data(BuildContext context) {
  final theme = Theme.of(context);
  return (theme.textTheme.bodyLarge ?? const TextStyle())
      .copyWith(color: theme.colorScheme.primary);
}

TextStyle footnote(BuildContext context) {
  final theme = Theme.of(context);
  return (theme.textTheme.labelMedium ?? const TextStyle()).copyWith(
    color: theme.colorScheme.onSecondaryContainer.withOpacity(0.7),
  );
}

TextStyle tiny(BuildContext context) {
  final theme = Theme.of(context);
  return (theme.textTheme.labelSmall ?? const TextStyle()).copyWith(
    color: theme.colorScheme.onSecondaryContainer.withOpacity(0.7),
  );
}

const double _c = 8;
const double _s = 15;
const double _t = 5;
const double _cCard = 15;
const double _sCard = 25;
const EdgeInsets comfortableListChildren =
    EdgeInsets.only(bottom: _c, left: _c, right: _c);
const EdgeInsets comfortable = EdgeInsets.all(_c);
const EdgeInsets comfortableHorizontal = EdgeInsets.only(left: _c, right: _c);
const EdgeInsets comfortableHorizontalSpaciousBottom =
    EdgeInsets.only(left: _c, right: _c, bottom: _s);
const EdgeInsets comfortableVertical = EdgeInsets.only(top: _c, bottom: _c);
const EdgeInsets comfortableList =
    EdgeInsets.only(bottom: _c, left: _c, right: _c);
const EdgeInsets comfortableCardInset = EdgeInsets.all(_cCard);
const EdgeInsets spacious = EdgeInsets.all(_s);
const EdgeInsets spaciousListChildren =
    EdgeInsets.only(bottom: _c, left: _s, right: _s);
const EdgeInsets spaciousTop = EdgeInsets.only(top: _s);
const EdgeInsets spaciousLeftcomfortableBottom =
    EdgeInsets.only(left: _s, bottom: _c);
const EdgeInsets spaciousRightcomfortableBottom =
    EdgeInsets.only(right: _s, bottom: _c);
const EdgeInsets spaciousHorizontal = EdgeInsets.only(left: _s, right: _s);
const EdgeInsets spaciousHorizontalTightVertical =
    EdgeInsets.only(left: _s, right: _s, top: _t, bottom: _t);
const EdgeInsets spaciousHorizontalComfortableVertical =
    EdgeInsets.only(left: _s, right: _s, top: _c, bottom: _c);
const EdgeInsets spaciousCardInset = EdgeInsets.all(_sCard);
const EdgeInsets tight = EdgeInsets.all(_t);
const EdgeInsets tightVertical = EdgeInsets.only(top: _t, bottom: _t);
const EdgeInsets tightHorizontal = EdgeInsets.only(left: _t, right: _t);
const EdgeInsets tightLeft = EdgeInsets.only(left: _t);
const EdgeInsets tightHorizontalTightTop =
    EdgeInsets.only(top: _t, left: _t, right: _t);
const EdgeInsets inline = EdgeInsets.all(3);
const EdgeInsets zero = EdgeInsets.zero;

const Color brandColorLight = Color.fromARGB(255, 196, 221, 219);
const Color brandColorDark = Color.fromARGB(255, 62, 96, 103);

Color foreground(Color background) =>
    background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
Color inverted(Color color) => Color.fromARGB(
    color.alpha, 255 - color.red, 255 - color.green, 255 - color.blue);
Color darker(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighter(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}

const supportedLocales = [Locale('en', 'US'), Locale('zh', 'HK')];
const localizationsDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
const debugShowCheckedModeBanner = false;
const title = "GUTolution";

const nothingKey = Key("_nothing");
const nothing = SizedBox.shrink(key: nothingKey,);

extension IsNothing on Widget {
  // Does not work
  bool get isNothing {
    return key == nothingKey;
  }
}

extension IsBrightness on ThemeData {
  bool get isLightMode => brightness == Brightness.light;
  bool get isDarkMode => brightness == Brightness.dark;
}