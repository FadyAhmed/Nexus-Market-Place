import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, Widget content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: content,
    duration: const Duration(seconds: 2),
  ));
}
