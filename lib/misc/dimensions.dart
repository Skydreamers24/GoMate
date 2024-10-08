import 'package:flutter/material.dart';
import 'package:gomate/misc/values.dart';

enum Dimensions {
  // Do not use variants directly
  _tall,
  _wide,
  _wider,
  _veryWide;

  static Dimensions fromConstraints(BoxConstraints constraints) {
    if (constraints.maxWidth >= adaptiveWidthThreshold) {
      if (constraints.maxWidth >= adaptiveWidthExtendedThreshold) {
        if (constraints.maxWidth >= adaptiveWidthWideThreshold) {
          return Dimensions._veryWide;
        }
        return Dimensions._wider;
      }
      return Dimensions._wide;
    }
    return Dimensions._tall;
  }

  bool get isTall => index >= Dimensions._tall.index;
  bool get isWide => index >= Dimensions._wide.index;
  bool get isWider => index >= Dimensions._wider.index;
  bool get isVeryWide => index >= Dimensions._veryWide.index;
}