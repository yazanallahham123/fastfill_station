import 'package:flutter/widgets.dart';

class SizeConfig {
  static final SizeConfig _sizeConfig = SizeConfig._internal();

  factory SizeConfig() => _sizeConfig;

  static MediaQueryData _mediaQueryData = _mediaQueryData;
  static double width = 0, height = 0;
  final double uiUxHeightValue = 844, uiUxWidthValue = 390;

  static double perHeight = 0, perWidth = 0;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;

    perHeight = height / uiUxHeightValue;
    perWidth = width / uiUxWidthValue;
  }

  double h(double widgetHeight) => perHeight * widgetHeight;

  double w(double widgetWidth) => perWidth * widgetWidth;

  SizeConfig._internal();
}
