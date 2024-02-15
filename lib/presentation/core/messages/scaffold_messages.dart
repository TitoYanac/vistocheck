import 'package:flutter/material.dart';
void showSuccessMessage(BuildContext context, String message) {
  // cerrar los dialogos de scaffoldmessenger abiertos
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: Colors.green,
  ));
}

void showErrorMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: Colors.red,
  ));
}