import 'package:flutter/material.dart';

class Imagebanners extends StatelessWidget {
  final String _assetPath;
  Imagebanners(this._assetPath);
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(
          height: 350.0,
        ),
        decoration: BoxDecoration(color: Colors.white),
        child: Image.asset(
          _assetPath,
          fit: BoxFit.cover,
        ));
  }
}
