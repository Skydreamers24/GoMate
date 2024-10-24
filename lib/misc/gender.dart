enum Gender {
  male,
  female,
  other,
  ratherNotSay;

  static Gender fromString(String s) {
    switch (s) {
      case "Male" || "male":
        return Gender.male;
      case "Female" || "female":
        return Gender.female;
      case "Other" || "other":
        return Gender.other;
      case "Rather not say" || "rather not say":
        return Gender.ratherNotSay;
      default:
        return Gender.ratherNotSay;
    }
  }

  @override
  String toString() {
    switch (this) {
      case Gender.male:
        return "Male";
      case Gender.female:
        return "Female";
      case Gender.other:
        return "Other";
      case Gender.ratherNotSay:
        return "Rather not say";
    }
  }
}
