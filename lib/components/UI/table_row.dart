import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
TableRow tableRow(String title, String info, BuildContext context) {
  return TableRow(children: [
    Padding(
      padding: EdgeInsets.only(left: 66.w),
      child: Text(title,
          style:
              Theme.of(context).textTheme.caption!.copyWith(fontSize: 13.sp)),
    ),
    Padding(
      padding: EdgeInsets.only(left: 40.w),
      child: Text(info, style: TextStyle(fontSize: 13.sp)),
    ),
  ]);
}
