import 'package:oktoast/oktoast.dart';
import "package:flutter/material.dart";

void showFlutterToast(String content, seconds) {
  showToast(
    content,
    duration: Duration(seconds: seconds),
    position: ToastPosition.bottom,
    backgroundColor: Colors.black.withOpacity(0.6),
    radius: 30.0,
    textStyle: TextStyle(
      fontSize: 14.0,
      color: Colors.white,
    ),
    textPadding: EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 15,
    ),
  );
}
