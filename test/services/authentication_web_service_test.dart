import 'dart:convert';

import 'package:ds_market_place/constants/routes_constants.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/models/login.dart';
import 'package:ds_market_place/services/authentication_web_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks_generator.mocks.dart';
import 'package:ds_market_place/globals.dart' as globals;

void main() {
  late MockClient client;
  late AuthenticationWebService authenticationWebService;

  setUp(() {
    client = MockClient();
    authenticationWebService = AuthenticationWebService(client: client);
  });

  test('signin method sets token, admin status and storeName', () async {
    String token = 'test token';
    bool adminStatus = true;
    String storeName = 'test store name';
    Map<String, dynamic> body = {
      "success": true,
      "status": "user login successfully",
      "token": token,
      "admin": adminStatus,
      "storeName": storeName
    };
    when(client.post(Uri.parse(RoutesConstants.signIn),
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => Response(jsonEncode(body), 200));
    Login loginData = Login(username: 'user1', password: '123');
    await authenticationWebService.signIn(loginData);
    expect(globals.token, token);
    expect(globals.admin, adminStatus);
    expect(globals.storeName, storeName);
  });

  test(
    'sign in method throws ServerException at any status code other that 200',
    () async {
      String body = jsonEncode({
        'success': false,
        'status': "a required field is missing",
      });
      when(client.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => Response(body, 400));

      Login loginData = Login(username: 'user1', password: '123');
      expect(
        () => authenticationWebService.signIn(loginData),
        throwsA(isA<ServerException>()),
      );
    },
  );
}
