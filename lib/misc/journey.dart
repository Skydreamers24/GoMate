import 'package:flutter/material.dart';
import 'package:gomate/misc/disability.dart';

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
  final String location;
  final String image;
  final Set<Disability> incompatibleDisabilities;

  const Journey(
      {this.type = JourneyType.activity,
      this.name = "",
      this.location = "",
      this.description = "",
      this.image = "",
      this.incompatibleDisabilities = const {}});

  Map<String, dynamic> toMap() {
    return {
      "type": type.toString(),
      "name": name,
      "location": location,
      "description": description,
      "image": image,
      "incompatibleDisabilities": incompatibleDisabilities
          .map((disability) => disability.toString())
          .toList()
    };
  }

  static Journey fromMap(Map<String, dynamic> map) {
    final journeyType = JourneyType.fromString((map["type"] ?? "") as String);
    return Journey(
        type: journeyType,
        name: (map["name"] ?? "") as String,
        location: (map["location"] ?? "") as String,
        description: (map["description"] ?? "") as String,
        image: (map["image"] ?? "") as String,
        incompatibleDisabilities: ((map["incompatibleDisabilities"] ?? const [])
                as List<dynamic>)
            .map((disability) => Disability.fromString(disability as String))
            .toSet());
  }

  double universalStayScore(Set<Disability> userDisabilities) {
    return Disability.values.length -
        userDisabilities
            .intersection(incompatibleDisabilities)
            .length
            .toDouble();
  }
}
