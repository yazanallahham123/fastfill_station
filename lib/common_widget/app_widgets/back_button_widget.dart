import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../helper/methods.dart';
import '../../helper/size_config.dart';
import '../../utils/misc.dart';

class BackButtonWidget extends StatelessWidget{
  const BackButtonWidget(BuildContext context);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        hideKeyboard(context);
          Navigator.pop(context);
        },
      child: Container(
          alignment: Alignment.topLeft,
          height: SizeConfig().h(50),
          width: SizeConfig().w(50),
          margin: EdgeInsets.symmetric(
              horizontal: SizeConfig().w(12),
              vertical: SizeConfig().h(25)),
          child: (isArabic()) ? Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: SvgPicture.asset(
                'assets/svg/backarrow.svg',
                width: SizeConfig().w(50),
              )) : SvgPicture.asset(
            'assets/svg/backarrow.svg',
            width: SizeConfig().w(50),
          )),
    );
  }

}