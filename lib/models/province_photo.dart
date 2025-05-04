class ProvincePhoto {
  final int id;
  final String image;
  final int provinceId;

  ProvincePhoto({
    required this.id,
    required this.image,
    required this.provinceId,
  });

  factory ProvincePhoto.fromMap(Map<String, dynamic> map) {
    return ProvincePhoto(
      id: map['id'],
      image: map['image'],
      provinceId: map['province_id'],
    );
  }
}
