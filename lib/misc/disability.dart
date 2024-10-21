import 'package:flutter/material.dart';

enum Disability {
  mobility,
  vision,
  hearing,
  cognitive,
  allergy;

  @override
  String toString() {
    return const {
      Disability.mobility: "Mobility",
      Disability.vision: "Vision",
      Disability.hearing: "Hearing",
      Disability.cognitive: "Cognitive",
      Disability.allergy: "Allergy"
    } [this] ?? "";
  }

  static Disability fromString(String disability) {
    return const {
      "Mobility": Disability.mobility,
      "Vision": Disability.vision,
      "Hearing": Disability.hearing,
      "Cognitive": Disability.cognitive,
      "Allergy": Disability.allergy,
    } [disability] ?? Disability.mobility;
  }

  IconData icon() {
    return const {
      Disability.mobility: Icons.wheelchair_pickup_outlined,
      Disability.vision: Icons.visibility_outlined,
      Disability.hearing: Icons.volume_off_outlined,
      Disability.cognitive: Icons.psychology_alt_outlined,
      Disability.allergy: Icons.set_meal_outlined
    } [this] ?? Icons.wheelchair_pickup_outlined;
  }
}