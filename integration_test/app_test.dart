import 'package:ds_market_place/globals.dart' as globals;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';


void main(List<String> args) {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    globals.useCachedNetworkImage = false;
  });

}
