import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Color white = HexColor("FFFFFF");
Color black = HexColor("000000");
Color bluePrimary = HexColor("0B0C2B");
Color grey1 = HexColor("BFC0D2");
Color grey2 = HexColor("5B5B6E");
Color grey3 = HexColor("#c2c6d4");
Color redError = HexColor("FF0000");
Color brick = HexColor("#c24a44");
Color softBrick = HexColor("#ae8069");
Color purpleGrey = HexColor("#5e6586");
Color blue1 = HexColor("#5e6586");
Color blue2 = HexColor("#6381b2");
Color tosca = HexColor("#8dadab");
Color darkTosca = HexColor('#637979');

Color randomColor() {
  final predefinedColors = [tosca, darkTosca];
  Random random = Random();
  return predefinedColors[random.nextInt(predefinedColors.length)];
}

Color randomBlue() {
  final predefinedColors = [grey3, blue1, blue2, bluePrimary];
  Random random = Random();
  return predefinedColors[random.nextInt(predefinedColors.length)];
}

Color generateRandomColor() {
  final predefinedColors = [
    grey3,
    blue1,
    blue2,
    purpleGrey,
    brick,
    softBrick,
  ];
  Random random = Random();
  return predefinedColors[random.nextInt(predefinedColors.length)];
}

Color randomize() {
  final predefinedColors = [
    blue1,
    purpleGrey,
    softBrick,
    tosca,
  ];
  Random random = Random();
  return predefinedColors[random.nextInt(predefinedColors.length)];
}
