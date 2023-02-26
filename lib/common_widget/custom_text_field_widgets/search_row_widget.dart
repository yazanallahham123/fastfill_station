
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../helper/app_colors.dart';
import '../../helper/const_sizes.dart';
import '../../helper/const_styles.dart';
import '../../helper/font_styles.dart';
import '../../helper/size_config.dart';


class SearchRowWidget extends StatelessWidget {
  final TextEditingController controller;

  const SearchRowWidget(
      {Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig().h(37),
        decoration:
            BoxDecoration(borderRadius: radiusAll14, color: backgroundColor),
        child: TextFormField(
            controller: controller,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.search,
            maxLines: 1,
            textAlign: TextAlign.start,
            style: largeMediumPrimaryColor2(),
            decoration: new InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: radiusAll14,
                    borderSide:
                        BorderSide(color: primaryColor2, width: width1)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor1, width: width1),
                    borderRadius: radiusAll14),
                prefixIconConstraints: BoxConstraints(
                    maxWidth: SizeConfig().w(30), minWidth: SizeConfig().w(30)),
                prefixIcon: SvgPicture.asset(
                  'assets/svg/path_5467.svg',
                  fit: BoxFit.scaleDown,
                  color: primaryColor1,
                ),
                hintStyle: smallCustomGreyColor4(),
                contentPadding: EdgeInsetsDirectional.only(top: SizeConfig().h(5)),
                hintText: translate("labels.orderNumber"))));
  }
}
