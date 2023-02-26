import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../helper/const_sizes.dart';
import '../../helper/const_styles.dart';
import '../../helper/font_styles.dart';
import '../../helper/size_config.dart';
import 'methods.dart';


class TextFieldPasswordWidget extends StatefulWidget {
  final String? hintText;
  final String? errorText;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final bool Function(String? value)? validator;


  TextFieldPasswordWidget(
      {Key? key,
        this.hintText,
        required this.controller,
        this.textInputAction,
        this.focusNode,
        this.onFieldSubmitted,
        this.validator,
        this.errorText})
      : super(key: key);

  @override
  State<TextFieldPasswordWidget> createState() => _TextFieldPasswordWidgetState();
}

class _TextFieldPasswordWidgetState extends State<TextFieldPasswordWidget> {

  bool showError = false;
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig().h(80),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: SizeConfig().h(47),
                  decoration: BoxDecoration(
                    borderRadius: radiusAll10,
                    color: Colors.white,
                  ),
                  child: TextFormField(
                      controller: widget.controller,
                      cursorColor: Colors.black,
                      obscureText: showPassword,
                      focusNode: widget.focusNode,
                      textInputAction: widget.textInputAction,
                      maxLines: 1,
                      onFieldSubmitted: widget.onFieldSubmitted,
                      style: largeMediumPrimaryColor2(),
                      decoration: new InputDecoration(
                          isDense: true,
                          suffixIcon: InkWell(
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    showPassword =
                                    !showPassword;
                                  });
                                }
                              },
                              child: Container(
                                  width: SizeConfig().w(50),
                                  child: Icon(
                                      !showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color(0xffA4B0BF)))),
                          border: OutlineInputBorder(
                            borderRadius: radiusAll10,
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: showError == true
                                      ? Colors.red
                                      : Colors.green,
                                  width: width1),
                              borderRadius: radiusAll10),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: width1),
                              borderRadius: radiusAll10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: showError == true
                                      ? Colors.red
                                      : Colors.green,
                                  width: width1),
                              borderRadius: radiusAll10),
                          hintStyle: smallCustomGreyColor4(),
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              SizeConfig().w(20),
                              0,
                              SizeConfig().w(20),
                              SizeConfig().h(16)),
                          hintText: widget.hintText),
                      onChanged: (stringValue) {
                        if (mounted) {
                          setState(() {
                            showError =
                            (!isStrongPassword(stringValue) ||
                                !isValidator(stringValue));
                          });
                        }
                      })
              ),
              (showError) ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig().w(10)),
                  child:
                  FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                          (!isValidator(widget.controller.text) &&
                              widget.errorText != null)
                              ? widget.errorText!
                              : translate("messages.passContain7Char"),
                          style: errorStyle()))

              ) : Container(),
            ]));
  }

  bool isValidator(String value) {
    if(widget.validator == null) return true;
    return widget.validator!(value);
  }
}
