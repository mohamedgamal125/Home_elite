class ImageModel {
  final String data;
  final String contentType;

  ImageModel({
    required this.data,
    required this.contentType,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      data: json['data'],
      contentType: json['contentType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'contentType': contentType,
    };
  }
}

class PropertytypeModel {
  final String id;
  final String propertyType;

  PropertytypeModel({
    required this.id,
    required this.propertyType,
  });

  factory PropertytypeModel.fromJson(Map<String, dynamic> json) {
    return PropertytypeModel(
      id: json['_id'],
      propertyType: json['PropertyType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'PropertyType': propertyType,
    };
  }
}

class AdModel {
  final String id;
  final String name;
  final int salary;
  final bool available;
  final String user;
  final PropertytypeModel propertyType;
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
  final int finalTotal;
  final String createdAt;
  final String updatedAt;
  final List<ImageModel> img;
  bool isFavorite;

  AdModel({
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
    required this.finalTotal,
    required this.createdAt,
    required this.updatedAt,
    required this.img,
    this.isFavorite = false,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['_id'],
      name: json['name'] ?? '',
      salary: json['salary'] ?? 0,
      available: json['available'] ?? false,
      user: json['user'] ?? '',
      propertyType: PropertytypeModel.fromJson(json['propertyType']),
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      area: json['Area'] ?? '',
      bedrooms: json['Bedrooms'] ?? 0,
      bathrooms: json['Bathrooms'] ?? 0,
      title: json['title'] ?? '',
      description: json['Description'] ?? '',
      address: json['Address'] ?? '',
      paymentOption: json['Payment_option'] ?? '',
      views: json['views'] ?? 0,
      adType: json['adType'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      finalTotal: json['FinalTotal'] ?? 0,
      img: (json['img'] as List<dynamic>?)
          ?.map((img) => ImageModel.fromJson(img))
          .toList() ?? [],
      isFavorite: false,
    );
  }

  // Convert an AdModel instance into a JSON object
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'salary': salary,
      'available': available,
      'user': user,
      'propertyType': propertyType.toJson(),
      'phone': phone,
      'email': email,
      'Area': area,
      'Bedrooms': bedrooms,
      'Bathrooms': bathrooms,
      'title': title,
      'Description': description,
      'Address': address,
      'Payment_option': paymentOption,
      'views': views,
      'adType': adType,
      'FinalTotal': finalTotal,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'img': img.map((image) => image.toJson()).toList(),
      'isFavorite': isFavorite,
    };
  }
}
