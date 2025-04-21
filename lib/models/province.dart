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
}

