import 'package:ds_market_place/globals.dart' as globals;
import 'package:ds_market_place/main.dart' as app;
import 'package:ds_market_place/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'testing_helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    globals.useCachedNetworkImage = false;
  });

  testWidgets('login as user1 with correct credentials', (tester) async {
    await login(tester);
  });

  testWidgets('login as user1 with false credentials', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();

    const String username = 'user1', wrongPassword = '111';
    await tester.enterText(find.byKey(const Key('username')), username);
    await tester.enterText(find.byKey(const Key('password')), wrongPassword);
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();

    expect(find.text('login unsuccessful'), findsOneWidget);
  });

  testWidgets('repeatitively register a new user till success', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();
    int userNumber = 1;
    Map<String, dynamic> signupFields = {
      'firstName': 'amr test',
      'lastName': 'fatouh test $userNumber',
      'storeName': 'test store $userNumber',
      'username': 'test user $userNumber',
      'email': 'user@example.com',
      'confirmEmail': 'user@example.com',
      'phoneNumber': '01234567891',
      'password': '123',
      'confirmPassword': '123',
    };
    await Future.forEach<MapEntry>(signupFields.entries, (entry) async {
      if (!find.byKey(Key(entry.key)).precache()) {
        await tester.scrollUntilVisible(find.byKey(Key(entry.key)), 200);
      }
      await tester.enterText(find.byKey(Key(entry.key)), entry.value);
    });

    await tester.dragUntilVisible(
        find.text('Sign up'), find.byType(ListView), const Offset(0, -200));
    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();

    Finder ok = find.text('OK');
    while (ok.precache()) {
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      userNumber++;
      await tester.dragUntilVisible(find.byKey(const Key('lastName')),
          find.byType(ListView), const Offset(0, 200));
      await tester.enterText(
          find.byKey(const Key('lastName')), 'fatouh test $userNumber');
      await tester.enterText(
          find.byKey(const Key('storeName')), 'test store $userNumber');
      await tester.enterText(
          find.byKey(const Key('username')), 'test user $userNumber');
      await tester.dragUntilVisible(
          find.text('Sign up'), find.byType(ListView), const Offset(0, -200));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sign up'));
      await tester.pumpAndSettle();
      ok = find.text('OK');
    }

    expect(find.byType(WelcomeScreen), findsOneWidget);
  });

  // assumptions:
  // there is a registered user with a store name of 'test store 1'
  testWidgets('sign up with a used storeName', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();
    Map<String, dynamic> signupFields = {
      'firstName': 'amr test',
      'lastName': 'fatouh test 1',
      'storeName': 'test store 1',
      'username': 'test user 1',
      'email': 'user@example.com',
      'confirmEmail': 'user@example.com',
      'phoneNumber': '01234567891',
      'password': '123',
      'confirmPassword': '123',
    };
    await Future.forEach<MapEntry>(signupFields.entries, (entry) async {
      if (!find.byKey(Key(entry.key)).precache()) {
        await tester.scrollUntilVisible(find.byKey(Key(entry.key)), 200);
      }
      await tester.enterText(find.byKey(Key(entry.key)), entry.value);
    });

    await tester.dragUntilVisible(
        find.text('Sign up'), find.byType(ListView), const Offset(0, -200));
    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();
    expect(find.text('Store name already exists.'), findsOneWidget);
  });
}
