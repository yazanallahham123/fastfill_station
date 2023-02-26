import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'const_sizes.dart';

void pushToast(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: height13
  );
}