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
    switch (this) {
      case Disability.hearing:
        return "Hearing";
      case Disability.mobility:
        return "Mobility";
      case Disability.visual:
        return "Visual";
      case Disability.speech:
        return "Speech";
      case Disability.intellectual:
        return "Intellectual";
      case Disability.chronic:
        return "Chronic Illness";
      case Disability.allergy:
        return "Allergy";
      case Disability.none:
        return "None";
    }
  }
}
