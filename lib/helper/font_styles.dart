import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'const_sizes.dart';
import 'methods.dart';

TextStyle mediumBackground2() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: backgroundColor1,
    fontWeight: FontWeight.w500);

TextStyle mediumBackground() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: backgroundColor,
    fontWeight: FontWeight.w500);

TextStyle smallCustomGrey5() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height13 : height10,
    color: customGreyColor5);

TextStyle mediumLowWeightBackground() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: backgroundColor);

TextStyle smallPrimaryColor1() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height13 : height10,
    color: primaryColor1);

TextStyle largerWhite() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height17 : height14,
    color: backgroundColor,
    fontWeight: FontWeight.w500);

TextStyle mediumPrimaryColor1() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: primaryColor1,
    fontWeight: FontWeight.w500);

TextStyle largePrimaryColor1() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height17 : height14,
    color: primaryColor1,
    fontWeight: FontWeight.w500);

TextStyle mediumCustomGreen2() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: customGreenColor2);

TextStyle mediumCustomGreyColor5() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: customGreyColor5);

TextStyle largeMediumPrimaryColor3() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height17 : height14,
    color: textColor2,
    fontWeight: FontWeight.w500);

TextStyle largeMediumPrimaryColor2() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height17 : height14,
    color: primaryColor2,
    fontWeight: FontWeight.w500);

TextStyle mediumPrimaryColor2() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: primaryColor2,
    fontWeight: FontWeight.w500);

TextStyle mediumLowWeightPrimaryColor2() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: primaryColor2);

TextStyle mediumLowWeightBlack() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: Colors.black);

TextStyle mediumCustomGrey5() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: customGreyColor5,
    fontWeight: FontWeight.w300);

TextStyle mediumCustomGrey6() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: customGreyColor6,
    fontWeight: FontWeight.w500);

TextStyle largerMediumPrimaryColor2() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height16,
    color: primaryColor2,
    fontWeight: FontWeight.w500);

TextStyle largerMediumPrimaryColor1() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height16,
    color: primaryColor1,
    fontWeight: FontWeight.w500);

TextStyle mediumLowWeightPrimaryColor1() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: primaryColor1);

TextStyle errorStyle() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height17 : height14,
    color: Colors.red,
    fontWeight: FontWeight.w500);

TextStyle boldPrimaryColor2() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height17 : height14,
    color: primaryColor2,
    fontWeight: FontWeight.w600);

TextStyle largePrimaryColor2() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height17 : height14,
    color: primaryColor2);

TextStyle smallCustomGreyColor8() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: customGreyColor8);

TextStyle smallRedColor1() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: customRedColor1);

TextStyle boldBigWhite() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height17 : height14,
    color: Colors.white,
    fontWeight: FontWeight.w700);

TextStyle mediumWhite() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height17 : height14,
    color: Colors.white);

TextStyle smallWhite() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    color: Colors.white,
    fontSize: isArabic() ? height13 : height10,
    fontWeight: FontWeight.w300);

TextStyle smallBackgroundColor() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height13 : height10,
    color: backgroundColor);

TextStyle smallCustomGreyColor4() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height13 : height10,
    color: customGreyColor4,
    fontWeight: FontWeight.w500);

TextStyle smallCustomGreyColor5() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height13 : height10,
    color: hintColor2,
    fontWeight: FontWeight.w500);

TextStyle verBigPrimaryColor2() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height21 : height18,
    color: primaryColor2,
    fontWeight: FontWeight.w700);

TextStyle superMediumPrimaryColor2() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height17 : height14,
    color: primaryColor2,
    fontWeight: FontWeight.w700);

TextStyle veryLargeBackground() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height21 : height18,
    color: backgroundColor,
    fontWeight: FontWeight.w500);

TextStyle boldBackgroundColor() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: backgroundColor,
    fontWeight: FontWeight.w600);

TextStyle smallLowWeightPrimaryColor1() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: primaryColor1,
    fontWeight: FontWeight.w300);

TextStyle mediumCustomGreyColor4() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: customGreyColor4,
    fontWeight: FontWeight.w500);

TextStyle boldPrimaryColor1() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: primaryColor1,
    fontWeight: FontWeight.w600);

TextStyle mediumCustomGrey2() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: customGreyColor2,
    fontWeight: FontWeight.w500);

TextStyle smallPrimaryColor2() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height13 : height10,
    color: primaryColor2,
    fontWeight: FontWeight.w500);

TextStyle bigPrimaryColor2() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height19 : height16,
    color: primaryColor2);

TextStyle mediumGreyColor() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: customGreyColor1);

TextStyle mediumGreen() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: customGreenColor1,
    fontWeight: FontWeight.w500);

TextStyle invisibleStyle() => TextStyle(
    fontFamily: isArabic() ? 'Poppins' : 'Poppins',
    fontSize: isArabic() ? height15 : height12,
    color: const Color(0x3d000000));
