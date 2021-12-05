import 'dart:io' show Platform;

import 'package:ds_market_place/components/UI/circular-loading.dart';
import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/text_field.dart';
import 'package:ds_market_place/constants.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/login.dart';
import 'package:ds_market_place/providers/authentication_provider.dart';
import 'package:ds_market_place/screens/home_page_screen.dart';
import 'package:ds_market_place/screens/regestration/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _bigLoading = false;

  Future<void> submitForm() async {
    try {
      Login loginData =
          Login(username: _username.text, password: _password.text);
      await Provider.of<AuthenticationProvider>(context, listen: false)
          .signIn(loginData);
      showSnackbar(context, Text('Logged in successfully'));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MarketHomePage()),
          (Route<dynamic> route) => false);
    } on ServerException catch (e) {
      showMessageDialogue(context, e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      body: _bigLoading
          ? loading()
          : InkWell(
              onTap: Platform.isWindows
                  ? null
                  : () {
                      FocusScope.of(context).unfocus();
                    },
              child: ListView(
                children: [
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                      kLogo,
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: myTextFormField(
                                    key: 'username',
                                      context: context,
                                      textInputType: TextInputType.name,
                                      controller: _username,
                                      hint: "Enter user name",
                                      label: "Username"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: myTextFormField(
                                    key: 'password',
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    context: context,
                                    hint: "Enter password",
                                    label: "Passowrd",
                                    obsecure: true,
                                    controller: _password,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (authProvider.loadingStatus !=
                                LoadingStatus.loading)
                              RoundedButton(
                                onPressed: submitForm,
                                title: 'Log in',
                              ),
                            if (authProvider.loadingStatus ==
                                LoadingStatus.loading)
                              Center(child: CircularProgressIndicator()),
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
                                title: 'Register',
                                onPressed: () =>
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen()),
                                    )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
