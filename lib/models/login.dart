class Login {
  String username;
  String password;

  Login({required this.username, required this.password});

  Map<String, Object> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
