import 'package:flutter/material.dart';
void checkLength(int length, TextEditingController controller) {
  String text = controller.text;
  if (text.length > length) {
    controller.text = text.substring(0, length);
    controller.selection = TextSelection.fromPosition(TextPosition(offset: length));
  }
}