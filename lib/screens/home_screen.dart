import 'package:flutter/material.dart';
import 'package:first_flutter_app/models/notice.dart';
import 'package:first_flutter_app/theme/app_theme.dart';
import 'package:first_flutter_app/widgets/notice_widget.dart';
import 'package:first_flutter_app/widgets/app_feature_button.dart';
import 'package:first_flutter_app/widgets/web_chat_overlay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Notice> _notices = Notice.sampleList();

  void _handleNoticeTap(Notice notice) {
    // 공지 상세 화면으로 이동 (생략)
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('공지사항: ${notice.title}')));
  }

  void _showCustomerSupport() {
    showWebChat(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('홈'),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 공지사항 캐러셀
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: NoticeCarousel(
                notices: _notices,
                onNoticeTap: _handleNoticeTap,
              ),
            ),

            // 주요 기능 섹션
            _buildSectionTitle('아파트 생활'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FeatureGrid(
                features: FeatureItem.mainFeatures(context).take(3).toList(),
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
            ),

            const SizedBox(height: 24),

            // 추가 기능 섹션
            _buildSectionTitle('편의 기능'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FeatureGrid(
                features: FeatureItem.utilityFeatures(context).take(3).toList(),
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
            ),

            const SizedBox(height: 24),

            // 광고 배너
            _buildBanner(),

            const SizedBox(height: 24),

            // 아파트캐시 섹션
            _buildApartmentCash(),

            // 하단 고객센터 버튼
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _showCustomerSupport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.primaryColor,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppTheme.primaryColor, width: 1.5),
                  ),
                  elevation: 2,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.headset_mic, size: 24),
                    SizedBox(width: 12),
                    Text(
                      '고객센터 상담',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppTheme.primaryColor,
        gradient: LinearGradient(
          colors: [AppTheme.primaryColor, const Color(0xFF5B86E5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: Colors.white, size: 24),
            SizedBox(width: 8),
            Text(
              '더 편하게, 더 Fun하게',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApartmentCash() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.monetization_on, color: Colors.amber),
              SizedBox(width: 8),
              Text(
                '요즘 우리 이웃들은?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue,
                child: Text('W', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '아파트캐시',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    '지난 주',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              Spacer(),
              Text(
                '85,392,728원 적립',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          const Text(
            '내 예약 현황',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildReservationItem(
            title: '방문차량 예약',
            description: '우리집 방문차량 간편하게 예약해요',
            icon: Icons.car_rental,
            color: Colors.teal,
          ),
          const SizedBox(height: 12),
          _buildReservationItem(
            title: '택배 예약',
            description: '배송비 부담 없는 택배 예약하기',
            icon: Icons.local_shipping,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildReservationItem({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
