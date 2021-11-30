class Signup {
  String firstName;
  String lastName;
  String username;
  String email;
  String phoneNumber;
  String password;
  String storeName;

  Signup({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.storeName,
  });

  factory Signup.fromJson(Map<String, Object> jsonMap) {
    return Signup(
      firstName: jsonMap['firstName'] as String,
      lastName: jsonMap['lastName'] as String,
      username: jsonMap['userName'] as String,
      email: jsonMap['email'] as String,
      phoneNumber: jsonMap['phoneNumber'] as String,
      password: jsonMap['password'] as String,
      storeName: jsonMap['storeName'] as String,
    );
  }

  Map<String, Object> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'storeName': storeName,
    };
  }
}
