import 'dart:async';
import 'dart:io';

import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/text_field.dart';
import 'package:ds_market_place/components/UI/text_form_field_class.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/screens/regestration/signin_screen.dart';
import 'package:ds_market_place/states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _storeName = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _confirmEmail = TextEditingController();
  final TextEditingController _phoneNum = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      SignUpRequest request = SignUpRequest(
        firstName: _firstName.text,
        lastName: _lastName.text,
        username: _userName.text,
        email: _email.text,
        phoneNumber: _phoneNum.text,
        password: _password.text,
        storeName: _storeName.text,
      );
      ref.read(authProvider.notifier).signUp(request);
    }
  }

  Widget _buildSignUpButton() {
    final state = ref.watch(authProvider);
    if (state is AuthLoadingState) {
      return Center(child: CircularProgressIndicator());
    } else if (state is AuthErrorState) {
      return MyErrorWidget(failure: state.failure, onRetry: submitForm);
    } else {
      // initial - loaded
      return Semantics(
        label: 'send signup request',
        child: RoundedButton(
          myKey: 'signupBtn',
          onPressed: submitForm,
          title: 'Sign up',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (previous, next) {
      if (next is AuthLoadedState) {
        showSnackbar(
          context,
          Text('You have been registered successfully, Log in to your account'),
          4,
        );
        Navigator.of(context).pop();
      }
    });
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
      body: GestureDetector(
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
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                          _buildSignUpButton(),
                                SizedBox(height: 15),
                                Center(
                                  child: Text(
                                    "OR",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(fontSize: 16),
                                  ),
                                ),
                                SizedBox(height: 15),
                                RoundedButton(
                                  title: 'Log In',
                                  onPressed: () =>
                                      Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => SignInScreen(),
                                    ),
                                  ),
                                ),
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
