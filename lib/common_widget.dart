import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Text getTextView(String txt, double txtSize, FontWeight fontWeight, Color color) {
  //
  return Text(
      txt,
    style: TextStyle(
        color: color,
        fontSize: txtSize,
        fontWeight: fontWeight),
  );
}

AppBar getAppBar(String txt, Icon icon, double elevation, double titleSpacing,
    BuildContext context, Color txtColor) {
  //
  return AppBar(
    leading: IconButton(
      // icon: Icon(Icons.arrow_back),
      icon: icon,
      // onPressed: () { exit(0)},
      // onPressed: () => SystemNavigator.pop(),
      onPressed: () => Navigator.of(context).pop(),
      // onPressed: () => Navigator.pushReplacementNamed(context, "/first"),
    ),
    elevation: elevation,
    titleSpacing: 0,
    title: Text(
      txt,
      style: TextStyle(color: txtColor),
    ),
    // backgroundColor: Color(0xffffffff),
  );
}
