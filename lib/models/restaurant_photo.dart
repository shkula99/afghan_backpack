class RestaurantPhoto {
  final int id;
  final int restaurantId;
  final String image; // Path or URL

  RestaurantPhoto({
    required this.id,
    required this.restaurantId,
    required this.image,
  });

  factory RestaurantPhoto.fromMap(Map<String, dynamic> map) {
    return RestaurantPhoto(
      id: map['id'],
      restaurantId: map['restaurant_id'],
      image: map['image'] ?? '',
    );
  }
}
