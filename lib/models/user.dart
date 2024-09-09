class User2 {
  String? id;
  String? email;
  String? username;
  String? password;
  String? phone;
  String? address;
  List<String>? cart;
  List<String>? messages;
  bool? isPhoneVerified;
  List<String>? ads;
  List<Favorite>? favorite;
  int? v;

  User2({
    this.id,
    this.email,
    this.username,
    this.password,
    this.phone,
    this.address,
    this.cart,
    this.messages,
    this.isPhoneVerified,
    this.ads,
    this.favorite,
    this.v,
  });

  // Factory constructor for creating a new `User` instance from a map
  factory User2.fromJson(Map<String, dynamic> json) {
    return User2(
      id: json['_id'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      phone: json['phone'],
      address: json['address'],
      cart: List<String>.from(json['cart']),
      messages: List<String>.from(json['messages']),
      isPhoneVerified: json['isPhoneVerified'],
      ads: List<String>.from(json['ads']),
      favorite: (json['favorite'] as List)
          .map((favJson) => Favorite.fromJson(favJson))
          .toList(),
      v: json['__v'],
    );
  }

  // Method to convert `User` object to a map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'username': username,
      'password': password,
      'phone': phone,
      'address': address,
      'cart': cart,
      'messages': messages,
      'isPhoneVerified': isPhoneVerified,
      'ads': ads,
      'favorite': favorite?.map((fav) => fav.toJson()).toList(),
      '__v': v,
    };
  }
}

class Favorite {
  String? ad;
  bool? isFavorite;
  String? id;

  Favorite({this.ad, this.isFavorite, this.id});

  // Factory constructor for creating a new `Favorite` instance from a map
  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      ad: json['ad'],
      isFavorite: json['isFavorite'],
      id: json['_id'],
    );
  }

  // Method to convert `Favorite` object to a map
  Map<String, dynamic> toJson() {
    return {
      'ad': ad,
      'isFavorite': isFavorite,
      '_id': id,
    };
  }
}
