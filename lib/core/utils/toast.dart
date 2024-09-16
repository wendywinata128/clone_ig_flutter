// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { SUCCESS, FAILED }

void showToastMessage(String msg, {ToastType type = ToastType.SUCCESS}) {
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor: type == ToastType.SUCCESS
          ? Colors.green.shade500
          : Colors.red.shade500);
}
