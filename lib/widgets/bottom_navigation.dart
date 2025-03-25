import 'package:flutter/material.dart';
import 'package:first_flutter_app/theme/app_theme.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.apartment), label: '관리사무소'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: '혜택'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: '생활'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내정보'),
        ],
      ),
    );
  }
}

class BottomNotification extends StatelessWidget {
  final String count;
  final int index;
  final int currentIndex;

  const BottomNotification({
    super.key,
    required this.count,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return index == currentIndex
        ? const SizedBox.shrink()
        : Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
            child: Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
  }
}
