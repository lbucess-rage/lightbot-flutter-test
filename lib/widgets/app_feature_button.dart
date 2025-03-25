import 'package:flutter/material.dart';
import 'package:first_flutter_app/theme/app_theme.dart';

class AppFeatureButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;
  final VoidCallback? onTap;
  final bool isHot;
  final bool isNew;

  const AppFeatureButton({
    super.key,
    required this.label,
    required this.icon,
    this.color,
    this.onTap,
    this.isHot = false,
    this.isNew = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color:
                      color?.withOpacity(0.1) ?? Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color ?? Colors.grey, size: 32),
              ),
              if (isHot)
                Positioned(
                  top: -5,
                  right: -5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'HOT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              if (isNew)
                Positioned(
                  top: -5,
                  right: -5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'NEW',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class FeatureGrid extends StatelessWidget {
  final List<FeatureItem> features;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const FeatureGrid({
    super.key,
    required this.features,
    this.crossAxisCount = 5,
    this.mainAxisSpacing = 16.0,
    this.crossAxisSpacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: 0.8,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return AppFeatureButton(
          label: feature.label,
          icon: feature.icon,
          color: feature.color,
          onTap: feature.onTap,
          isHot: feature.isHot,
          isNew: feature.isNew,
        );
      },
    );
  }
}

class FeatureItem {
  final String label;
  final IconData icon;
  final Color? color;
  final VoidCallback? onTap;
  final bool isHot;
  final bool isNew;

  FeatureItem({
    required this.label,
    required this.icon,
    this.color,
    this.onTap,
    this.isHot = false,
    this.isNew = false,
  });

  // 샘플 기능 아이템 리스트
  static List<FeatureItem> mainFeatures(BuildContext context) {
    return [
      FeatureItem(
        label: '전자고지서',
        icon: Icons.receipt_long,
        color: AppTheme.primaryColor,
        onTap: () {},
      ),
      FeatureItem(
        label: '커뮤니티',
        icon: Icons.forum,
        color: Colors.orange,
        isHot: true,
        onTap: () {},
      ),
      FeatureItem(
        label: '꿀팁지',
        icon: Icons.lightbulb,
        color: Colors.amber,
        onTap: () {},
      ),
      FeatureItem(
        label: '정기결제',
        icon: Icons.payment,
        color: Colors.green,
        onTap: () {},
      ),
      FeatureItem(
        label: '캐시적립',
        icon: Icons.savings,
        color: Colors.purple,
        onTap: () {},
      ),
    ];
  }

  static List<FeatureItem> utilityFeatures(BuildContext context) {
    return [
      FeatureItem(
        label: '월세납부',
        icon: Icons.home,
        color: Colors.blue,
        onTap: () {},
      ),
      FeatureItem(
        label: '방문차량',
        icon: Icons.car_rental,
        color: Colors.teal,
        onTap: () {},
      ),
      FeatureItem(
        label: '계산기',
        icon: Icons.calculate,
        color: Colors.deepOrange,
        isNew: true,
        onTap: () {},
      ),
      FeatureItem(
        label: '이벤트',
        icon: Icons.card_giftcard,
        color: Colors.pinkAccent,
        onTap: () {},
      ),
      FeatureItem(
        label: '더보기',
        icon: Icons.more_horiz,
        color: Colors.grey,
        onTap: () {},
      ),
    ];
  }
}
