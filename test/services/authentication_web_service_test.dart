import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/models/authentication_model.dart';
import 'package:ds_market_place/services/authentication_web_service.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late MockClient client;
  late AuthenticationWebService authenticationWebService;

  setUp(() {
    client = MockClient();
    authenticationWebService = AuthenticationWebService(client: client);
  });

  group('signIn method', () {
    String tToken = 'token123456';
    AuthenticationModel tAuthenticationModel =
        AuthenticationModel(token: tToken);
    test(
        'should return AuthenticationModel with token if response is successful',
        () async {
      when(client.get(any)).thenAnswer((_) async => http.Response(
            jsonEncode({
              'token': tToken,
            }),
            200,
          ));

      AuthenticationModel result =
          await authenticationWebService.signIn('test@example.com', '123456');

      expect(result, tAuthenticationModel);
    });

    test('should throw a ServerException if response statusCode is not 200',
        () async {
      when(client.get(any)).thenAnswer((_) async => http.Response('{}', 404));

      expect(authenticationWebService.signIn('email', 'password'),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('signUp method', () {
    String tToken = 'token123456';
    AuthenticationModel tAuthenticationModel =
        AuthenticationModel(token: tToken);
    test(
        'should return AuthenticationModel with token if response is successful',
        () async {
      when(client.get(any)).thenAnswer((_) async => http.Response(
            jsonEncode({
              'token': tToken,
            }),
            200,
          ));

      AuthenticationModel result =
          await authenticationWebService.signUp('test@example.com', '123456');

      expect(result, tAuthenticationModel);
    });

    test('should throw a ServerException if response statusCode is not 200',
        () async {
      when(client.get(any)).thenAnswer((_) async => http.Response('{}', 404));

      expect(authenticationWebService.signUp('email', 'password'),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
