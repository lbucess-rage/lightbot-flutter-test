import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:first_flutter_app/models/maintenance_fee.dart';

class FeeService {
  static final FeeService _instance = FeeService._internal();
  factory FeeService() => _instance;
  FeeService._internal();

  // 로컬 스토리지 키
  static const String _maintenanceFeesKey = 'maintenance_fees';
  static const String _utilityFeesKey = 'utility_fees';

  // 관리비 데이터 가져오기
  Future<List<MaintenanceFee>> getMaintenanceFees() async {
    final prefs = await SharedPreferences.getInstance();
    final feesJson = prefs.getString(_maintenanceFeesKey);

    if (feesJson == null) {
      // 샘플 데이터 저장 및 반환
      final sampleFees = MaintenanceFee.sampleList();
      await saveMaintenanceFees(sampleFees);
      return sampleFees;
    }

    try {
      final List<dynamic> decoded = jsonDecode(feesJson);
      return decoded.map((item) => MaintenanceFee.fromJson(item)).toList();
    } catch (e) {
      print('관리비 데이터 파싱 오류: $e');
      return [];
    }
  }

  // 관리비 데이터 저장
  Future<void> saveMaintenanceFees(List<MaintenanceFee> fees) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedFees = jsonEncode(fees.map((fee) => fee.toJson()).toList());
    await prefs.setString(_maintenanceFeesKey, encodedFees);
  }

  // 생활요금 데이터 가져오기
  Future<List<UtilityFee>> getUtilityFees() async {
    final prefs = await SharedPreferences.getInstance();
    final feesJson = prefs.getString(_utilityFeesKey);

    if (feesJson == null) {
      // 샘플 데이터 저장 및 반환
      final sampleFees = UtilityFee.sampleList();
      // 샘플 데이터는 객체 변환 없이 사용하므로 저장하지 않음
      return sampleFees;
    }

    try {
      final List<dynamic> decoded = jsonDecode(feesJson);
      return decoded
          .map(
            (item) => UtilityFee(
              type: item['type'],
              date: DateTime.parse(item['date']),
              amount: item['amount'],
              isPaid: item['isPaid'],
              paidDate:
                  item['paidDate'] != null
                      ? DateTime.parse(item['paidDate'])
                      : null,
              provider: item['provider'],
            ),
          )
          .toList();
    } catch (e) {
      print('생활요금 데이터 파싱 오류: $e');
      return [];
    }
  }

  // 가장 최근 관리비 가져오기
  Future<MaintenanceFee?> getLatestMaintenanceFee() async {
    final fees = await getMaintenanceFees();
    if (fees.isEmpty) return null;

    fees.sort((a, b) => b.date.compareTo(a.date));
    return fees.first;
  }

  // 지난 6개월 관리비 총액 가져오기
  Future<List<MapEntry<DateTime, int>>> getLast6MonthsTotalFees() async {
    final fees = await getMaintenanceFees();
    if (fees.isEmpty) return [];

    // 최근 날짜순으로 정렬
    fees.sort((a, b) => b.date.compareTo(a.date));

    // 최대 6개월 데이터 가져오기
    final last6Months = fees.take(6).toList();

    // 월별 데이터로 변환
    return last6Months
        .map((fee) => MapEntry(fee.date, fee.totalAmount))
        .toList();
  }

  // 관리비 항목별 비율 계산
  Map<String, double> calculateFeeRatio(MaintenanceFee fee) {
    final total = fee.totalAmount.toDouble();
    Map<String, double> ratios = {};

    fee.details.forEach((key, value) {
      ratios[key] = value / total;
    });

    return ratios;
  }

  // 마지막 달 대비 관리비 증감액 계산
  Future<int> calculateFeeChange() async {
    final fees = await getMaintenanceFees();
    if (fees.length < 2) return 0;

    // 최근 날짜순으로 정렬
    fees.sort((a, b) => b.date.compareTo(a.date));

    // 이번 달과 저번 달 관리비 차이
    return fees[0].totalAmount - fees[1].totalAmount;
  }
}
