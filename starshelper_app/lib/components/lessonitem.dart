import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../models/lesson.dart';
import '../utils/helper.dart';

class LessonItem extends StatefulWidget {
  LessonItem({Key key, this.data, this.onSelect, this.isHideSwitch}) : super(key: key);

  final Function onSelect; 
  final CLesson data;
  bool isHideSwitch = false;
  
  @override
  _LessonItemState createState() => _LessonItemState();
}

class _LessonItemState extends State<LessonItem> {
  bool isChecked = false;
  final ctrlEdit = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Padding(padding: EdgeInsets.only(top: 16, bottom: 16), child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text(getTimeStr(widget.data.Start_Time) + " - " + getTimeStr(widget.data.End_Time),
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),),
                        Text(widget.data.Module_Code + " - " + widget.data.Module_Name),
                        Text(widget.data.Type + " @ " + widget.data.Venue),
                        Text("index : " + widget.data.index.toString()),
                      ]
                    ),),),
                    Padding(padding: EdgeInsets.only(left: 8, right: 16), child: 
                    widget.isHideSwitch ? Container() :
                    Switch(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                    ),
                  ],
                ),
              padding: EdgeInsets.all(8),
            );
  }
}
