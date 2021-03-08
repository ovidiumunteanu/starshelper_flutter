import './lesson.dart';

class CTimeTable {
  final String name;
  final Map<String, List<CLesson>> data;

  CTimeTable(this.name, this.data);

  static CTimeTable fromDynamic(dynamic timtableData) {
    Map<dynamic, dynamic> tmpData = timtableData["data"];

    Map<String, List<CLesson>> convertedData = {};
    for(String key in tmpData.keys) {
      List<CLesson> items = [];
      for(dynamic item  in tmpData[key]) {
        items.add(CLesson.fromDynamic(item));
      }
      convertedData[key] = items;
    }

    return CTimeTable(
        timtableData["name"],
        convertedData);
  }

  static Map<String, dynamic> toJson(CTimeTable timtableData) {

    Map<String, List<CLesson>> tmpData = timtableData.data;
    Map<String, dynamic>  convertedData = {};

    for(String key in tmpData.keys) {
      List<Map<String, dynamic>> items = [];
      for(CLesson item  in tmpData[key]) {
        items.add(CLesson.toJson(item));
      }
      convertedData[key] = items;
    }

    return {
      "name": timtableData.name,
      "data": convertedData
    };
  }
}
