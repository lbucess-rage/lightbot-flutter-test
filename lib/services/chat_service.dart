import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatConfig {
  final String lightbotId;
  final String apiHost;
  final String previewMessage;
  final String avatarUrl;
  final Map<String, dynamic> prefilledVariables;
  final Map<String, dynamic> styles;

  ChatConfig({
    required this.lightbotId,
    required this.apiHost,
    this.previewMessage = '안녕하세요! 무엇을 도와드릴까요?',
    this.avatarUrl = '',
    this.prefilledVariables = const {},
    this.styles = const {},
  });

  Map<String, dynamic> toJson() => {
    'lightbotId': lightbotId,
    'apiHost': apiHost,
    'previewMessage': previewMessage,
    'avatarUrl': avatarUrl,
    'prefilledVariables': prefilledVariables,
    'styles': styles,
  };
}

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  WebViewController? _controller;
  bool _isInitialized = false;
  Function(Map<String, dynamic>)? _messageCallback;

  // HTML 템플릿 파일에 대한 참조
  static const String _chatbotHtmlAsset = 'assets/chatbot.html';

  // 채팅 초기화
  Future<void> initialize(ChatConfig config) async {
    if (_isInitialized) return;

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..addJavaScriptChannel(
            'ChatSDK',
            onMessageReceived: (JavaScriptMessage message) {
              if (_messageCallback != null) {
                try {
                  final data = jsonDecode(message.message);
                  _messageCallback!(data);
                } catch (e) {
                  debugPrint('웹챗 메시지 파싱 오류: $e');
                }
              }
            },
          )
          ..setBackgroundColor(Colors.transparent)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (url) {
                // 페이지 로드 완료 후 초기화 함수 호출
                final configJson = jsonEncode(config.toJson());
                _controller?.runJavaScript(
                  'window.initializeChatbot($configJson)',
                );
                _isInitialized = true;
              },
            ),
          )
          ..loadFlutterAsset(_chatbotHtmlAsset);

    await Future.delayed(const Duration(milliseconds: 500));
  }

  // 메시지 리스너 설정
  void setMessageListener(Function(Map<String, dynamic>) callback) {
    _messageCallback = callback;
  }

  // 웹챗 열기
  void openChat() {
    if (!_isInitialized) return;
    _controller?.runJavaScript('window.openChatbot()');
  }

  // 웹챗 닫기
  void closeChat() {
    if (!_isInitialized) return;
    _controller?.runJavaScript('window.closeChatbot()');
  }

  // 웹챗 토글
  void toggleChat() {
    if (!_isInitialized) return;
    _controller?.runJavaScript('window.toggleChatbot()');
  }

  // 미리보기 메시지 표시
  void showPreviewMessage(String message, [String? avatarUrl]) {
    if (!_isInitialized) return;
    _controller?.runJavaScript(
      'window.showPreviewMessage("$message", "${avatarUrl ?? ''}")',
    );
  }

  // 사용자 변수 설정
  void setPrefilledVariables(Map<String, dynamic> variables) {
    if (!_isInitialized) return;
    final variablesJson = jsonEncode(variables);
    _controller?.runJavaScript('window.setPrefilledVariables($variablesJson)');
  }

  // 채팅 기록 저장
  Future<void> saveChatHistory(List<Map<String, dynamic>> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final history = jsonEncode(messages);
    await prefs.setString('chat_history', history);
  }

  // 채팅 기록 로드
  Future<List<Map<String, dynamic>>> loadChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getString('chat_history');
    if (history == null) return [];

    try {
      final List<dynamic> decoded = jsonDecode(history);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      debugPrint('채팅 기록 로드 오류: $e');
      return [];
    }
  }

  // 웹뷰 컨트롤러 얻기
  WebViewController? getController() {
    return _controller;
  }
}
