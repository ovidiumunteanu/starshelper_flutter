import 'dart:developer';
import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:starshelper_app/models/lesson.dart';
import '../models/timetable.dart';

class api_timetables {
  
  static final db = FirebaseDatabase.instance.reference().child('SavedTimeTable');

  static Future<void> createData(CTimeTable timeTableData){
    return db.child(timeTableData.name).set(CTimeTable.toJson(timeTableData));
  }

  // static Future<Void>  updateData(){
  //   return db.child('test').update({
  //     'description': 'CEO'
  //   });
  // }

  // static Future<Void>  deleteData(){
  //   return db.child('test').remove();
  // }

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
