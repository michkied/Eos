import 'package:flutter/material.dart';

class ColorPreset {
  late Color color;
  final String label;

  final int red;
  final int green;
  final int blue;

  String dataString;

  ColorPreset(
      {required this.red,
      required this.green,
      required this.blue,
      required this.label,
      this.dataString = ''}) {
    color = Color.fromRGBO(red, green, blue, 1);
  }

  factory ColorPreset.fromJson(Map<String, dynamic> jsonData) {
    try {
      return ColorPreset(
        red: jsonData['red'],
        green: jsonData['green'],
        blue: jsonData['blue'],
        label: jsonData['label'],
        dataString: jsonData['dataString'],
      );
    } catch (e) {
      return ColorPreset(
        red: jsonData['red'],
        green: jsonData['green'],
        blue: jsonData['blue'],
        label: jsonData['label'],
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'red': red,
      'green': green,
      'blue': blue,
      'label': label,
      'dataString': dataString,
    };
  }
}
