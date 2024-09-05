class UserModel {
  final String id;
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
  final int v;

  UserModel({
    required this.id,
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
    required this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
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
      v: json['__v'],
    );
  }
}
