import 'package:flutter/material.dart';

void snackBarWithText(BuildContext context, String message) {
  var snackBar = SnackBar(
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
    duration: const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
