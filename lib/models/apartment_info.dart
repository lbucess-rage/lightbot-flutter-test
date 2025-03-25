class ApartmentInfo {
  final String name;
  final String address;
  final String dong;
  final String ho;
  final double area;
  final int residents;
  final int parkingSpots;

  ApartmentInfo({
    required this.name,
    required this.address,
    required this.dong,
    required this.ho,
    required this.area,
    required this.residents,
    required this.parkingSpots,
  });

  factory ApartmentInfo.fromJson(Map<String, dynamic> json) {
    return ApartmentInfo(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      dong: json['dong'] ?? '',
      ho: json['ho'] ?? '',
      area: (json['area'] ?? 0).toDouble(),
      residents: json['residents'] ?? 0,
      parkingSpots: json['parkingSpots'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'dong': dong,
      'ho': ho,
      'area': area,
      'residents': residents,
      'parkingSpots': parkingSpots,
    };
  }

  // 샘플 데이터
  static ApartmentInfo sample() {
    return ApartmentInfo(
      name: '래미안 아파트',
      address: '서울특별시 강남구 테헤란로 123',
      dong: '101',
      ho: '1201',
      area: 84.5,
      residents: 3,
      parkingSpots: 1,
    );
  }
}
