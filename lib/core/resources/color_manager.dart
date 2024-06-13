import 'package:flutter/material.dart';

class ColorManager {
  //static Color primary = HexColor.fromHex("#ED9728");
  static Color primary = Colors.black;
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = Colors.grey;
  static Color red = Colors.red;
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryWith70Opacity = HexColor.fromHex("#B3ED9728");
  static Color darkPrimary = HexColor.fromHex("#d17d11");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color white70 = HexColor.fromHex("#B3FFFFFF");
  static Color error = HexColor.fromHex("#e61f34");
  static Color blue = HexColor.fromHex("#1B97F3");
  static Color fortuneWheelItemColor = HexColor.fromHex('#476072');
  static Color neumorphicColor = HexColor.fromHex('#efeeee');
  static Color bezierColor1 = const Color(0xff7295ad);
  static Color bezierColor2 = const Color(0xff476072);
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString';
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
