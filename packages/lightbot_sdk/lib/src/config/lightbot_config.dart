/// Lightbot SDK의 설정을 관리하는 클래스
class LightbotConfig {
  /// 웹챗 URL (기본값은 제공된 URL)
  final String externalUrl;

  /// 사용자 ID
  final String memberId;

  /// 사용자 이름
  final String userName;

  /// 스케일 값
  final String scale;

  /// 기타 설정 파라미터
  final Map<String, dynamic> additionalParams;

  const LightbotConfig({
    this.externalUrl =
        'https://lightbot-rage.s3.ap-northeast-2.amazonaws.com/lightbot/page/v1/chatbot_external.html',
    this.memberId = '',
    this.userName = '',
    this.scale = '0.95',
    this.additionalParams = const {},
  });

  /// 모든 설정을 Map으로 변환
  Map<String, dynamic> toMap() {
    return {
      'memberId': memberId,
      'userName': userName,
      'scale': scale,
      ...additionalParams,
    };
  }

  /// 현재 설정에 새로운 값을 병합하여 새 인스턴스 생성
  LightbotConfig copyWith({
    String? externalUrl,
    String? memberId,
    String? userName,
    String? scale,
    Map<String, dynamic>? additionalParams,
  }) {
    return LightbotConfig(
      externalUrl: externalUrl ?? this.externalUrl,
      memberId: memberId ?? this.memberId,
      userName: userName ?? this.userName,
      scale: scale ?? this.scale,
      additionalParams: additionalParams ?? this.additionalParams,
    );
  }
}
