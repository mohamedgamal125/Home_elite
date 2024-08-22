class LoginResponse {
  final String message;
  final String token;
  final String userIdLogin;

  LoginResponse({
    required this.message,
    required this.token,
    required this.userIdLogin,
  });

  // Factory method to create an instance from JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      token: json['token'],
      userIdLogin: json['UserIdLogin'],
    );
  }
}
