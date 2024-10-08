import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_extension.dart';

class Name {
  final String given;
  final String family;
  const Name(this.given, this.family);

  String toLocalizedString(BuildContext context) {
    if (given.isEmpty && family.isEmpty) {
      return "Valued User";
    }
    final locale = I18n.locale;
    if (locale.languageCode == 'zh') {
      return "$family $given";
    } else {
      return "$given $family";
    }
  }
}