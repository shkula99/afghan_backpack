class Province {
  final String name;
  final String image;
  final String about;
  final double latitude;
  final double longitude;
  final List<String> photos;
  final String locationUrl;

  Province({
    required this.name,
    required this.image,
    required this.about,
    required this.latitude,
    required this.longitude,
    required this.photos,
    required this.locationUrl,
  });

  // New: Create Province from a Map (for SQLite)
  factory Province.fromMap(Map<String, dynamic> map) {
    return Province(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      about: map['about'] ?? '',
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      photos: (map['photos'] as String).split(','),
      // photos saved as comma-separated string
      locationUrl: map['locationUrl'] ?? '',
    );
  }

}