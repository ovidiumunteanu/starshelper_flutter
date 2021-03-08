import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/constant.dart';
import '../utils/helper.dart';
import '../utils/global.dart';
import '../models/module.dart';
import '../models/combindIndexes.dart';
import '../models/lesson.dart';
import '../models/index.dart';
import './viewtimetable.dart';

class GeneratePage extends StatefulWidget {
  GeneratePage({Key key, this.loading, this.selectedAllmodules}) : super(key: key);

  bool loading;
  List<CModule> selectedAllmodules = [];

  @override
  _GeneratePageState createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  Map<String, List<CLesson>> timetable;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      generateTimeTable();
    });

  }

  Future generateTimeTable() async {
    List<CcombinedIndexes> indexes =
        await compute(getAllcombinedIndexes, widget.selectedAllmodules);

    // for each combined index , create timetable
    Map<String, dynamic> result =
        await compute(getTimetableFromIndexes, indexes);
    if (result != null) {
      print("success");

      Map<String, List<CLesson>> genTimeTable  = result["timetable"];
      Global().availCombinedIndexList = result["indexes"];

      showAlertDialog(context, () {}, () {
        Navigator.of(context, rootNavigator: true).pop();
        gotoPage(context, ViewTmTable(TimeTable: genTimeTable));
      }, "Success!", "Timetable is created");

    } else {
      print("failed");

      showAlertDialog(context, () {}, () {
        Navigator.of(context, rootNavigator: true).pop();
      }, "Warning!", "There is no available timetables.");
    }
  }

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: C_colors.bg,
            border: Border.all(style: BorderStyle.solid, color: Colors.white)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  backgroundColor: C_colors.bg,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              margin: EdgeInsets.only(top: 20),
            ),
            Container(
              child: Text(
                'Please hold while we generate a timetable for you.',
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              margin: EdgeInsets.only(top: 50),
              width: scrWidth * 0.6,
            ),
            Container(
              child: Text(
                'This may take some time, depending on the number of modules.',
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              margin: EdgeInsets.only(top: 20),
              width: scrWidth * 0.7,
            ),
          ],
        ),
      )),
    );
  }
}
