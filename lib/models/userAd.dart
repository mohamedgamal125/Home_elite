class ImageData {
  final String? data;
  final String? contentType;
  final String? id;

  ImageData({this.data, this.contentType, this.id});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      data: json['data'],
      contentType: json['contentType'],
      id: json['_id'],
    );
  }
}

class PropertyType {
  final String? id;
  final String? propertyType;

  PropertyType({this.id, this.propertyType});

  factory PropertyType.fromJson(Map<String, dynamic> json) {
    return PropertyType(
      id: json['_id'],
      propertyType: json['PropertyType'],
    );
  }
}

class UserAd {
  final String? id;
  final List<ImageData>? img;
  final String? name;
  final int? salary;
  final bool? available;
  final String? user;
  final PropertyType? propertyType;
  final String? phone;
  final String? email;
  final String? area;
  final int? bedrooms;
  final int? bathrooms;
  final String? title;
  final String? description;
  final String? address;
  final String? paymentOption;
  final int? views;
  final String? adType;
  final String? rentDuration;
  final int? downPayment;
  final int? insurance;
  final String? createdAt;

  UserAd({
    this.id,
    this.img,
    this.name,
    this.salary,
    this.available,
    this.user,
    this.propertyType,
    this.phone,
    this.email,
    this.area,
    this.bedrooms,
    this.bathrooms,
    this.title,
    this.description,
    this.address,
    this.paymentOption,
    this.views,
    this.adType,
    this.rentDuration,
    this.downPayment,
    this.insurance,
    this.createdAt,
  });

  factory UserAd.fromJson(Map<String, dynamic> json) {
    var imgList = json['img'] as List?;
    List<ImageData> imgDataList = imgList != null ? imgList.map((i) => ImageData.fromJson(i)).toList() : [];

    return UserAd(
      id: json['_id'],
      img: imgDataList,
      name: json['name'],
      salary: json['salary'],
      available: json['available'],
      user: json['user'],
      propertyType: json['propertyType'] != null ? PropertyType.fromJson(json['propertyType']) : null,
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
      rentDuration: json['rentDuration'],
      downPayment: json['DownPayment'],
      insurance: json['Insurance'],
      createdAt: json['createdAt'],
    );
  }
}

class UserAdsResponse {
  final List<UserAd> userAds;

  UserAdsResponse({required this.userAds});

  factory UserAdsResponse.fromJson(Map<String, dynamic> json) {
    var ads = json['userAds'] as List?;
    List<UserAd> userAdsList = ads != null ? ads.map((i) => UserAd.fromJson(i)).toList() : [];
    return UserAdsResponse(userAds: userAdsList);
  }
}
