enum NotificationType { appointment, payment, treatment, report, reminder, system, promotion }
enum NotificationPriority { low, medium, high }

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final NotificationPriority priority;
  final bool isRead;
  final String? relatedId;
  final String? imageUrl;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    this.priority = NotificationPriority.medium,
    this.isRead = false,
    this.relatedId,
    this.imageUrl,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      body: body,
      type: type,
      priority: priority,
      isRead: isRead ?? this.isRead,
      relatedId: relatedId,
      imageUrl: imageUrl,
      createdAt: createdAt,
    );
  }
}
