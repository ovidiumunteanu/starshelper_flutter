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

  static List<CModule> fetchAll() {
    return [
      CModule("Day", 1212, 1313, 124, 234, 2, "EE2031", "Module_Name", "Type",
          "Group", "Remarks", "Venue"),
      CModule("Day", 1212, 1313, 124, 234, 2, "EE2031", "Module_Name", "Type",
          "Group", "Remarks", "Venue"),
      CModule("Day", 1212, 1313, 124, 234, 2, "EE2031", "Module_Name", "Type",
          "Group", "Remarks", "Venue"),
      CModule("Day", 1212, 1313, 124, 234, 2, "EE2031", "Module_Name", "Type",
          "Group", "Remarks", "Venue"),
      CModule("Day", 1212, 1313, 124, 234, 2, "EE2031", "Module_Name", "Type",
          "Group", "Remarks", "Venue"),
      CModule("Day", 1212, 1313, 124, 234, 2, "EE2031", "Module_Name", "Type",
          "Group", "Remarks", "Venue"),
      CModule("Day", 1212, 1313, 124, 234, 2, "EE2031", "Module_Name", "Type",
          "Group", "Remarks", "Venue"),
      CModule("Day", 1212, 1313, 124, 234, 2, "EE2031", "Module_Name", "Type",
          "Group", "Remarks", "Venue"),
      CModule("Day", 1212, 1313, 124, 234, 2, "EE2031", "Module_Name", "Type",
          "Group", "Remarks", "Venue"),
      CModule("Day", 1212, 1313, 124, 234, 2, "EE2031", "Module_Name", "Type",
          "Group", "Remarks", "Venue"),
      CModule("Day", 1212, 1313, 124, 234, 2, "EE2031", "Module_Name", "Type",
          "Group", "Remarks", "Venue"),
      CModule("Day", 1212, 1313, 124, 234, 2, "EE2031", "Module_Name", "Type",
          "Group", "Remarks", "Venue"),
      CModule("Day", 1212, 1313, 124, 234, 2, "EE2031", "Module_Name", "Type",
          "Group", "Remarks", "Venue")
    ];
  }
}
