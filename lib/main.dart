import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:first_flutter_app/screens/home_screen.dart';
import 'package:first_flutter_app/theme/app_theme.dart';
import 'package:first_flutter_app/widgets/bottom_navigation.dart';
import 'package:lightbot_sdk_v3271/lightbot_sdk_v3271.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 시스템 UI 설정
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // Lightbot SDK 초기화
  LightbotSDK.initialize(
    config: const LightbotConfig(
      externalUrl:
          'https://lightbot-rage.s3.ap-northeast-2.amazonaws.com/lightbot/staging/page/v1/chatbot_external-staging.html',
      memberId: 'r1111',
      userName: '테스터',
      scale: '0.95',
      authKey: 'client_5e9622ff-eaad-4423-98e3-093cba07f167',
      additionalParams: {
        'ci': 'n0veu3t3gd648paqvp10lzkw111',
        'directUrl':
            'https://lightbot-dev.lbucess.com/domain-cz5g02d?memberId=r1111&ci=n0veu3t3gd648paqvp10lzkw112&authKey=xxxxxxxx',
      },
    ),
  );

  runApp(const MyApp());
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
