import 'hotel_photo.dart';

class Hotel {
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
  final List<HotelPhoto> photos; // <-- Keep List of HotelPhoto

  Hotel({
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

  factory Hotel.fromMap(Map<String, dynamic> map, List<HotelPhoto> photos) {
    return Hotel(
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
