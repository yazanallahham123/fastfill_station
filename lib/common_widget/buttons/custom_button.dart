
import 'package:flutter/material.dart';

import '../../helper/app_colors.dart';
import '../../helper/const_styles.dart';
import '../../helper/font_styles.dart';
import '../../helper/size_config.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final Color backColor;
  final Color borderColor;
  final Color titleColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double? height;

  const CustomButton({Key? key, required this.title, this.onTap, this.backColor=primaryColor1, this.borderColor=primaryColor1, this.titleColor=backgroundColor, this.fontSize=12,
  this.fontWeight = FontWeight.normal,
    this.height
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextStyle s =
        TextStyle(inherit: mediumBackground().inherit,
        color: titleColor,
          fontFamily: mediumBackground().fontFamily,
          background: mediumBackground().background,
        backgroundColor: mediumBackground().backgroundColor,
    debugLabel: mediumBackground().debugLabel,
          decoration: mediumBackground().decoration,
          decorationColor: mediumBackground().decorationColor,
          decorationStyle: mediumBackground().decorationStyle,
          decorationThickness: mediumBackground().decorationThickness,
            fontFamilyFallback: mediumBackground().fontFamilyFallback,
          fontFeatures: mediumBackground().fontFeatures,
          fontSize: fontSize,
          fontStyle: mediumBackground().fontStyle,
          fontWeight: fontWeight,//mediumBackground().fontWeight,
          foreground: mediumBackground().foreground,
          height: mediumBackground().height,
          leadingDistribution: mediumBackground().leadingDistribution,
          letterSpacing: mediumBackground().letterSpacing,
          locale: mediumBackground().locale,
            overflow: mediumBackground().overflow,
          shadows: mediumBackground().shadows,
          textBaseline: mediumBackground().textBaseline,
          wordSpacing: mediumBackground().wordSpacing
        );

    return InkWell(onTap: onTap,
      borderRadius: radiusAll14,
      child: Container(alignment: Alignment.center,
        child: Text(title,style: s),
        height: height??SizeConfig().h(45),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1),
          borderRadius: radiusAll14,
          color: backColor
        ),
      ),
    );
  }
}
