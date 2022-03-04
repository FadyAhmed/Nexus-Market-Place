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

  testWidgets('add inventory item to store, edit, delete it', (tester) async {
    await addTestItem1(tester, amount: 2);

    // add inventory item to store
    await tester.tap(find.text('Store'));
    await tester.pumpAndSettle();
    while (tester.any(find.byType(SnackBar))) {
      await tester.pumpAndSettle();
    }

    // add item to store
    await addTestItem1ToStore(tester);

    // edit store item
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
    await deleteTestItem1(tester);
  });
}
