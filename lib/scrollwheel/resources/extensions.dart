import 'package:airline_tag_ui/scrollwheel/bottom_picker.dart';
import 'package:airline_tag_ui/scrollwheel/resources/arrays.dart';
import 'package:flutter/material.dart';

const double tabletMinSize = 768.0;

extension ContextExtensions on BuildContext {
  double get bottomPickerWidth =>
      MediaQuery.of(this).size.width >= tabletMinSize
          ? MediaQuery.of(this).size.width * 0.7
          : MediaQuery.of(this).size.width;

  double get bottomPickerHeight =>
      MediaQuery.of(this).size.height >= tabletMinSize
          ? MediaQuery.of(this).size.height * 0.35
          : MediaQuery.of(this).size.height * 0.45;
}

extension BottomPickerExtension on BottomPicker {
  List<Color> get gradientColor => gradientColors != null
      ? gradientColors!
      : defaultColors[bottomPickerTheme]!;

  void assertInitialValues() {
    if (minDateTime != null && maxDateTime != null) {
      assert(minDateTime!.isBefore(maxDateTime!));
    }
    if (maxDateTime != null &&
        initialDateTime == null &&
        DateTime.now().isAfter(maxDateTime!)) {
      initialDateTime = maxDateTime;
    }

    if (minDateTime != null &&
        initialDateTime == null &&
        DateTime.now().isBefore(minDateTime!)) {
      initialDateTime = minDateTime;
    }
  }
}
