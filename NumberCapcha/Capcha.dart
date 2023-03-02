// ignore_for_file: file_names, unnecessary_this

import 'package:flutter/material.dart';
import 'NumberCapchaDialog.dart';

class FlutterNumberCaptcha {
  static Future<bool> show(
    context, {
    String titleText = 'Enter correct number',
    String placeholderText = 'Enter Number',
    String checkCaption = 'Check',
    String invalidText = 'Invalid Code',
    Color? accentColor,
  }) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return NumberCaptchaDialog(
          titleText,
          placeholderText,
          checkCaption,
          invalidText,
          accentColor: accentColor,
        );
      },
    );
    if (result == true) {
      return true;
    }
    return false;
  }
}
