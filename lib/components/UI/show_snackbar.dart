import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, Widget content, [int seconds = 2]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: content,
    duration: Duration(seconds: seconds),
  ));
}
