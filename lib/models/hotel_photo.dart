class HotelPhoto {
  final int id;
  final int hotelId;
  final String image; // Path or URL

  HotelPhoto({
    required this.id,
    required this.hotelId,
    required this.image,
  });

  factory HotelPhoto.fromMap(Map<String, dynamic> map) {
    return HotelPhoto(
      id: map['id'],
      hotelId: map['hotel_id'],
      image: map['image'] ?? '',
    );
  }
}
