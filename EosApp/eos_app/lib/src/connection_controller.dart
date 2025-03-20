import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConnectionController {
  Color color = Colors.white;
  Color _lastSentColor = Colors.white;

  RangeValues range = RangeValues(0, 44);
  RangeValues _lastSentRange = RangeValues(0, 44);

  String dataString = '';

  final String _url = 'http://192.168.2.200:5000/';

  void run() {
    Timer.periodic(Duration(milliseconds: 50), (Timer timer) async {
      if (color != _lastSentColor ||
          range != _lastSentRange ||
          dataString != '') {
        _lastSentColor = color;
        _lastSentRange = range;

        if (dataString != '') {
          await _sendDataString();
        } else {
          await _sendColor();
        }
      }
    });
  }

  Future<void> _sendColor() async {
    try {
      await http.post(
        Uri.parse(_url),
        body:
            '{"red": ${(color.r * 255).toInt()}, "green": ${(color.g * 255).toInt()}, "blue": ${(color.b * 255).toInt()}, "start": ${range.start.round()}, "end": ${range.end.round()}}',
      );
    } catch (e) {
      print('Failed to send color: $e');
    }
  }

  Future<void> _sendDataString() async {
    String temp = dataString;
    dataString = '';
    try {
      await http.post(
        Uri.parse('${_url}data'),
        body: temp,
      );
    } catch (e) {
      print('Failed to send color: $e');
    }
  }

  Future<String> pullColor() async {
    try {
      final response = await http.get(Uri.parse('${_url}pull'));
      return response.body;
    } catch (e) {
      print('Failed to pull color: $e');
      return '';
    }
  }
}
