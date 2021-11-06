import 'package:flutter/material.dart';

RichText dataText(BuildContext context, String title, String data) {
  return RichText(
    text: TextSpan(
      text: "",
      style: DefaultTextStyle.of(context).style,
      children: [
        TextSpan(
            text: "$title: ",
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.grey)),
        TextSpan(
            text: data,
            style:
                Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 16)),
      ],
    ),
    overflow: TextOverflow.fade,
  );
}
