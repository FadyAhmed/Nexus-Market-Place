import 'package:flutter/material.dart';

class KFormField {
  String? key;
  String label;
  String hint;
  String? Function(String?)? validator;
  TextEditingController controller;
  TextInputType textInputType;
  bool obsecure;
  KFormField(
      {this.key,
      this.label = "",
      this.hint = "",
      required this.validator,
      required this.controller,
      this.textInputType = TextInputType.text,
      this.obsecure = false});
}
