class NoticesEntity {
  NoticesEntity({
    required this.id,
    required this.checkedAt,
  });

  final int id;
  final DateTime? checkedAt;

  factory NoticesEntity.fromJson(Map<String, dynamic> json) => NoticesEntity(
        id: json['id'] as int,
        checkedAt: json['checked_at'] == null
            ? null
            : DateTime.parse(json['checked_at'] as String),
      );
}

class Notices {
  Notices(this.notices);

  final List<NoticesEntity> notices;

  factory Notices.fromJson(List<Map<String, dynamic>> json) => Notices(
        List<NoticesEntity>.from(
          (json).map((x) => NoticesEntity.fromJson(x)),
        ),
      );
}
