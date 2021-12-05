import 'package:flutter/material.dart';
import '../../constants.dart';

TextFormField myTextFormField({
  String? key,
  BuildContext? context,
  required String hint,
  required String label,
  String? Function(String?)? validator,
  required TextEditingController controller,
  TextInputType textInputType = TextInputType.name,
  bool obsecure = false,
}) {
  return TextFormField(
    key: Key(key ?? 'myKey'),
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
