class PlaceModel {

  final int? id;
  final String name;
  final String province;
  final String category;
  final String image;
  final String description;

  PlaceModel({
    this.id,
    required this.name,
    required this.province,
    required this.category,
    required this.image,
    required this.description,
  });

  // Convert object to Map for inserting to database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'province': province,
      'category': category,
      'image': image,
      'description': description,
    };
  }

  // Create object from Map (when reading from database)
  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      id: map['id'],
      name: map['name'],
      province: map['province'],
      category: map['category'],
      image: map['image'],
      description: map['description'],
    );
  }
}
