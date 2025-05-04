import 'restaurant_photo.dart';

class Restaurant {
  final int id;
  final String name;
  final String image;
  final String description;
  final double latitude;
  final double longitude;
  final String phone;
  final String email;
  final String website;
  final String facebook;  // <-- Keep Facebook here
  final String instagram;
  final int provinceId;
  final List<RestaurantPhoto> photos; // <-- Keep List of RestaurantPhoto

  Restaurant({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.email,
    required this.website,
    required this.facebook,
    required this.instagram,
    required this.provinceId,
    required this.photos,
  });

  factory Restaurant.fromMap(Map<String, dynamic> map, List<RestaurantPhoto> photos) {
    return Restaurant(
      id: map['id'],
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      latitude: (map['latitude'] ?? 0.0).toDouble(),
      longitude: (map['longitude'] ?? 0.0).toDouble(),
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      website: map['website'] ?? '',
      facebook: map['facebook'] ?? '',
      instagram: map['instagram'] ?? '',
      provinceId: map['province_id'] ?? 0,
      photos: photos,
    );
  }
}
