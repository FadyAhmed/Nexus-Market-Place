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

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    globals.useCachedNetworkImage = false;
  });

  // testWidgets('test test test', (tester) async {
  //   await tester.pumpWidget(const app.MyApp());
  //   await tester.tap(find.text('Register'));
  //   await tester.pumpAndSettle();
  //   await tester.enterText(find.byKey(const Key('firstName')), 'test');
  //   await tester.enterText(find.byKey(const Key('firstName')), 'hello world');
  //   await tester.pump(const Duration(seconds: 5));
  // });
}
