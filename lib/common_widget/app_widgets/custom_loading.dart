import 'package:flutter/material.dart';

import '../../helper/app_colors.dart';

class CustomLoading extends StatelessWidget{
  const CustomLoading();
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: buttonColor1));
  }

}