import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    this.myKey,
    required this.title,
    required this.onPressed,
    this.color = Colors.yellow,
    this.large = true,
  });
  final String? myKey;
  final String title;
  final Color color;
  final bool large;
  final VoidCallback onPressed;

  Widget get titleWidget {
    if (title == '+') {
      return Icon(Icons.add, size: 20.sp);
    } else if (title == '-') {
      return Icon(Icons.remove, size: 18.sp);
    } else {
      return Text(
        title,
        style: TextStyle(fontSize: 24.sp),
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: large ? 310.w : 40.sp,
      height: large ? 42.h : 40.sp,
      child: ElevatedButton(
        key: key != null ? Key(myKey!) : null,
        onPressed: onPressed,
        child: titleWidget,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          primary: color,
          padding: EdgeInsets.all(0),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
