import 'package:ds_market_place/components/UI/circular-loading.dart';
import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/text_field.dart';
import 'package:ds_market_place/constants.dart';
import 'package:ds_market_place/screens/home_page_screen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();
  bool _bigLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bigLoading
          ? loading()
          : InkWell(
              onTap: () {
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
                                      context: context,
                                      textInputType: TextInputType.name,
                                      controller: _textEditingController1,
                                      hint: "Enter user name",
                                      label: "Username"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: myTextFormField(
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    context: context,
                                    hint: "Enter password",
                                    label: "Passowrd",
                                    obsecure: true,
                                    controller: _textEditingController2,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: RoundedButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => MarketHomePage()),
                                    (Route<dynamic> route) => false);
                              },
                              title: 'Log in',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
