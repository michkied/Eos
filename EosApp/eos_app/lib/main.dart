import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/connection/connection_controller.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());
  final connectionController = ConnectionController();
  connectionController.run();

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // http.get(
  //   Uri.parse('http://127.0.0.1:5000/'),
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   },
  //   // body: '{"color": "${color.toString()}"}',
  // );

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(
      settingsController: settingsController,
      connectionController: connectionController));
}
