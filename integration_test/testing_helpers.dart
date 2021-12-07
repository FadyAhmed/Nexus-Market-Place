import 'package:ds_market_place/main.dart' as app;
import 'package:ds_market_place/screens/navigation/explore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> loginAsUser1(WidgetTester tester) async {
  await tester.pumpWidget(const app.MyApp());
  Finder loginBtn = find.text('Log In');
  await tester.tap(loginBtn);
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key('username')), 'user1');
  await tester.enterText(find.byKey(const Key('password')), '123');
  await tester.pumpAndSettle();

  await tester.tap(find.text('Log in'));
  await tester.pump();
  await tester.pumpAndSettle();
  expect(find.byType(ExploreScreen), findsOneWidget);
}

Future<void> addTestItem1(WidgetTester tester,
    {int amount = 1, double price = 1.99}) async {
  await loginAsUser1(tester);
  await tester.tap(find.text('Inventory'));
  await tester.pumpAndSettle();
  while (tester.any(find.byType(SnackBar))) {
    await tester.pumpAndSettle(const Duration(milliseconds: 300));
  }
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();

  Map<String, String> fields = {
    'name': 'test item 1',
    'amount': '$amount',
    'price': '$price',
    'description': 'test description 1',
    'link':
        'https://images.ctfassets.net/23aumh6u8s0i/2RrLE9Sz4VcKrh4pa3I0kn/8e1bbadef51dd4e26aa8174c2afbfd3a/flutter.png',
  };
  await Future.forEach<MapEntry>(fields.entries, (entry) async {
    await tester.enterText(find.byKey(Key(entry.key)), entry.value);
  });
  await tester.pumpAndSettle();

  await tester.tap(find.text('Add Item'));
  while (tester.any(find.text('Add Item'))) {
    await tester.pumpAndSettle();
  }
  await tester.dragUntilVisible(
    find.text('test item 1'),
    find.byType(ListView),
    const Offset(0, -200),
  );
}
