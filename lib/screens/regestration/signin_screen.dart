import 'dart:async';
import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:ds_market_place/components/UI/circular-loading.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/text_field.dart';
import 'package:ds_market_place/constants.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/data/rest_client.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/login.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/providers/authentication_provider.dart';
import 'package:ds_market_place/screens/home_page_screen.dart';
import 'package:ds_market_place/screens/regestration/signup_screen.dart';
import 'package:ds_market_place/states/auth_state.dart';
import 'package:ds_market_place/view_models/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class SignInScreen extends ConsumerStatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      LoginRequest request = LoginRequest(
        username: _username.text,
        password: _password.text,
      );
      ref.read(authProvider.notifier).signIn(request);
    }
  }

  void handleUserLogin() {
    showSnackbar(context, Text('Logged in successfully'));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MarketHomePage()),
        (Route<dynamic> route) => false);
  }

  Form buildForm() {
    return Form(
      key: _formKey,
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
              label: "Username",
              validator: (val) =>
                  val == null || val.isEmpty ? 'Field cannot be empty' : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: myTextFormField(
              key: 'password',
              textInputType: TextInputType.visiblePassword,
              context: context,
              hint: "Enter password",
              label: "Passowrd",
              obsecure: true,
              controller: _password,
              validator: (val) =>
                  val == null || val.isEmpty ? 'Field cannot be empty' : null,
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildLoginButton() {
    final state = ref.watch(authProvider);
    if (state is AuthLoadingState) {
      return Center(child: CircularProgressIndicator());
    } else if (state is AuthErrorState) {
      return MyErrorWidget(failure: state.failure, onRetry: submitForm);
    } else {
      // initial - loaded
      return RoundedButton(
        onPressed: submitForm,
        title: 'Log in',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (previous, next) {
      if (next is AuthLoadedState) {
        showSnackbar(context, Text('Logged in successfully'));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MarketHomePage()),
            (Route<dynamic> route) => false);
      }
    });
    return Scaffold(
      body: GestureDetector(
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
                    buildForm(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLoginButton(),
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
