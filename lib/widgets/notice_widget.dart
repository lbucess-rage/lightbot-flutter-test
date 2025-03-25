import 'package:flutter/material.dart';
import 'package:first_flutter_app/models/notice.dart';
import 'package:first_flutter_app/theme/app_theme.dart';

class NoticeWidget extends StatelessWidget {
  final Notice notice;
  final VoidCallback? onTap;

  const NoticeWidget({super.key, required this.notice, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                notice.isImportant
                    ? AppTheme.primaryColor.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            notice.isImportant
                ? Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '공지',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                : const SizedBox(width: 0),
            SizedBox(width: notice.isImportant ? 8 : 0),
            Expanded(
              child: Text(
                notice.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      notice.isRead ? FontWeight.normal : FontWeight.bold,
                  color: notice.isRead ? Colors.grey : Colors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.close, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class NoticeCarousel extends StatelessWidget {
  final List<Notice> notices;
  final Function(Notice) onNoticeTap;

  const NoticeCarousel({
    super.key,
    required this.notices,
    required this.onNoticeTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: notices.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.85,
            margin: const EdgeInsets.only(right: 12),
            child: NoticeWidget(
              notice: notices[index],
              onTap: () => onNoticeTap(notices[index]),
            ),
          );
        },
      ),
    );
  }
}
