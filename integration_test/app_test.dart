import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/globals.dart' as globals;
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/main.dart' as app;
import 'package:ds_market_place/screens/navigation/explore.dart';
import 'package:ds_market_place/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'testing_helpers.dart';

void main(List<String> args) {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    globals.useCachedNetworkImage = false;
  });

  testWidgets('add inventory item to store', (tester) async {
    await addTestItem1(tester, amount: 2);
    await tester.tap(find.text('Store'));
    await tester.pumpAndSettle();
    while (tester.any(find.byType(SnackBar))) {
      await tester.pumpAndSettle();
    }
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
        find.text('test item 1'), find.byType(ListView), const Offset(0, -200));
    await tester.tap(find.text('test item 1'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('amount')), '1');
    await tester.enterText(find.byKey(const Key('price')), '1');
    await tester.tap(find.text('Confirm'));
    while (tester.any(find.text('Confirm'))) {
      await tester.pumpAndSettle();
    }
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
        find.text('test item 1'), find.byType(ListView), const Offset(0, -200));
    expect(find.text('test item 1'), findsOneWidget);

    await tester.tap(find.text('test item 1'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('amount')), '2');
    await tester.enterText(find.byKey(const Key('price')), '11.99');
    await tester.tap(find.text('Edit'));
    while (tester.any(find.text('Edit'))) {
      await tester.pumpAndSettle();
    }
    expect(find.text('2'), findsOneWidget);
    expect(find.text('\$11.99'), findsOneWidget);

    // delete store item
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();
    expect(find.text('test item 1'), findsNothing);

    // delete inventory item
    await tester.tap(find.text('Inventory'));
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
    expect(find.text('test item 1'), findsNothing);
  });
}
