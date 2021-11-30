import 'package:ds_market_place/globals.dart' as globals;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ds_market_place/models/authentication_model.dart';
import 'package:ds_market_place/providers/authentication_provider.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late AuthenticationProvider authenticationProvider;
  late MockAuthenticationWebService authenticationWebService;

  setUp(() {
    authenticationWebService = MockAuthenticationWebService();
    authenticationProvider = AuthenticationProvider(
        authenticationWebService: authenticationWebService);
  });

  group('signIn method', () {
    AuthenticationModel tAuthenticationModel =
        AuthenticationModel(token: 'token123456');

    test('the AuthenticationModel is null at the beginning', () {
      expect(authenticationProvider.authenticationModel, null);
    });

    test(
        'AuthenticationModel is set after calling AuthenticationWebService.signIn()',
        () async {
      when(authenticationWebService.signIn(any, any))
          .thenAnswer((_) async => tAuthenticationModel);

      await authenticationProvider.signIn('email', 'password');

      expect(authenticationProvider.authenticationModel, tAuthenticationModel);
    });

    test('globals.token is set after calling AuthenticationWebService.signIn()',
        () async {
      when(authenticationWebService.signIn(any, any))
          .thenAnswer((_) async => tAuthenticationModel);

      await authenticationProvider.signIn('email', 'password');

      expect(globals.token, tAuthenticationModel.token);
    });
  });
}
