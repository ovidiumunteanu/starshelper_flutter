import 'package:firebase_database/firebase_database.dart';
import 'package:starshelper_app/models/lesson.dart';

class api_modules {
  
  static final db = FirebaseDatabase.instance.reference().child('Timetable');

  static Future<List<CLesson>> fetchAll() {
    List<CLesson> items = [];
    return db.once().then((DataSnapshot snapshot) {
      for(dynamic item  in snapshot.value) {
        items.add(CLesson.fromDynamic(item));
      }
      return items;
    })
    .catchError((err) {
      print('fetchAll err : $err');
      return items;
    });
  }

}
