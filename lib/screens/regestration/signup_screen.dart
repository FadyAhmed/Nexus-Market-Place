import 'package:ds_market_place/components/UI/circular-loading.dart';
import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/text_field.dart';
import 'package:ds_market_place/components/UI/text_form_field_class.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../home_page_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _confirmEmail = TextEditingController();
  TextEditingController _phoneNum = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;
  bool _bigLoading = false;
  @override
  Widget build(BuildContext context) {
    List<KFormField> _fields = [
      KFormField(
          controller: _firstName,
          hint: 'Enter first name',
          label: "First name*",
          validator: (String? text) {
            if (text != null && text.isEmpty) return 'Empty';
          }),
      KFormField(
          controller: _lastName,
          hint: 'Enter Last Name',
          label: "Last Name*",
          validator: (text) {
            if (text != null && text.isEmpty) return 'Empty';
          }),
      KFormField(
          controller: _lastName,
          hint: 'Enter Store Name',
          label: "Store Name*",
          validator: (text) {
            if (text != null && text.isEmpty) return 'Empty';
          }),
      KFormField(
          controller: _userName,
          hint: 'Enter user name',
          label: "Username*",
          validator: (text) {
            if (text != null && text.isEmpty) return 'Empty';
          }),
      KFormField(
          textInputType: TextInputType.emailAddress,
          controller: _email,
          hint: 'Enter email',
          label: "Email*",
          validator: (text) => (text != null && text.isEmpty)
              ? 'Empty'
              : text == _confirmEmail.text
                  ? null
                  : 'Emails not matching'),
      KFormField(
          controller: _confirmEmail,
          textInputType: TextInputType.emailAddress,
          hint: 'Confirm your email',
          label: "Email confirm*",
          validator: (text) => text != null && text.isEmpty
              ? 'Empty'
              : text == _email.text
                  ? null
                  : 'Emails not matching'),
      KFormField(
        textInputType: TextInputType.number,
        controller: _phoneNum,
        hint: 'Enter your phone number',
        label: "Phone number",
        validator: (String? s) => (s == null || s.isEmpty)
            ? null
            : double.tryParse(s) == null
                ? 'Not A Number!'
                : (s.startsWith('01') && s.length == 11)
                    ? null
                    : 'Invalid Number',
      ),
      KFormField(
          controller: _password,
          obsecure: true,
          hint: 'Enter Password',
          label: "Password*",
          validator: (text) => text != null && text.isEmpty
              ? 'Empty Password'
              : text == _confirmPassword.text
                  ? null
                  : 'Passwords not matching'),
      KFormField(
          controller: _confirmPassword,
          obsecure: true,
          hint: 'Confirm password',
          label: "Confirm Password*",
          validator: (text) => text != null && text.isEmpty
              ? 'Empty Password'
              : text == _password.text
                  ? null
                  : 'Passwords not matching'),
    ];

    return Scaffold(
      body: _bigLoading
          ? loading()
          : InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Hero(
                          tag: 'logo',
                          child: Image.asset(
                            kLogo,
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                children: _fields.map((e) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: myTextFormField(
                                    context: context,
                                    controller: e.controller,
                                    hint: e.hint,
                                    label: e.label,
                                    obsecure: e.obsecure,
                                    validator: e.validator,
                                    textInputType: e.textInputType),
                              );
                            }).toList()),
                          ),
                        ),
                        _loading
                            ? loading()
                            : Center(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: RoundedButton(
                                        onPressed: () {
                                          _formKey.currentState!.validate();
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                              MarketHomePage()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                        },
                                        title: 'Sign up',
                                      ),
                                    ),
                                  ],
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
