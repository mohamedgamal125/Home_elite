class PropertytypeModel {
  final String id;
  final String propertyType;

  PropertytypeModel({required this.id, required this.propertyType});

  factory PropertytypeModel.fromJson(Map<String, dynamic> json) {
    return PropertytypeModel(
        id: json['_id'], propertyType: json['PropertyType']);
  }
}
