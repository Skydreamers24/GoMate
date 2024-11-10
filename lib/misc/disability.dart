import 'package:flutter/material.dart';

enum Disability {
  hearing,
  mobility,
  visual,
  speech,
  intellectual,
  chronic,
  allergy,
  none;

  static Disability fromString(String s) {
    switch (s) {
      case "Hearing":
        return Disability.hearing;
      case "Physical":
        return Disability.mobility;
      case "Visual":
        return Disability.visual;
      case "Speech":
        return Disability.speech;
      case "Intellectual":
        return Disability.intellectual;
      case "Chronic":
        return Disability.chronic;
      case "Allergy":
        return Disability.allergy;
      case "None":
        return Disability.none;
      default:
        return Disability.none;
    }
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
          Disability.chronic: "Chronic",
        }[this] ??
        "";
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
