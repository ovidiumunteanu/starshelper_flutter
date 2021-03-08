import 'dart:developer';

import 'package:flutter/material.dart';
import '../models/module.dart';
import '../models/index.dart';
import '../models/lesson.dart';
import '../models/combindIndexes.dart';
import './global.dart';

showAlertDialog(BuildContext context, Function onCancel, Function onOk,
    String title, String message) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: onCancel,
  );
  Widget continueButton = TextButton(
    child: Text("Ok"),
    onPressed: onOk,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      // cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showLoaderDialog(BuildContext context, String title, String message) {
  double scrWidth = MediaQuery.of(context).size.width;

  AlertDialog alert = AlertDialog(
    content: Wrap(spacing: 25, alignment: WrapAlignment.center, children: [
      new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 35),
            child: SizedBox(
              width: 35,
              height: 35,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ),
          title != null
              ? Container(
                  margin: EdgeInsets.only(left: 7, top: 12),
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                    textAlign: TextAlign.center,
                  ))
              : Container(),
          message != null
              ? Container(
                  margin: EdgeInsets.only(left: 7, top: 20, bottom: 20),
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                    textAlign: TextAlign.center,
                  ))
              : Container(),
        ],
      ),
    ]),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showSaveTimeTableDialog(
  BuildContext context,
  Function onCancel,
  Function onSave,
) {
  final ctrlEdit = TextEditingController();
  double scrWidth = MediaQuery.of(context).size.width;

  Widget cancelButton = TextButton(
    child: Text("CANCEL"),
    onPressed: onCancel,
  );
  Widget continueButton = TextButton(
    child: Text("SAVE"),
    onPressed: () {
      onSave(ctrlEdit.value.text);
    },
  );

  AlertDialog alert = AlertDialog(
    content: Container(
      width: scrWidth * 0.9,
      height: 180,
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(left: 7, top: 12),
                child: Text(
                  "Please enter a name for the timetable",
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                  textAlign: TextAlign.center,
                )),
            Container(
                margin: EdgeInsets.only(left: 7, top: 20, bottom: 4),
                child: Text(
                  "Timetable Name",
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                )),
            Container(
              width: double.infinity,
              height: 80,
              child: TextFormField(
                controller: ctrlEdit,
                style: TextStyle(color: Colors.black87),
              ),
            )
          ]),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

gotoPage(context, page) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}
gotoPageReplacement(context, page) {
  return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
}

Map<String, dynamic> getTimetableFromIndexes(List<CcombinedIndexes> indexes) {
  for (CcombinedIndexes item in indexes) {
    if (item.genPossible == true && item.isUsed == false) {
      Map<String, List<CLesson>> genTimeTable = createTimeTable(item);
      if (genTimeTable != null) {
        item.genPossible = true;
        item.isUsed = true;

        return {
          "timetable": genTimeTable,
          "indexes": indexes,
          "usedIndex": item
        };
      } else {
        item.genPossible = false;
        item.isUsed = true;
      }
    }
  }

  return null;
}

List<CcombinedIndexes> getAllcombinedIndexes(List<CModule> selectedAllModules) {
  List<CcombinedIndexes> indexes = [];

  List<List<CIndex>> tmpIndexes = [];
  for (CModule module in selectedAllModules) {
    tmpIndexes.add(module.indexes);
  }
  // get combined indexes
  List<List<CIndex>> indexModules = cartesian(
      tmpIndexes); // calculate all possible combination (catesian product operation)
  for (List<CIndex> items in indexModules) {
    indexes.add(CcombinedIndexes(true, false, items));
  }
  return indexes;
}

Map<String, List<CLesson>> createTimeTable(CcombinedIndexes indexes) {
  List<CLesson> lessons = [];
  for (CIndex item in indexes.indexModules) {
    lessons.addAll(item.lessons);
  }

  bool crashed = false;
  Map<String, List<CLesson>> timetable = {};
  for (CLesson lesson in lessons) {
    if (timetable[lesson.Day] == null) {
      timetable[lesson.Day] = [];
      timetable[lesson.Day].add(lesson);
    } else {
      // compare this lesson with current existing lessons in order to check if this lesson can be add this timetable

      for (CLesson item in timetable[lesson.Day]) {
        if (isCrash(item, lesson) == false) {
          crashed = false;
        } else {
          crashed = true;
        }
      }
      if (crashed) {
        return null;
      } else {
        timetable[lesson.Day].add(lesson);
      }
    }
  }
  return timetable;
}

List<List<T>> cartesian<T>(List<List<T>> list) {
  var head = list[0];
  var tail = list.skip(1).toList();
  List<List<T>> remainder = tail.length > 0 ? cartesian([...tail]) : [[]];
  List<List<T>> rt = [];
  for (var h in head) {
    for (var r in remainder) rt.add([h, ...r]);
  }
  return rt;
}

bool isCrash(CLesson lesson1, CLesson lesson2) {
  // print(lesson1.Day);
  // print(lesson2.Day);
  // print(lesson1.Start_Time);
  // print(lesson1.End_Time);
  // print(lesson2.Start_Time);
  // print(lesson2.End_Time);
  if ((lesson1.Day == lesson2.Day) &&
      (lesson1.Start_Time < lesson2.End_Time) &&
      (lesson1.End_Time > lesson2.Start_Time)) {
    return true;
  }
  return false;
}
