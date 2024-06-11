// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:tenbytes/widgets/colors.dart';

class TextView extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final String fontfamily;
  const TextView(
      {Key? key,
      required this.text,
      this.fontSize = 13,
      this.textColor = appGreyColor,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.start,
      this.fontfamily = 'RedHatDisplayRegular'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontFamily: fontfamily,
        fontWeight: fontWeight,
      ),
    );
  }
}
