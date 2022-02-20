import 'package:dio/dio.dart';
import 'package:ds_market_place/constants/shared_preferences_keys.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/data/rest_client.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/globals.dart';
import 'package:ds_market_place/providers/authentication_provider.dart';
import 'package:ds_market_place/providers/inventories_provider.dart';
import 'package:ds_market_place/providers/stores_provider.dart';
import 'package:ds_market_place/providers/transactions_provider.dart';
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

class ExpApp extends StatelessWidget {
  const ExpApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await Repository(RestClient(Dio()))
                  .signIn(LoginRequest(username: 'user1', password: '123'));
              print(token);
            },
            child: Text('CLICK'),
          ),
        ),
      ),
    );
  }
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
        ChangeNotifierProvider(create: (context) => InventoriesProvider()),
        ChangeNotifierProvider(create: (context) => StoresProvider()),
        ChangeNotifierProvider(create: (context) => TransactionsProvider()),
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
