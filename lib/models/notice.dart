class Notice {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final bool isImportant;
  final bool isRead;

  Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    this.isImportant = false,
    this.isRead = false,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      date: DateTime.parse(json['date']),
      isImportant: json['isImportant'] ?? false,
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'isImportant': isImportant,
      'isRead': isRead,
    };
  }

  // 읽음 상태 변경
  Notice copyWith({bool? isRead}) {
    return Notice(
      id: id,
      title: title,
      content: content,
      date: date,
      isImportant: isImportant,
      isRead: isRead ?? this.isRead,
    );
  }

  // 샘플 데이터
  static List<Notice> sampleList() {
    return [
      Notice(
        id: '1',
        title: '4월 아파트아이 서버 점검 안내 (4/5, 4/12)',
        content: '서비스 품질 향상을 위한 정기 점검이 진행됩니다. 점검 시간 동안 서비스 이용이 제한될 수 있습니다.',
        date: DateTime.now().subtract(const Duration(days: 2)),
        isImportant: true,
      ),
      Notice(
        id: '2',
        title: '아파트 주변 도로 공사 안내',
        content: '아파트 주변 도로 공사로 인해 일부 구간 통행이 제한됩니다. 자세한 내용은 관리사무소에 문의하세요.',
        date: DateTime.now().subtract(const Duration(days: 5)),
      ),
      Notice(
        id: '3',
        title: '주차장 도색 공사 안내',
        content: '지하 주차장 도색 공사가 예정되어 있습니다. 해당 기간 동안 일부 주차 구역 이용이 제한됩니다.',
        date: DateTime.now().subtract(const Duration(days: 7)),
      ),
    ];
  }
}
