class SignupResponseModel {
  final String message;
  final User user;

  SignupResponseModel({
    required this.message,
    required this.user,
  });

  // Factory method to create an instance from JSON
  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      message: json['message'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String email;
  final String username;
  final String password;
  final String phone;
  final String address;
  final List<dynamic> cart;
  final List<dynamic> messages;
  final bool isPhoneVerified;
  final List<dynamic> ads;
  final List<dynamic> favorite;
  final String id;
  final String verificationCode;

  User({
    required this.email,
    required this.username,
    required this.password,
    required this.phone,
    required this.address,
    required this.cart,
    required this.messages,
    required this.isPhoneVerified,
    required this.ads,
    required this.favorite,
    required this.id,
    required this.verificationCode,
  });

  // Factory method to create an instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      username: json['username'],
      password: json['password'],
      phone: json['phone'],
      address: json['address'],
      cart: json['cart'] ?? [],
      messages: json['messages'] ?? [],
      isPhoneVerified: json['isPhoneVerified'],
      ads: json['ads'] ?? [],
      favorite: json['favorite'] ?? [],
      id: json['_id'],
      verificationCode: json['verificationCode'],
    );
  }
}
