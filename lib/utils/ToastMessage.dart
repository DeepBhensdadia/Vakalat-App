import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vakalat_flutter/color/customcolor.dart';

class ToastMessage {
  Widget? showmessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: CustomColor().colorgrey,
      textColor: CustomColor().colorPrimary,
      fontSize: 15,
    );
    return null;
  }
}
