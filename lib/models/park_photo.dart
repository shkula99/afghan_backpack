class ParkPhoto {
  final int id;
  final int parkId;
  final String image; // Path or URL

  ParkPhoto({
    required this.id,
    required this.parkId,
    required this.image,
  });

  factory ParkPhoto.fromMap(Map<String, dynamic> map) {
    return ParkPhoto(
      id: map['id'],
      parkId: map['park_id'],
      image: map['image'] ?? '',
    );
  }
}
