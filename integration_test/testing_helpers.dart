import 'package:ds_market_place/main.dart' as app;
import 'package:ds_market_place/screens/navigation/explore.dart';
import 'package:flutter/cupertino.dart';
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
