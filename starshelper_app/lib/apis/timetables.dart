import 'package:firebase_database/firebase_database.dart';
import '../models/timetable.dart';

class api_timetables {
  
  static final db = FirebaseDatabase.instance.reference().child('SavedTimeTable');

  static Future<void> createData(CTimeTable timeTableData){
    return db.child(timeTableData.name).set(CTimeTable.toJson(timeTableData));
  }

  // static Future<void>  updateData(){
  //   return db.child('test').update({
  //     'description': 'CEO'
  //   });
  // }

  static Future<void>  deleteData(String tableName){
    return db.child(tableName).remove();
  }

  static Future<List<CTimeTable>> fetchAll() {
    List<CTimeTable> items = [];
    return db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> data = snapshot.value;
      for(dynamic key  in data.keys) {
        items.add(CTimeTable.fromDynamic(data[key]));
      }
      return items;
    })
    .catchError((err) {
      print('fetchAll err : $err');
      return items;
    });
  }

}
