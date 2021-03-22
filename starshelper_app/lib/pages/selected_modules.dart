import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:starshelper_app/utils/constant.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../models/module.dart';
import '../models/combindIndexes.dart';
import '../models/lesson.dart';
import '../models/index.dart';
import '../utils/helper.dart';
import '../utils/global.dart';
import './timetable.dart';

class SelectedModulesPage extends StatefulWidget {
  SelectedModulesPage({Key key, this.selectedAllmodules}) : super(key: key);

  final String title = "Selected Modules";
  List<CModule> selectedAllmodules = [];

  @override
  _SelectedModulesPageState createState() => _SelectedModulesPageState();
}

class _SelectedModulesPageState extends State<SelectedModulesPage> {
  final ctrlEdit = TextEditingController();

  @override
  void initState() {
    super.initState();

    Global().selectedAllModules = widget.selectedAllmodules;
  }

  proceed() {
    showLoaderDialog(context, "Please hold while we generate a timetable for you.", "This may take some time, depending on the number of modules.");
    generateTimeTable();
  }

  // generate timetable
  Future generateTimeTable() async {
    // get all available index combines from selected modules
    List<CcombinedIndexes> indexes =
        await compute(getAllcombinedIndexes, widget.selectedAllmodules);

    // for each combined index , create timetable, 
    // this function returns the created timetable and all indexes and used indexes for this timetable
    Map<String, dynamic> result =
        await compute(getTimetableFromIndexes, indexes);
    if (result != null) {
      Navigator.of(context, rootNavigator: true).pop(); // close loading modal
      print("success");

      Map<String, List<CLesson>> genTimeTable  = result["timetable"];
      Global().availCombinedIndexList = result["indexes"]; // backup all indexes to global to use it later 
      
      // show success modal
      showAlertDialog(context, null, () {
        Navigator.of(context, rootNavigator: true).pop(); // close this modal
        // go to preview timetable page
        gotoPage(context, ViewTmTable(isNewTable: true, tableName: "", TimeTable: genTimeTable, usedIndex: result["usedIndex"],));
      }, "Success!", "Timetable is created");

    } else {
      print("failed");

      Navigator.of(context, rootNavigator: true).pop();
      showAlertDialog(context, null, () {
        Navigator.of(context, rootNavigator: true).pop();
      }, "Warning!", "There is no available timetables.");
    }
  }

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: C_colors.bg,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: Column(
                    children: widget.selectedAllmodules
                        .map(
                          (moduleItem) => Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Material(
                                  color: Colors.white,
                                  child: ListTile(
                                    title: Text(
                                      moduleItem.Module_Code,
                                      style: TextStyle(color: Colors.black87),
                                      textAlign: TextAlign.start,
                                    ),
                                    subtitle: Text(
                                      moduleItem.Module_Name,
                                      style: TextStyle(color: Colors.black87),
                                      textAlign: TextAlign.start,
                                    ),
                                    onTap: () {},
                                    horizontalTitleGap: 20,
                                  ),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.only(
                                top: 4, bottom: 4, left: 3, right: 3),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    "Tap on the modules to see the available index and timeslots.",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
              padding: EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 12),
              decoration: BoxDecoration(color: Colors.black26),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.selectedAllmodules.length}" +
                              " Modules selected",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          "Tap the plus to proceed",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      proceed();
                    },
                    child: Icon(
                      Feather.plus,
                      color: Colors.white,
                      size: 20,
                    ),
                    backgroundColor: C_colors.btnbg,
                  ),
                ],
              ),
              padding:
                  EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
              decoration: BoxDecoration(color: C_colors.bg),
            ),
          ],
        ),
      ),
    );
  }
}
