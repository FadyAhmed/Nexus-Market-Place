import 'package:ds_market_place/providers/authentication_provider.dart';
import 'package:ds_market_place/providers/users_provider.dart';
import 'package:ds_market_place/screens/welcome_screen.dart';
import 'package:ds_market_place/services/authentication_web_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'components/UI/dialog.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthenticationProvider(
            authenticationWebService: AuthenticationWebService(
              client: http.Client(),
            ),
          ),
        ),
        ChangeNotifierProvider(create: (context) => UsersProvider()),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Market Place',
      theme: ThemeData(
          primarySwatch: Colors.yellow,
          scaffoldBackgroundColor: const Color(0xFFD6D6D6)),
      home: const MyHomePage(title: 'Market Place'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: const WelcomeScreen(),
      onWillPop: () async {
        return ourDialog(
            context: context,
            error: 'Do you want to exit?',
            btn1: 'No',
            button2: TextButton(
                child: const Text('Exit'),
                onPressed: () => SystemChannels.platform
                    .invokeMethod('SystemNavigator.pop')));
      },
    );
  }
}
