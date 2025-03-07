import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'color_preset.dart';
import 'settings_controller.dart';
import 'connection_controller.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.settingsController,
    required this.connectionController,
  });

  final SettingsController settingsController;
  final ConnectionController connectionController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController _presetNameController;

  @override
  void initState() {
    super.initState();
    _presetNameController = TextEditingController();
  }

  @override
  void dispose() {
    _presetNameController.dispose();
    super.dispose();
  }

  Color pickerColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Eos',
          theme: ThemeData(),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
          ),
          home: Scaffold(
            body: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
                  child: ColorPicker(
                    pickerColor: pickerColor,
                    onColorChanged: (Color color) {
                      widget.connectionController.color = color;
                    },
                    colorPickerWidth: 400,
                    pickerAreaHeightPercent: 0.7,
                    enableAlpha: false,
                    displayThumbColor: true,
                    paletteType: PaletteType.hsvWithHue,
                    labelTypes: const [],
                    pickerAreaBorderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(2),
                      topRight: Radius.circular(2),
                    ),
                    portraitOnly: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _presetNameController,
                          decoration: const InputDecoration(
                            labelText: 'Preset name',
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle add color button press
                          widget.settingsController.addColorPreset(
                            ColorPreset(
                              red: (widget.connectionController.color.r * 255)
                                  .toInt(),
                              green: (widget.connectionController.color.g * 255)
                                  .toInt(),
                              blue: (widget.connectionController.color.b * 255)
                                  .toInt(),
                              label: _presetNameController.text,
                            ),
                          );
                          _presetNameController.clear();
                        },
                        child: const Text('Add Color'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Builder(builder: (context) {
                      if (widget.settingsController.colorPresets.isEmpty) {
                        return Center(
                          child: ElevatedButton(
                              onPressed: () =>
                                  widget.settingsController.setDefaults(),
                              child: Text("Load defaults")),
                        );
                      }

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount:
                            widget.settingsController.colorPresets.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                color: Color.fromRGBO(
                                  widget.settingsController.colorPresets[index]
                                      .red,
                                  widget.settingsController.colorPresets[index]
                                      .green,
                                  widget.settingsController.colorPresets[index]
                                      .blue,
                                  1,
                                ),
                                width: 5,
                              ),
                            ),
                            onPressed: () {
                              widget.connectionController.color =
                                  Color.fromRGBO(
                                widget
                                    .settingsController.colorPresets[index].red,
                                widget.settingsController.colorPresets[index]
                                    .green,
                                widget.settingsController.colorPresets[index]
                                    .blue,
                                1,
                              );
                              setState(() {
                                pickerColor = widget.connectionController.color;
                              });
                            },
                            onLongPress: () {
                              widget.settingsController.removeColorPreset(widget
                                  .settingsController.colorPresets[index]);
                            },
                            child: Text(
                              widget
                                  .settingsController.colorPresets[index].label,
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
