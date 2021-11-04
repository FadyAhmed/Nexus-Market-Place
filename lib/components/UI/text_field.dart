import 'package:flutter/material.dart';
import '../../constants.dart';

TextFormField myTextFormField({
  BuildContext? context,
  required String hint,
  required String label,
  String? Function(String?)? validator,
  required TextEditingController controller,
  TextInputType textInputType = TextInputType.name,
  bool obsecure = false,
}) {
  return TextFormField(
    cursorColor: Colors.black,
    obscureText: obsecure,
    validator: validator,
    controller: controller,
    keyboardType: textInputType,
    decoration: kTextFieldDecoration.copyWith(labelText: label, hintText: hint),
    // myTextFieldDecoration(context: context, hint: hint, label: label),
    textAlign: TextAlign.center,
  );
}
