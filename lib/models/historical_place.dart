import 'historical_place_photo.dart';


class HistoricalPlace {
  final int id;
  final String name;
  final String image;
  final String description;
  final double latitude;
  final double longitude;
  final int provinceId;
  final List<HistoricalPlacePhoto> photos; // <-- Keep List of ParkPhoto

  HistoricalPlace({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.provinceId,
    required this.photos,
  });

  factory HistoricalPlace.fromMap(Map<String, dynamic> map, List<HistoricalPlacePhoto> photos) {
    return HistoricalPlace(
      id: map['id'],
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      latitude: (map['latitude'] ?? 0.0).toDouble(),
      longitude: (map['longitude'] ?? 0.0).toDouble(),
      provinceId: map['province_id'] ?? 0,
      photos: photos,
    );
  }
}
