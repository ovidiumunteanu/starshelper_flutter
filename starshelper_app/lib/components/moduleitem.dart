import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../models/module.dart';

class ModuleItem extends StatefulWidget {
  ModuleItem({Key key, this.data, this.onSelect}) : super(key: key);

  final Function onSelect; 
  final CModule data;

  @override
  _ModuleItemState createState() => _ModuleItemState();
}

class _ModuleItemState extends State<ModuleItem> {
  bool isChecked = false;
  final ctrlEdit = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    return Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 8, right: 16), child: Checkbox(value: isChecked, onChanged: (bool new_val){
                      setState(() {
                        isChecked = new_val;
                      });
                      widget.onSelect(new_val, widget.data);
                    },),),
                    Expanded(child: Padding(padding: EdgeInsets.only(top: 0), child: Text(
                      widget.data.Module_Code + " - " + widget.data.Module_Name
                    ),),),
                  ],
                ),
              padding: EdgeInsets.all(8),
            );
  }
}
