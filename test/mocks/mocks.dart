import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:ds_market_place/services/authentication_web_service.dart';

@GenerateMocks([
  http.Client,
  AuthenticationWebService,
])
void f() {}
