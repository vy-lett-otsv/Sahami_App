class NotificationEntity {
  final int id;
  final String title;

  const NotificationEntity({required this.id, required this.title});

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      id: json['id'],
      title: json['title'],
    );
  }
}