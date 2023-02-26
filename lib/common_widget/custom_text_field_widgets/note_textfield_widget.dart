
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../helper/app_colors.dart';
import '../../helper/font_styles.dart';
import '../../helper/size_config.dart';


class NoteTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final String? aboveTitle,hintTitle;

  const NoteTextFieldWidget(
      {Key? key,
      required this.controller,
      this.focusNode,
      this.onFieldSubmitted,
      this.aboveTitle, this.hintTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(aboveTitle != null ? aboveTitle! : translate("labels.note"),
          style: largePrimaryColor2()),
      Container(
          height: SizeConfig().h(80),
          padding: EdgeInsetsDirectional.only(
              top: SizeConfig().h(7), bottom: SizeConfig().h(21)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: customGreyColor7),
          child: TextFormField(
              controller: controller,
              textAlign: TextAlign.start,
              scrollPadding: EdgeInsets.zero,
              cursorColor: primaryColor2,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              minLines: 2,
              focusNode: focusNode,
              onFieldSubmitted: onFieldSubmitted,
              style: mediumPrimaryColor2(),
              decoration: InputDecoration(
                hintText: hintTitle,
                  hintStyle: smallCustomGreyColor4(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none)))
    ]);
  }
}
