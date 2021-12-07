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

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    globals.useCachedNetworkImage = false;
  });

  testWidgets('add inventory item', (tester) async {
    await login(tester);
    await tester.tap(find.text('Inventory'));
    await tester.pumpAndSettle();
    while (tester.any(find.byType(SnackBar))) {
      await tester.pumpAndSettle(const Duration(milliseconds: 300));
    }
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    Map<String, String> fields = {
      'name': 'test item 1',
      'amount': '1',
      'price': '1.99',
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
    await tester.pumpAndSettle();
    expect(find.text('test item 1'), findsOneWidget);
  });

  testWidgets('edit inventory item', (tester) async {
    await login(tester);
    await tester.tap(find.text('Inventory'));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
      find.text('test item 1'),
      find.byType(ListView),
      const Offset(0, -200),
    );
    await tester.pumpAndSettle();
    Finder testItemCard = find.ancestor(
      of: find.text('test item 1'),
      matching: find.byType(ItemCard),
    );
    Finder moreOptions = find.descendant(
      of: testItemCard,
      matching: find.byIcon(Icons.more_vert),
    );
    await tester.tap(moreOptions);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('amount')), '5');
    await tester.enterText(find.byKey(const Key('price')), '5.99');
    await tester.pumpAndSettle();
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit'));
    while (tester.any(find.text('Edit'))) {
      await tester.pumpAndSettle();
    }
    Finder richTextFinder = find.descendant(
      of: testItemCard,
      matching: find.byType(RichText),
    );
    // all texts (and also icons) are considered RichText
    RichText richTextWidget =
        richTextFinder.evaluate().toList()[1].widget as RichText;
    String amount = richTextWidget.text.toPlainText();
    expect(amount, 'Amount: 5');
    Finder testItemPrice = find.descendant(
      of: testItemCard,
      matching: find.text('5.99 \$'),
    );
    expect(testItemPrice, findsOneWidget);
  });

  testWidgets('delete inventory item', (tester) async {
    await login(tester);
    await tester.tap(find.text('Inventory'));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
      find.text('test item 1'),
      find.byType(ListView),
      const Offset(0, -200),
    );
    await tester.pumpAndSettle();
    Finder testItemCard = find.ancestor(
      of: find.text('test item 1'),
      matching: find.byType(ItemCard),
    );
    Finder moreOptions = find.descendant(
      of: testItemCard,
      matching: find.byIcon(Icons.more_vert),
    );
    await tester.tap(moreOptions);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Remove'));
    await tester.pumpAndSettle();
    expect(find.text('test item 1'), findsNothing);
  });
}
