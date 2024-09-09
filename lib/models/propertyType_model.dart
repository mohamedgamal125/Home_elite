class PropertytypeModel {
  final String id;
  final String propertyType;

  PropertytypeModel({required this.id, required this.propertyType});

  factory PropertytypeModel.fromJson(Map<String, dynamic> json) {
    return PropertytypeModel(
        id: json['_id'], propertyType: json['PropertyType']);
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
  final String createdAt;
  final String updatedAt;


  bool  isFavorite;

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
    required this.createdAt,
    required this.updatedAt,

    this.isFavorite=false

  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['_id'],
      name: json['name'],
      salary: json['salary'],
      available: json['available'],
      user: json['user'],
      propertyType: PropertytypeModel.fromJson(json['propertyType']),
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
      updatedAt: json['updatedAt'],

    );
  }
}