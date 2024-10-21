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
  specific_learning_difficulties;

  static Disabilities fromString(String s){
    
  }

  @override
  String toString(){
    switch(s){
      case "hearing_impairment":
        return Disabilities.hearing_impairment;
      case "physical_impairment":
        return Disabilities.physical_impairment;
      case "visual_impairment":
        return Disabilities.visual_impairment;
      case "speech_impairment":
        return Disabilities.speech_impairment;
      case "intellectual_disability":
        return Disabilities.intellectual_disability;
      case "mental_illness":
        return Disabilities.mental_illness;
      case "viscreal_disability":
        return Disabilities.viscreal_disability;
      case "chronic_illness":
        return Disabilities.chronic_illness;
      case "adhd":
        return Disabilities.adhd;
      case "specific_learning_difficulties":
        return Disabilities.specific_learning_difficulties;
      default:
       return ""
    }
  }
}