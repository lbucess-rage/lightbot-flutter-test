import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:first_flutter_app/screens/home_screen.dart';
import 'package:first_flutter_app/theme/app_theme.dart';
import 'package:first_flutter_app/widgets/bottom_navigation.dart';
import 'package:first_flutter_app/services/chat_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 시스템 UI 설정
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // 웹챗 SDK 초기화
  await _initChatService();

  runApp(const MyApp());
}

Future<void> _initChatService() async {
  final chatService = ChatService();

  await chatService.initialize(
    ChatConfig(
      lightbotId: 'bpzv9ay',
      apiHost: 'https://api.example.com',
      previewMessage: '안녕하세요! 무엇을 도와드릴까요?',
      prefilledVariables: {'userId': 'user123', 'userName': '홍길동'},
      styles: {
        'button': {
          'size': '60px',
          'backgroundColor': '#4373e5',
          'boxShadow': '0 4px 12px rgba(0, 0, 0, 0.1)',
        },
        'chatWindow': {
          'width': '380px',
          'height': '600px',
          'backgroundColor': '#ffffff',
        },
      },
    ),
  );

  chatService.setMessageListener((message) {
    print('웹챗 메시지: $message');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '아파트관리',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2; // 홈 탭이 중앙에 위치

  final List<Widget> _screens = [
    const Center(child: Text('관리사무소')),
    const Center(child: Text('혜택')),
    const HomeScreen(),
    const Center(child: Text('생활')),
    const Center(child: Text('내정보')),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
