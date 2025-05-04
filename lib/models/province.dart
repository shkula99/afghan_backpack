class Province {
  final int id;
  final String name;
  final String description;
  final String image; // <--- main cover image
  final double latitude;
  final double longitude;
  final String locationUrl;

  Province({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.locationUrl,
  });

  factory Province.fromMap(Map<String, dynamic> map) {
    return Province(
      id: map['id'] ?? 0, // Default value for id if null
      name: map['name'] ?? 'none', // Default value for name if null
      description: map['description'] ?? 'No description available', // Default value for about if null
      image: map['image'] ?? '', // Default value for image if null
      latitude: map['latitude'] ?? 0.0, // Default value for latitude if null
      longitude: map['longitude'] ?? 0.0, // Default value for longitude if null
      locationUrl: map['location_url'] ?? '',
    );
  }
}
