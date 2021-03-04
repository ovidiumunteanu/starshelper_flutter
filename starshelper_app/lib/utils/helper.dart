import 'package:flutter/material.dart';

gotoPage(context, page) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}