import 'package:ds_market_place/app/dependency_injection.dart';
import 'package:ds_market_place/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/UI/dialog.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  injectDependencies();
  runApp(riverpod.ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411, 731),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        title: 'Market Place',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          scaffoldBackgroundColor: const Color(0xFFD6D6D6),
        ),
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
