import 'package:intl/intl.dart';

class MaintenanceFee {
  final DateTime date;
  final int totalAmount;
  final Map<String, int> details;
  final bool isPaid;
  final DateTime? paidDate;

  MaintenanceFee({
    required this.date,
    required this.totalAmount,
    required this.details,
    required this.isPaid,
    this.paidDate,
  });

  factory MaintenanceFee.fromJson(Map<String, dynamic> json) {
    Map<String, int> detailsMap = {};
    if (json['details'] != null) {
      json['details'].forEach((key, value) {
        detailsMap[key] = (value as num).toInt();
      });
    }

    return MaintenanceFee(
      date: DateTime.parse(json['date']),
      totalAmount: json['totalAmount'],
      details: detailsMap,
      isPaid: json['isPaid'] ?? false,
      paidDate:
          json['paidDate'] != null ? DateTime.parse(json['paidDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': DateFormat('yyyy-MM-dd').format(date),
      'totalAmount': totalAmount,
      'details': details,
      'isPaid': isPaid,
      'paidDate':
          paidDate != null ? DateFormat('yyyy-MM-dd').format(paidDate!) : null,
    };
  }

  // 샘플 데이터 생성
  static List<MaintenanceFee> sampleList() {
    return [
      MaintenanceFee(
        date: DateTime(2023, 4, 1),
        totalAmount: 250000,
        details: {
          '일반관리비': 85000,
          '청소비': 25000,
          '경비비': 35000,
          '전기료': 45000,
          '수도료': 25000,
          '가스비': 15000,
          '승강기유지비': 20000,
        },
        isPaid: true,
        paidDate: DateTime(2023, 4, 10),
      ),
      MaintenanceFee(
        date: DateTime(2023, 3, 1),
        totalAmount: 230000,
        details: {
          '일반관리비': 80000,
          '청소비': 25000,
          '경비비': 35000,
          '전기료': 40000,
          '수도료': 20000,
          '가스비': 10000,
          '승강기유지비': 20000,
        },
        isPaid: true,
        paidDate: DateTime(2023, 3, 10),
      ),
      MaintenanceFee(
        date: DateTime(2023, 2, 1),
        totalAmount: 280000,
        details: {
          '일반관리비': 85000,
          '청소비': 25000,
          '경비비': 35000,
          '전기료': 60000,
          '수도료': 30000,
          '가스비': 25000,
          '승강기유지비': 20000,
        },
        isPaid: true,
        paidDate: DateTime(2023, 2, 15),
      ),
    ];
  }
}

class UtilityFee {
  final String type; // 전기, 수도, 가스 등
  final DateTime date;
  final int amount;
  final bool isPaid;
  final DateTime? paidDate;
  final String provider;

  UtilityFee({
    required this.type,
    required this.date,
    required this.amount,
    required this.isPaid,
    this.paidDate,
    required this.provider,
  });

  // 샘플 데이터
  static List<UtilityFee> sampleList() {
    return [
      UtilityFee(
        type: '전기',
        date: DateTime(2023, 4, 1),
        amount: 45000,
        isPaid: true,
        paidDate: DateTime(2023, 4, 10),
        provider: '한국전력공사',
      ),
      UtilityFee(
        type: '수도',
        date: DateTime(2023, 4, 1),
        amount: 25000,
        isPaid: true,
        paidDate: DateTime(2023, 4, 10),
        provider: '서울시 상수도사업본부',
      ),
      UtilityFee(
        type: '도시가스',
        date: DateTime(2023, 4, 1),
        amount: 15000,
        isPaid: false,
        provider: '서울도시가스',
      ),
    ];
  }
}
