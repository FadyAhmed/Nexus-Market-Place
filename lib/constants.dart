import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter value',
  filled: true,
  fillColor: Colors.white60,
  labelStyle: TextStyle(color: Colors.black54, fontSize: 20),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black26, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black26, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

SliverGridDelegateWithMaxCrossAxisExtent kGridShape(
    {required BuildContext context}) {
  return SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
    childAspectRatio: 0.75,
  );
}

const kListTilePadding = EdgeInsets.all(8);
const kListTileMargin = EdgeInsets.all(8);
const kUserPlaceholder = AssetImage('assets/images/user.png');
const kLibraryPlaceholder = AssetImage('assets/images/library.png');
const kItemPlaceholder = AssetImage('assets/images/book.png');
const kLogo = 'assets/images/logo.png';
