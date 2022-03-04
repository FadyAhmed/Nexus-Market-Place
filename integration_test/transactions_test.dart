import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'testing_helpers.dart';

void main(List<String> args) {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    globals.useCachedNetworkImage = false;
  });

  testWidgets('purchase item & check transactions', (tester) async {
    await addTestItem1(tester, amount: 10);

    // add inventory item to store
    await tester.tap(find.text('Store'));
    await tester.pumpAndSettle();
    while (tester.any(find.byType(SnackBar))) {
      await tester.pumpAndSettle();
    }

    // add item to store
    await addTestItem1ToStore(tester, amount: 10);

    // logout
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Log Out'));
    await tester.pumpAndSettle();

    await login(tester, username: 'user2');

    // buy test item 1
    await tester.dragUntilVisible(
        find.text('test item 1'), find.byType(GridView), const Offset(0, -200));
    await tester.pumpAndSettle();
    await tester.tap(find.text('test item 1'));
    await tester.pumpAndSettle();
    for (int i = 0; i < 4; i++) {
      await tester.tap(find.descendant(
          of: find.byType(RoundedButton), matching: find.text('+')));
    }
    await tester.pump();
    await tester.tap(find.text('Purchase'));
    while (tester.any(find.text('Purchase'))) {
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('Inventory'));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
        find.text('test item 1'), find.byType(ListView), const Offset(0, -200));
    await tester.pumpAndSettle();
    expect(find.text('test item 1'), findsOneWidget);

    // check transactions
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Account Info'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Purchased Items'));
    await tester.pumpAndSettle();
    expect(find.text('test item 1'), findsWidgets);

    // delete inventory item from user 2
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.descendant(
        of: find.byType(BottomNavigationBar),
        matching: find.text('Inventory')));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
        find.text('test item 1'), find.byType(ListView), const Offset(0, -200));
    await tester.pumpAndSettle();
    await tester.tap(find.descendant(
        of: find.ancestor(
          of: find.text('test item 1'),
          matching: find.byType(ItemCard),
        ),
        matching: find.byIcon(Icons.more_vert)));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Remove'));
    await tester.pumpAndSettle();

    // logout
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Log Out'));
    await tester.pumpAndSettle();

    // user 1
    await login(tester);

    // check sold items
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Account Info'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sold Items'));
    await tester.pumpAndSettle();
    expect(find.text('test item 1'), findsWidgets);

    await tester.pageBack();
    await tester.pumpAndSettle();

    // check admin reports for that transaction
    await tester.tap(find.text('Reports'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('View System Transactions'));
    await tester.pumpAndSettle();
    expect(find.text('test item 1'), findsWidgets);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();

    // delete inventory item
    await tester.tap(find.descendant(
        of: find.byType(BottomNavigationBar),
        matching: find.text('Inventory')));
    await tester.pumpAndSettle();
    await deleteTestItem1(tester);
  });
}
