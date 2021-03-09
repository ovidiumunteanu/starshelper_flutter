
// lesson class, this class contains all information of a lesson
class CLesson {
  final String Day;
  final int Start_Time;
  final int End_Time;
  final int ID;
  final int index;
  final int Lesson_No;
  final String Module_Code;
  final String Module_Name;
  final String Type;
  final String Group;
  final String Remarks;
  final String Venue;

  CLesson(
      this.Day,
      this.Start_Time,
      this.End_Time,
      this.ID,
      this.index,
      this.Lesson_No,
      this.Module_Code,
      this.Module_Name,
      this.Type,
      this.Group,
      this.Remarks,
      this.Venue);

  static CLesson fromDynamic(dynamic data) {
    return CLesson(
        data["Day"],
        data["Start_Time"],
        data["End_Time"],
        data["ID"],
        data["Index"],
        data["Lesson_No"],
        data["Module_Code"],
        data["Module_Name"],
        data["Type"],
        data["Group"],
        data["Remarks"],
        data["Venue"]);
  }

  static Map<String, dynamic> toJson(CLesson lesson) {
    return {
      "Day": lesson.Day,
      "Start_Time": lesson.Start_Time,
      "End_Time": lesson.End_Time,
      "ID": lesson.ID,
      "Index": lesson.index,
      "Lesson_No": lesson.Lesson_No,
      "Module_Code": lesson.Module_Code,
      "Module_Name": lesson.Module_Name,
      "Type": lesson.Type,
      "Group": lesson.Group,
      "Remarks": lesson.Remarks,
      "Venue": lesson.Venue
    };
  }
}
