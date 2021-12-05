import 'dart:io';

import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/models/login.dart';
import 'package:ds_market_place/providers/authentication_provider.dart';
import 'package:ds_market_place/screens/navigation/explore.dart';
import 'package:ds_market_place/services/authentication_web_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ds_market_place/main.dart' as app;
import 'package:http/http.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = null;
  });
  testWidgets('login button is working', (WidgetTester tester) async {
    await tester.pumpWidget(const app.MyApp());
    expect(find.byType(RoundedButton), findsNWidgets(2));

    final Finder loginBtn = find.text('Log In');
    await tester.tap(loginBtn);
    await tester.pumpAndSettle();
    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('register button is working', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    final Finder registerBtn = find.text('Register');
    await tester.tap(registerBtn);
    await tester.pumpAndSettle();
    expect(find.byType(TextFormField), findsNWidgets(9));
  });

  testWidgets('circular progress indicator shows when submitting login data',
      (tester) async {
    await tester.pumpWidget(const app.MyApp());
    Finder loginBtn = find.text('Log In');
    await tester.tap(loginBtn);
    await tester.pumpAndSettle();
    expect(find.byType(TextFormField), findsNWidgets(2));
    await tester.enterText(find.byKey(const Key('username')), 'user1');
    await tester.enterText(find.byKey(const Key('password')), '123');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Log in'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
