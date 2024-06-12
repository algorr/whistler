import 'package:flutter/material.dart';

class ColorManager {
  //static Color primary = HexColor.fromHex("#ED9728");
  static Color primary = Colors.transparent;
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryWith70Opacity = HexColor.fromHex("#B3ED9728");
  static Color darkPrimary = HexColor.fromHex("#d17d11");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color black = Colors.black;
  static Color newBlack = HexColor.fromHex("#3c3c3c");
  static Color newWhite = HexColor.fromHex("#e1e1e1");
  static Color error = HexColor.fromHex("#e61f34");
  static Color red = HexColor.fromHex("#F45050");
  static Color blue = HexColor.fromHex("#394867");
  static Color green = Colors.green;
  static Color blue1 = Colors.blue;
  static Color pink = Colors.pink;
  static Color orange = Colors.orange;
  static Color purple = Colors.purple;
  static Color scaffoldColor = HexColor.fromHex('#e1e1e1');
  static Color profileContainerColor = HexColor.fromHex('#eeeeee');
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
