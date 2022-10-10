import 'package:flutter/material.dart';
import 'dart:math';

class Palette {
  // static const MaterialColor kToDark = const MaterialColor(
  //   0xffFFF2F0, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
  //   const <int, Color>{
  //     50: const Color(0xffE5D0D3),//10%
  //     100: const Color(0xffC7AFBA),//20%
  //     200: const Color(0xffA591A6),//30%
  //     300: const Color(0xff7E7692),//40%
  //     400: const Color(0xff515E7E),//50%
  //     // 500: const Color(0xff5c261d),//60%
  //     // 600: const Color(0xff451c16),//70%
  //     // 700: const Color(0xff2e130e),//80%
  //     // 800: const Color(0xff170907),//90%
  //     // 900: const Color(0xff000000),//100%
  //   },
  // );
  static const Color primary = Color(0xfffff2f0);
  static const Color primaryPurple = Color(0xff6d3078);
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);
