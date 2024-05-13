import 'package:flutter/material.dart';

Widget customHeadingtext(String text, double fontSize,
    {Color textColor = const Color.fromARGB(255, 255, 255, 255),
    FontWeight fontWeight = FontWeight.normal}) {
  return Text(
    text,
    style:
        TextStyle(color: textColor, fontSize: fontSize, fontWeight: fontWeight),
        overflow: TextOverflow.ellipsis,
  );
}
Widget customstyletext(String text, double fontSize,
    {Color textColor = const Color.fromARGB(255, 255, 255, 255),
    FontWeight fontWeight = FontWeight.normal}) {
  return Text(
    text,
    style:
        TextStyle(color: textColor, fontSize: fontSize, fontWeight: fontWeight,fontStyle: FontStyle.italic ),
  );
}
//
Widget customtext(String text, double fontSize,
    {Color textColor = const Color.fromARGB(255, 255, 255, 255)}) {
  return Text(
    text,
    style: TextStyle(
      color: textColor,
      fontSize: fontSize,
    ),
  );
}
