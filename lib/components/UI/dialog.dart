import 'package:flutter/material.dart';

dynamic ourDialog({
  required BuildContext context,
  required String error,
  String btn1 = '',
  dynamic button2,
}) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            content: Text(error),
            actions: [
              button2,
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(btn1),
              ),
            ],
          ));
}
