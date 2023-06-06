import 'package:flutter/material.dart' show Color;

extension StringToColor on String {
  Color stringToColor() => Color(
        int.parse(
          replaceString(),
          radix: 16,
        ),
      );
}

extension ReplaceString on String {
  String replaceString() {
    String str = replaceAll('#', '');
    if (str.length == 6) {
      return "ff$str";
    } else if (str.length == 8) {
      return str;
    }
    throw Exception('Incomplete Color String');
  }
}
