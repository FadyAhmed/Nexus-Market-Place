import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return SizedBox(
      width: 310.w,
      height: 42.h,
      child: ElevatedButton(
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
      ),
    );
  }
}
