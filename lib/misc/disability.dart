import 'package:flutter/material.dart';

enum Disability {
  hearing,
  mobility,
  visual,
  speech,
  intellectual,
  chronic,
  allergy;

  static Disability fromString(String s) {
    return const {
      "Hearing": Disability.hearing,
      "Mobility": Disability.mobility,
      "Visual": Disability.visual,
      "Speech": Disability.speech,
      "Intellectual": Disability.intellectual,
      "Chronic illness": Disability.chronic,
      "Allergy": Disability.allergy,
    } [s] ?? Disability.visual;
  }

  @override
  String toString() {
    return const {
          Disability.mobility: "Mobility",
          Disability.visual: "Visual",
          Disability.hearing: "Hearing",
          Disability.intellectual: "Intellectual",
          Disability.allergy: "Allergy",
          Disability.speech: "Speech",
          Disability.chronic: "Chronic illness",
        } [this] ?? "Visual";
  }

  IconData icon() {
    return const {
          Disability.mobility: Icons.wheelchair_pickup_outlined,
          Disability.visual: Icons.visibility_outlined,
          Disability.hearing: Icons.volume_off_outlined,
          Disability.intellectual: Icons.psychology_alt_outlined,
          Disability.allergy: Icons.set_meal_outlined,
          Disability.speech: Icons.speaker_notes_off,
          Disability.chronic: Icons.running_with_errors,
        }[this] ??
        Icons.wheelchair_pickup_outlined;
  }
}
