import 'package:flutter/material.dart';

class ColorPreset {
  late Color color;
  final String label;

  final int red;
  final int green;
  final int blue;

  ColorPreset(
      {required this.red,
      required this.green,
      required this.blue,
      required this.label}) {
    color = Color.fromRGBO(red, green, blue, 1);
  }

  factory ColorPreset.fromJson(Map<String, dynamic> jsonData) {
    return ColorPreset(
      red: jsonData['red'],
      green: jsonData['green'],
      blue: jsonData['blue'],
      label: jsonData['label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'red': red,
      'green': green,
      'blue': blue,
      'label': label,
    };
  }
}
