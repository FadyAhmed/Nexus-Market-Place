import 'package:equatable/equatable.dart';

class AuthenticationModel extends Equatable {
  final String token;

  const AuthenticationModel({required this.token});

  factory AuthenticationModel.fromJson(Map<String, dynamic> jsonMap) {
    return AuthenticationModel(token: jsonMap['token'] as String);
  }

  @override
  List<Object?> get props => [token];
}
