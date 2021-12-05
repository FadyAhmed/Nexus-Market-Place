import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/main.dart' as app;
import 'package:ds_market_place/screens/navigation/explore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> _loginAsUser1(WidgetTester tester) async {
    await tester.pumpWidget(const app.MyApp());
    Finder bla = find.text('bla');
    print('*****');
    print(bla.precache());
    print('*****');
    Finder loginBtn = find.text('Log In');
    print('*****');
    print(loginBtn.precache());
    print(loginBtn.at(0));
    print('*****');
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

  testWidgets('name appears on drawer', (tester) async {
    await _loginAsUser1(tester);
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.text('amr fatouh'), findsOneWidget);
  });

  Future<void> _navigateToIInventoryScreen(WidgetTester tester) async {
    await _loginAsUser1(tester);
    await tester.tap(find.text('Inventory'));
    await tester.pumpAndSettle();
    expect(find.byType(ItemCard), findsWidgets);
  }

  testWidgets('Inventory contains inventory items or a message',
      (tester) async {
    _navigateToIInventoryScreen(tester);
  });

  testWidgets('add inventory item', (tester) async {
    await _navigateToIInventoryScreen(tester);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    List<String> keys = ['name', 'amount', 'price', 'description', 'link'];
    await tester.tap(find.byKey(const Key('name')));
    await tester.enterText(find.byKey(const Key('name')), 'test item 1');
    await tester.tap(find.byKey(const Key('amount')));
    await tester.enterText(find.byKey(const Key('amount')), '1');
    await tester.tap(find.byKey(const Key('price')));
    await tester.enterText(find.byKey(const Key('price')), '1.99');
    await tester.tap(find.byKey(const Key('description')));
    await tester.enterText(
        find.byKey(const Key('description')), 'test description 1');
    await tester.tap(find.byKey(const Key('link')));
    await tester.enterText(find.byKey(const Key('link')),
        'https://images.ctfassets.net/23aumh6u8s0i/2RrLE9Sz4VcKrh4pa3I0kn/8e1bbadef51dd4e26aa8174c2afbfd3a/flutter.png');
    await tester.tap(find.text('Add Item'));
    await tester.pumpAndSettle();
    expect(find.text('test item 1', skipOffstage: false), findsOneWidget);
  });
}
