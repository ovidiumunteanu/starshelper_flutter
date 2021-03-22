import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class PaginationBtn extends StatefulWidget {
  PaginationBtn({this.onPrev, this.onNext, this.isPrevDisabled, this.isNextDisabled});

  Function onPrev;
  Function onNext;
  bool isPrevDisabled;
  bool isNextDisabled;

  @override
  _PaginationBtnState createState() => _PaginationBtnState();
}

class _PaginationBtnState extends State<PaginationBtn> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints.tightFor(width: 60, height: 28),
            elevation: 6.0,
            onPressed: (){
              if(widget.isPrevDisabled) { return; }
              widget.onPrev();
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            fillColor: widget.isPrevDisabled == true? Colors.grey[400]: Color(0xFF65A34A),
            highlightColor:  widget.isPrevDisabled == true? Colors.transparent : Colors.white38,
            splashColor: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chevron_left_outlined,
                  color: Colors.white,
                  size: 18,
                ),
                Text("Prev", style: TextStyle(color: Colors.white),)
              ],
            )),
        Container(width: 4),
        RawMaterialButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints.tightFor(width: 60, height: 28),
            elevation: 6.0,
            onPressed: (){
              if(widget.isNextDisabled) { return; }
              widget.onNext();
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            fillColor: widget.isNextDisabled == true? Colors.grey[400]: Color(0xFF65A34A),
            highlightColor:  widget.isNextDisabled == true? Colors.transparent : Colors.white38,
            splashColor: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Next", style: TextStyle(color: Colors.white),),
                Icon(
                  Icons.chevron_right_outlined,
                  color: Colors.white,
                  size: 18,
                )
              ],
            )),
      ],
    );
  }
}
