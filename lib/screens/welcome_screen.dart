import 'package:ds_market_place/components/UI/circular-loading.dart';
import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/testing_widgets.dart';
import 'package:ds_market_place/models/profile.dart';
import 'package:ds_market_place/models/signup.dart';
import 'package:ds_market_place/providers/authentication_provider.dart';
import 'package:ds_market_place/screens/regestration/signin_screen.dart';
import 'package:ds_market_place/screens/regestration/signup_screen.dart';
import 'package:ds_market_place/services/authentication_web_service.dart';
import 'package:ds_market_place/services/users_web_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

bool _loading = false;

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  kLogo,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Text(
                  'Market',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey[900],
                  ),
                ),
              ),
            ],
          ),
          _loading
              ? loading()
              // register buttons
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RoundedButton(
                          title: 'Log In',
                          onPressed: () => {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SignInScreen(),
                                  ),
                                )
                              }),
                      const SizedBox(height: 10),
                      RoundedButton(
                          title: 'Register',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          }),
                      LoginAsUser1Button(),
                      TestingButton(),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
