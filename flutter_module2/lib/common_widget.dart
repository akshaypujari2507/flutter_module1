import 'package:flutter/material.dart';

Text getTextView(String txt, double txtSize, FontWeight fontWeight) {
  //
  return Text(
      txt,
    style: TextStyle(
        color: Colors.white,
        fontSize: txtSize,
        fontWeight: fontWeight),
  );
}