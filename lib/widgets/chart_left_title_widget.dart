import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff67727d),
    fontWeight: FontWeight.bold,
    fontSize: 10,
  );
  String text;
  switch (value.toInt()) {
    case 30:
      text = '30%';
      break;
    case 50:
      text = '50%';
      break;
    case 0:
      text = '0%';
      break;
    case -30:
      text = '-30%';
      break;
    case -50:
      text = '-50%';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}
