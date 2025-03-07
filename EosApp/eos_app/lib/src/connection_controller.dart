import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConnectionController {
  Color color = Colors.white;
  Color _lastSentColor = Colors.white;

  void run() {
    Timer.periodic(Duration(milliseconds: 50), (Timer timer) async {
      if (color != _lastSentColor) {
        _lastSentColor = color;
        await _sendColor(color);
      }
    });
  }

  Future<void> _sendColor(Color color) async {
    try {
      await http.post(
        Uri.parse('http://192.168.2.200:5000/'),
        body:
            '{"red": ${(color.r * 255).toInt()}, "green": ${(color.g * 255).toInt()}, "blue": ${(color.b * 255).toInt()}}',
      );
    } catch (e) {
      print('Failed to send color: $e');
    }
  }
}
