import 'package:flutter/material.dart';

TableRow tableRow(String title, String info, BuildContext context) {
  return TableRow(children: [
    Padding(
      padding: const EdgeInsets.only(left: 35.0),
      child: Text(title,
          style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 18)),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(info, style: const TextStyle(fontSize: 18)),
    ),
  ]);
}
