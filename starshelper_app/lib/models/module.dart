/// Represents a tourism location a user can visit.
class CModule {
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

  CModule(
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

  static CModule fromDynamic(dynamic data) {
    return CModule(
      data["Day"],
      data["Start_Time"],
      data["End_Time"],
      data["ID"],
      data["index"],
      data["Lesson_No"],
      data["Module_Code"],
      data["Module_Name"],
      data["Type"],
      data["Group"],
      data["Remarks"],
      data["Venue"]);
  }
}
