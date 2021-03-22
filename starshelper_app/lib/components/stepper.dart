import 'package:flutter/material.dart';
import './roundIconBtn.dart';

class CustomStepper extends StatefulWidget {
  CustomStepper({
    @required this.lowerLimit,
    @required this.upperLimit,
    @required this.stepValue,
    @required this.iconSize,
    @required this.value,
    this.onChange
  });

  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final double iconSize;
  int value;
  Function onChange;

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedIconButton(
          icon: Icons.remove,
          iconSize: widget.iconSize,
          onPress: () {
            if(widget.value > widget.lowerLimit) {
              widget.onChange(widget.value - widget.stepValue);
            } 
            setState(() {
              widget.value =
                  widget.value == widget.lowerLimit ? widget.lowerLimit : widget.value -= widget.stepValue;
            });
          },
        ),
        Container(
          width: widget.iconSize,
          child: Text(
            '${widget.value}',
            style: TextStyle(
              fontSize: widget.iconSize * 0.8,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        RoundedIconButton(
          icon: Icons.add,
          iconSize: widget.iconSize,
          onPress: () {
            if(widget.value < widget.upperLimit) {
              widget.onChange(widget.value + widget.stepValue);
            } 
            setState(() {
              widget.value =
                  widget.value == widget.upperLimit ? widget.upperLimit : widget.value += widget.stepValue;
            });
          },
        ),
      ],
    );
  }
}