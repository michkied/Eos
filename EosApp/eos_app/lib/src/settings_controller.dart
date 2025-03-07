import 'dart:convert';

import 'package:eos_app/src/color_preset.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController with ChangeNotifier {
  List<ColorPreset> colorPresets = [];

  void setDefaults() {
    colorPresets = [
      ColorPreset(red: 0, green: 0, blue: 0, label: "Off"),
      ColorPreset(red: 255, green: 0, blue: 0, label: 'Red'),
      ColorPreset(red: 0, green: 255, blue: 0, label: 'Green'),
      ColorPreset(red: 0, green: 0, blue: 255, label: 'Blue'),
    ];
    _saveColorPresets();
    notifyListeners();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('colorPresets');
    if (data != null) {
      final List<dynamic> list = jsonDecode(data);
      colorPresets = list.map((e) => ColorPreset.fromJson(e)).toList();
    } else {
      setDefaults();
    }
  }

  Future<void> addColorPreset(ColorPreset colorPreset) async {
    colorPresets.add(colorPreset);
    notifyListeners();
    await _saveColorPresets();
  }

  Future<void> removeColorPreset(ColorPreset colorPreset) async {
    colorPresets.remove(colorPreset);
    notifyListeners();
    await _saveColorPresets();
  }

  Future<void> _saveColorPresets() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('colorPresets', json.encode(colorPresets));
  }
}
