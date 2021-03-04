import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key, this.placeholder, this.width}) : super(key: key);

  final String placeholder;
  final double width;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final ctrlEdit = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    return Container(
              width: widget.width,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 8, right: 16), child: Icon(Feather.search, size: 20, color: Colors.black54,),),
                    Expanded(child: Padding(padding: EdgeInsets.only(top: 12), child: TextFormField(
                      controller: ctrlEdit,
                      style: TextStyle(color: Colors.black87),
                      onChanged: (text) {
                      },
                      decoration: InputDecoration( hintText: widget.placeholder, hintStyle: TextStyle(color: Colors.black54), border: InputBorder.none),
                      ),),),
                  ],
                ),
              padding: EdgeInsets.all(8),
            );
  }
}
