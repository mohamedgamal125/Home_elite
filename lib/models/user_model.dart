import 'package:home_elite/models/propertyType_model.dart';

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
  final List<AdModel> ads;
  final List<AdModel> favorite;
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
      // Map each ad and favorite from JSON to AdModel
      ads: (json['ads'] as List<dynamic>)
          .map((ad) => AdModel.fromJson(ad))
          .toList(),
      favorite: (json['favorite'] as List<dynamic>)
          .map((ad) => AdModel.fromJson(ad))
          .toList(),
      v: json['__v'],
    );
  }
}
