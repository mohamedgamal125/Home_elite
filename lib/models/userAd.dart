class PropertyType {
  final String id;
  final String propertyType;

  PropertyType({required this.id, required this.propertyType});

  factory PropertyType.fromJson(Map<String, dynamic> json) {
    return PropertyType(
      id: json['_id'],
      propertyType: json['PropertyType'],
    );
  }
}

class UserAd {
  final String id;
  final String name;
  final int salary;
  final bool available;
  final String user;
  final PropertyType propertyType;
  final String phone;
  final String email;
  final String area;
  final int bedrooms;
  final int bathrooms;
  final String title;
  final String description;
  final String address;
  final String paymentOption;
  final int views;
  final String adType;
  final String createdAt;

  UserAd({
    required this.id,
    required this.name,
    required this.salary,
    required this.available,
    required this.user,
    required this.propertyType,
    required this.phone,
    required this.email,
    required this.area,
    required this.bedrooms,
    required this.bathrooms,
    required this.title,
    required this.description,
    required this.address,
    required this.paymentOption,
    required this.views,
    required this.adType,
    required this.createdAt,
  });

  factory UserAd.fromJson(Map<String, dynamic> json) {
    return UserAd(
      id: json['_id'],
      name: json['name'],
      salary: json['salary'],
      available: json['available'],
      user: json['user'],
      propertyType: PropertyType.fromJson(json['propertyType']),
      phone: json['phone'],
      email: json['email'],
      area: json['Area'],
      bedrooms: json['Bedrooms'],
      bathrooms: json['Bathrooms'],
      title: json['title'],
      description: json['Description'],
      address: json['Address'],
      paymentOption: json['Payment_option'],
      views: json['views'],
      adType: json['adType'],
      createdAt: json['createdAt'],
    );
  }
}

class UserAdsResponse {
  final List<UserAd> userAds;

  UserAdsResponse({required this.userAds});

  factory UserAdsResponse.fromJson(Map<String, dynamic> json) {
    var ads = json['userAds'] as List;
    List<UserAd> userAdsList = ads.map((i) => UserAd.fromJson(i)).toList();
    return UserAdsResponse(userAds: userAdsList);
  }
}
