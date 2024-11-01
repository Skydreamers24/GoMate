import 'package:flutter/material.dart';

enum JourneyType {
  accommodation,
  transportation,
  activity,
  dining;

  @override
  String toString() {
    return const {
          JourneyType.accommodation: "Accommodation",
          JourneyType.transportation: "Transportation",
          JourneyType.activity: "Activity",
          JourneyType.dining: "Dining",
        }[this] ??
        "Activity";
  }

  static JourneyType fromString(String s) {
    return const {
          "Accommodation": JourneyType.accommodation,
          "Transportation": JourneyType.transportation,
          "Activity": JourneyType.activity,
          "Dining": JourneyType.dining,
        }[s] ??
        JourneyType.activity;
  }

  IconData icon() {
    return const {
          JourneyType.accommodation: Icons.hotel_rounded,
          JourneyType.transportation: Icons.train_rounded,
          JourneyType.activity: Icons.local_activity_rounded,
          JourneyType.dining: Icons.dining_rounded,
        }[this] ??
        Icons.local_activity_rounded;
  }
}

class Journey {
  final JourneyType type;
  final String name;
  final String description;
  final String image;
  final IconData? icon;

  const Journey(
      {this.type = JourneyType.activity,
      this.name = "",
      this.description = "",
      this.image = "",
      this.icon});
}
