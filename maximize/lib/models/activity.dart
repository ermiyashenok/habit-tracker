class Activity {
  final String id;
  final String name;
  final String category;
  final String? time; // "HH:MM"
  final String repeatPattern; // "daily" | "weekdays" | "everyNDays" | "anytime"
  final bool isActive;
  final bool isArchived;
  final DateTime createdAt;
  final int xpReward;
  final String notes;

  Activity({
    required this.id,
    required this.name,
    required this.category,
    this.time,
    required this.repeatPattern,
    this.isActive = true,
    this.isArchived = false,
    required this.createdAt,
    this.xpReward = 100,
    this.notes = '',
  });

  Activity copyWith({
    String? id,
    String? name,
    String? category,
    String? time,
    String? repeatPattern,
    bool? isActive,
    bool? isArchived,
    DateTime? createdAt,
    int? xpReward,
    String? notes,
  }) {
    return Activity(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      time: time ?? this.time,
      repeatPattern: repeatPattern ?? this.repeatPattern,
      isActive: isActive ?? this.isActive,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      xpReward: xpReward ?? this.xpReward,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'time': time,
      'repeatPattern': repeatPattern,
      'isActive': isActive,
      'isArchived': isArchived,
      'createdAt': createdAt.toIso8601String(),
      'xpReward': xpReward,
      'notes': notes,
    };
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      time: json['time'],
      repeatPattern: json['repeatPattern'],
      isActive: json['isActive'] ?? true,
      isArchived: json['isArchived'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      xpReward: json['xpReward'] ?? 100,
      notes: json['notes'] ?? '',
    );
  }
}
