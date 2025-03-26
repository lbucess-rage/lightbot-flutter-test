import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:first_flutter_app/theme/app_theme.dart';
import 'dart:convert';

class WebChatOverlay extends StatefulWidget {
  final Function? onClose;

  const WebChatOverlay({super.key, this.onClose});

  @override
  State<WebChatOverlay> createState() => _WebChatOverlayState();
}

class _WebChatOverlayState extends State<WebChatOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late WebViewController _webViewController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();

    _initWebView();
  }

  void _initWebView() {
    _webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..addJavaScriptChannel(
            'ChatSDK',
            onMessageReceived: _handleJavaScriptMessage,
          )
          ..setBackgroundColor(Colors.white)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (url) {
                setState(() {
                  _isLoading = false;
                });
                // 화면 크기에 따라 웹챗 스케일 자동 조정
                _adjustChatScale();

                // 파라미터 전달을 위한 JavaScript 실행
                _webViewController.runJavaScript('''
                  window.chatConfig = {
                    theme: 'light',
                    userId: 'user123',
                    apiKey: 'your-api-key'
                  };
                ''');
              },
              onWebResourceError: (WebResourceError error) {
                print('웹뷰 에러: ${error.description}, 에러 코드: ${error.errorCode}');
              },
            ),
          )
          ..enableZoom(true)
          ..clearCache()
          ..clearLocalStorage()
          ..loadFlutterAsset('assets/chatbot_standard.html');
  }

  // 화면 크기에 따라 웹챗 스케일 조정
  void _adjustChatScale() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 화면 크기에 따라 스케일 값 결정
    double scale = 0.95; // 기본값

    // 작은 화면 (360dp 미만)
    if (screenWidth < 360) {
      scale = 0.85;
    }
    // 매우 작은 화면
    else if (screenWidth < 320) {
      scale = 0.75;
    }

    // 화면 높이가 작은 경우에도 조정
    if (screenHeight < 600) {
      scale = scale * 0.9;
    }

    // CSS 변수 업데이트를 위한 JavaScript 실행
    _webViewController.runJavaScript(
      'document.documentElement.style.setProperty("--chat-scale", "$scale");',
    );
  }

  void _handleJavaScriptMessage(JavaScriptMessage message) {
    print('웹챗으로부터 메시지 수신: ${message.message}');
    try {
      // 메시지 파싱
      final data = jsonDecode(message.message);
      // 필요한 경우 메시지에 따른 로직 구현
      if (data is Map && data.containsKey('type')) {
        switch (data['type']) {
          case 'status':
            print('웹챗 상태 변경: ${data['status']}');
            break;
          case 'message':
            print('채팅 메시지: ${data['content']}');
            print('챗봇 응답: ${data['response']}');
            break;
        }
      }
    } catch (e) {
      print('메시지 파싱 오류: $e');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _closeOverlay() {
    // 닫기 애니메이션 실행
    _animationController.reverse().then((value) {
      if (widget.onClose != null) {
        widget.onClose!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 화면 크기에 따라 적절한 여백 계산
    final screenSize = MediaQuery.of(context).size;

    // 화면 크기에 따른 여백 세부 조정
    double horizontalPadding;
    double verticalPadding;

    // 화면 너비에 따른 가로 여백 조정
    if (screenSize.width < 320) {
      horizontalPadding = 4.0;
    } else if (screenSize.width < 360) {
      horizontalPadding = 8.0;
    } else if (screenSize.width < 400) {
      horizontalPadding = 12.0;
    } else {
      horizontalPadding = 16.0;
    }

    // 화면 높이에 따른 세로 여백 조정
    if (screenSize.height < 600) {
      verticalPadding = 16.0;
    } else if (screenSize.height < 700) {
      verticalPadding = 24.0;
    } else if (screenSize.height < 800) {
      verticalPadding = 32.0;
    } else {
      verticalPadding = 48.0;
    }

    return FadeTransition(
      opacity: _animation,
      child: Stack(
        children: [
          // 배경 딤 처리
          GestureDetector(
            onTap: _closeOverlay,
            child: Container(
              color: Colors.black54,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // 챗봇 컨테이너
          Center(
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.2),
                end: Offset.zero,
              ).animate(_animation),
              child: Container(
                width:
                    MediaQuery.of(context).size.width - (horizontalPadding * 2),
                height:
                    MediaQuery.of(context).size.height - (verticalPadding * 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      // 웹챗 영역 (전체 화면)
                      LayoutBuilder(
                        builder: (context, constraints) {
                          // WebView가 사용할 크기 계산
                          return SizedBox(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            child: WebViewWidget(
                              controller: _webViewController,
                            ),
                          );
                        },
                      ),

                      // 닫기 버튼 (오른쪽 상단에 플로팅 형태)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: InkWell(
                          onTap: _closeOverlay,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.black54,
                              size: 20,
                            ),
                          ),
                        ),
                      ),

                      // 로딩 표시
                      if (_isLoading)
                        const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppTheme.primaryColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 웹챗 서비스 호출 함수
void showWebChat(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '웹챗 닫기',
    pageBuilder: (context, animation, secondaryAnimation) {
      return Material(
        type: MaterialType.transparency,
        child: WebChatOverlay(
          onClose: () {
            Navigator.of(context).pop();
          },
        ),
      );
    },
  );
}
