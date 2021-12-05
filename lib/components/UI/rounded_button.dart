import 'dart:ui';

import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {this.myKey,
      required this.title,
      required this.onPressed,
      this.color = Colors.yellow});
  final String? myKey;
  final String title;
  final Color color;
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key != null ? Key(myKey!) : null,
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          primary: color),
    );
  }
}
