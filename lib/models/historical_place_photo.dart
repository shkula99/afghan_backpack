class HistoricalPlacePhoto{
  final int id;
  final int historicalPlaceId;
  final String image; // Path or URL

  HistoricalPlacePhoto({
    required this.id,
    required this.historicalPlaceId,
    required this.image,
  });

  factory HistoricalPlacePhoto.fromMap(Map<String, dynamic> map) {
    return HistoricalPlacePhoto(
      id: map['id'],
      historicalPlaceId: map['historical_place_id'],
      image: map['image'] ?? '',
    );
  }
}
