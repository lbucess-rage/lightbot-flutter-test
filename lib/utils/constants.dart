class AppConstants {
  // API 관련 상수
  static const String baseUrl = 'https://api.example.com';

  // 앱 정보
  static const String appName = '아파트관리';
  static const String appVersion = '1.0.0';

  // 화면 전환 애니메이션 지속 시간
  static const int animationDuration = 300; // 밀리초

  // 하단 네비게이션 항목 개수
  static const int bottomNavItemCount = 5;

  // 화면 이름
  static const String homeScreen = 'home';
  static const String feeScreen = 'fee';
  static const String livingExpenseScreen = 'living_expense';
  static const String benefitScreen = 'benefit';
  static const String myInfoScreen = 'my_info';

  // 공지 유형
  static const String noticeTypeImportant = 'important';
  static const String noticeTypeNormal = 'normal';

  // 샘플 데이터: 아이콘 레이블
  static const List<String> mainFeatureLabels = [
    '전자고지서',
    '커뮤니티',
    '꿀팁지',
    '네이버페이\n정기결제',
    '캐시적립',
  ];

  static const List<String> utilityFeatureLabels = [
    '월세납부',
    '방문차량\n예약',
    '장충금\n계산기',
    '이벤트',
    '더보기',
  ];
}

// 날짜 형식 상수
class DateFormats {
  static const String yearMonth = 'yyyy년 MM월';
  static const String yearMonthDay = 'yyyy년 MM월 dd일';
  static const String monthDay = 'MM/dd';
}

// 금액 관련 상수
class MoneyConstants {
  static const String currencySymbol = '₩';
  static const String won = '원';
}
