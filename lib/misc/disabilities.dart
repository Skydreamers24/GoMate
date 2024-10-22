enum Disabilities{
  hearing_impairment,
  physical_impairment,
  visual_impairment,
  speech_impairment,
  intellectual_disability,
  mental_illness,
  viscreal_disability,
  chronic_illness,
  adhd,
  specific_learning_difficulties,
  none;

  static Disabilities fromString(String s){
    switch(s){
      case "Hearing Impairment":
        return Disabilities.hearing_impairment;
      case "Physical Impairment":
        return Disabilities.physical_impairment;
      case "Visual Impairment":
        return Disabilities.visual_impairment;
      case "Speech Impairment":
        return Disabilities.speech_impairment;
      case "Intellectual Disability":
        return Disabilities.intellectual_disability;
      case "Mental Illness":
        return Disabilities.mental_illness;
      case "Viscreal Disability":
        return Disabilities.viscreal_disability;
      case "Chronic Illness":
        return Disabilities.chronic_illness;
      case "ADHD":
        return Disabilities.adhd;
      case "Specific Learning Difficulties":
        return Disabilities.specific_learning_difficulties;
      case "None":
        return Disabilities.none;
      default:
        return Disabilities.none;
    }
  }

  @override
  String toString(){
    switch(this){
      case Disabilities.hearing_impairment:
        return "Hearing Impairment";
      case Disabilities.physical_impairment:
        return "Physical Impairment";
      case Disabilities.visual_impairment:
        return "Visual Impairment";
      case Disabilities.speech_impairment:
        return "Speech Impairment";
      case Disabilities.intellectual_disability:
        return "Intellectual Disability";
      case Disabilities.mental_illness:
        return "Mental Illness";
      case Disabilities.viscreal_disability:
        return "Viscreal Disability";
      case Disabilities.chronic_illness:
        return "Chronic Illness";
      case Disabilities.adhd:
        return "ADHD";
      case Disabilities.specific_learning_difficulties:
        return "Specific Learning Difficulties";
      case Disabilities.none:
        return "None";
      default:
        return "None";
    }
  }
}