import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:starshelper_app/utils/constant.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import '../components/lessonitem.dart';
// utils
import '../utils/helper.dart';
import '../utils/global.dart';
// models
import '../models/module.dart';
import '../models/combindIndexes.dart';
import '../models/lesson.dart';
import './indexlist.dart';
//
import './tmtlistview.dart';
import './tmtweekview.dart';

class ViewTmTable extends StatefulWidget {
  ViewTmTable(
      {Key key,
      this.isNewTable,
      this.tableName,
      this.TimeTable,
      this.usedIndex})
      : super(key: key);

  bool isNewTable = true;
  String tableName = "";
  Map<String, List<CLesson>> TimeTable = {};
  CcombinedIndexes usedIndex;

  @override
  _ViewTmTableState createState() => _ViewTmTableState();
}

class _ViewTmTableState extends State<ViewTmTable> {
  int curViewId = 0;
  List<String> viewList = ["week view", "tab view"];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tableName),
        backgroundColor: C_colors.bg,
        automaticallyImplyLeading: !widget.isNewTable,
        actions: [
          PopupMenuButton(
            tooltip: '',

            icon: Icon(Icons.more_vert),
            padding: EdgeInsets.all(0),
            initialValue: curViewId,
            onSelected: (value){
              setState(() {
                curViewId = value;
              });
            },
            itemBuilder: (context) {
              return List.generate(viewList.length, (index) {
                // return PopupMenuItem(
                //   value: index,
                //   child: Text('button no $index'),
                // );
                
                return CheckedPopupMenuItem(
                child: Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Text(
                 viewList[index],
                  style: TextStyle(color: Colors.black,),
                ),
                ),
                value: index,
                checked: index == curViewId,
              );
              });
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            curViewId == 0
                ? Expanded(
                    child: TmtableWeekView(
                        isNewTable: widget.isNewTable,
                        tableName: widget.tableName,
                        TimeTable: widget.TimeTable,
                        usedIndex: widget.usedIndex),
                  )
                : Expanded(
                    child: TmtableListview(
                        isNewTable: widget.isNewTable,
                        tableName: widget.tableName,
                        TimeTable: widget.TimeTable,
                        usedIndex: widget.usedIndex),
                  )
          ],
        ),
      ),
    );
  }
}
