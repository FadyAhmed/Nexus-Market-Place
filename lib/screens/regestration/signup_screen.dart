import 'dart:io';

import 'package:ds_market_place/components/UI/circular-loading.dart';
import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/text_field.dart';
import 'package:ds_market_place/components/UI/text_form_field_class.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/signup.dart';
import 'package:ds_market_place/providers/authentication_provider.dart';
import 'package:ds_market_place/screens/regestration/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../home_page_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _storeName = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _confirmEmail = TextEditingController();
  TextEditingController _phoneNum = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;
  bool _bigLoading = false;

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        Signup signupData = Signup(
          firstName: _firstName.text,
          lastName: _lastName.text,
          username: _userName.text,
          email: _email.text,
          phoneNumber: _phoneNum.text,
          password: _password.text,
          storeName: _storeName.text,
        );
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .signUp(signupData);
        showSnackbar(
          context,
          Text('You have been registered successfully, Log in to your account'),
          4,
        );
        Navigator.of(context).pop();
      } on ServerException catch (e) {
        showMessageDialogue(context, e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    List<KFormField> _fields = [
      KFormField(
          key: 'firstName',
          controller: _firstName,
          hint: 'Enter first name',
          label: "First name*",
          validator: (String? text) {
            if (text != null && text.isEmpty) return 'Empty';
          }),
      KFormField(
          key: 'lastName',
          controller: _lastName,
          hint: 'Enter Last Name',
          label: "Last Name*",
          validator: (text) {
            if (text != null && text.isEmpty) return 'Empty';
          }),
      KFormField(
          key: 'storeName',
          controller: _storeName,
          hint: 'Enter Store Name',
          label: "Store Name*",
          validator: (text) {
            if (text != null && text.isEmpty) return 'Empty';
          }),
      KFormField(
          key: 'username',
          controller: _userName,
          hint: 'Enter user name',
          label: "Username*",
          validator: (text) {
            if (text != null && text.isEmpty) return 'Empty';
          }),
      KFormField(
          key: 'email',
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
          key: 'confirmEmail',
          controller: _confirmEmail,
          textInputType: TextInputType.emailAddress,
          hint: 'Confirm your email',
          label: "Confirm Email*",
          validator: (text) => text != null && text.isEmpty
              ? 'Empty'
              : text == _email.text
                  ? null
                  : 'Emails not matching'),
      KFormField(
        key: 'phoneNumber',
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
          key: 'password',
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
          key: 'confirmPassword',
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
              onTap: Platform.isWindows
                  ? null
                  : () {
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
                                    key: e.key,
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
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      if (authProvider.loadingStatus !=
                                          LoadingStatus.loading)
                                        Semantics(
                                          label: 'send signup request',
                                          child: RoundedButton(
                                            myKey: 'signupBtn',
                                            onPressed: submitForm,
                                            title: 'Sign up',
                                          ),
                                        ),
                                      if (authProvider.loadingStatus ==
                                          LoadingStatus.loading)
                                        Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      SizedBox(height: 15),
                                      Center(
                                          child: Text(
                                        "OR",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(fontSize: 16),
                                      )),
                                      SizedBox(height: 15),
                                      RoundedButton(
                                          title: 'Log In',
                                          onPressed: () => Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignInScreen()),
                                              )),
                                    ],
                                  ),
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
