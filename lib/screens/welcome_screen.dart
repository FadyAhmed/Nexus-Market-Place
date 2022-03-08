import 'package:ds_market_place/components/UI/circular-loading.dart';
import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/screens/regestration/signin_screen.dart';
import 'package:ds_market_place/screens/regestration/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          15.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  kLogo,
                  height: 100.sp,
                  fit: BoxFit.scaleDown,
                ),
              ),
              20.horizontalSpace,
              Text(
                'Market',
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey[900],
                ),
              ),
            ],
          ),
          98.verticalSpace,
          Column(
            children: [
              RoundedButton(
                title: 'Log In',
                onPressed: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                  )
                },
              ),
              46.verticalSpace,
              RoundedButton(
                  title: 'Register',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
