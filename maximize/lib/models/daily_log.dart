class DailyLog {
  final String id;
  final String activityId;
  final String date; // "YYYY-MM-DD"
  final String status; // "done" | "skipped" | "missed"
  final DateTime? completedAt;
  final int durationSeconds;
  final String note;

  DailyLog({
    required this.id,
    required this.activityId,
    required this.date,
    required this.status,
    this.completedAt,
    this.durationSeconds = 0,
    this.note = '',
  });

  DailyLog copyWith({
    String? id,
    String? activityId,
    String? date,
    String? status,
    DateTime? completedAt,
    int? durationSeconds,
    String? note,
  }) {
    return DailyLog(
      id: id ?? this.id,
      activityId: activityId ?? this.activityId,
      date: date ?? this.date,
      status: status ?? this.status,
      completedAt: completedAt ?? this.completedAt,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'activityId': activityId,
      'date': date,
      'status': status,
      'completedAt': completedAt?.toIso8601String(),
      'durationSeconds': durationSeconds,
      'note': note,
    };
  }

  factory DailyLog.fromJson(Map<String, dynamic> json) {
    return DailyLog(
      id: json['id'],
      activityId: json['activityId'],
      date: json['date'],
      status: json['status'],
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
      durationSeconds: json['durationSeconds'] ?? 0,
      note: json['note'] ?? '',
    );
  }
}
