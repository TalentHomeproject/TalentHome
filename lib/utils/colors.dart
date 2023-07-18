import 'package:flutter/material.dart';

const Color tdRed = Color(0xFFDA4040);

const Color tdBlue = Color(0xFF5F52EE);

const Color tdBlack = Color(0xFF3A3A3A);

const Color tdGrey = Color(0xFF717171);

const Color tdBGColor = Color(0xFFEEEFF5);

hexStringToColor(String hexColor) {
  hexColor = hexColor.toLowerCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}
