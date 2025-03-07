import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/connection_controller.dart';
import 'src/settings_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsController = SettingsController();
  await settingsController.loadSettings();

  final connectionController = ConnectionController();
  connectionController.run();

  runApp(MyApp(
      settingsController: settingsController,
      connectionController: connectionController));
}
