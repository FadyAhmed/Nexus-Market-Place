import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/login.dart';
import 'package:ds_market_place/models/profile.dart';
import 'package:ds_market_place/providers/authentication_provider.dart';
import 'package:ds_market_place/providers/users_provider.dart';
import 'package:ds_market_place/services/users_web_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestingButton extends StatelessWidget {
  const TestingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        Profile profile =
            await Provider.of<UsersProvider>(context, listen: false)
                .getMyProfile();
        print(profile);
      },
      child: Text('Testing Button'),
      style: ElevatedButton.styleFrom(primary: Colors.purple),
    );
  }
}

class LoginAsUser1Button extends StatelessWidget {
  const LoginAsUser1Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          Login loginData = Login(username: 'user1', password: '123');
          await Provider.of<AuthenticationProvider>(context, listen: false)
              .signIn(loginData);
          showMessageDialogue(context, 'Logged in successfully as user 1');
        } on ServerException catch (e) {
          showMessageDialogue(context, e.message);
        }
      },
      child: Text('Login as user1'),
      style: ElevatedButton.styleFrom(primary: Colors.purple),
    );
  }
}
