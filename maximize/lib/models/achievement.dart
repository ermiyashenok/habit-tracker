class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String categoryColor; // 'primary' | 'secondary' | 'tertiary' | 'purple' | 'grey'
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final int threshold;
  final int progress;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.categoryColor,
    this.isUnlocked = false,
    this.unlockedAt,
    required this.threshold,
    required this.progress,
  });

  Achievement copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    String? categoryColor,
    bool? isUnlocked,
    DateTime? unlockedAt,
    int? threshold,
    int? progress,
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      categoryColor: categoryColor ?? this.categoryColor,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      threshold: threshold ?? this.threshold,
      progress: progress ?? this.progress,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'categoryColor': categoryColor,
      'isUnlocked': isUnlocked,
      'unlockedAt': unlockedAt?.toIso8601String(),
      'threshold': threshold,
      'progress': progress,
    };
  }

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      icon: json['icon'],
      categoryColor: json['categoryColor'],
      isUnlocked: json['isUnlocked'] ?? false,
      unlockedAt: json['unlockedAt'] != null ? DateTime.parse(json['unlockedAt']) : null,
      threshold: json['threshold'] ?? 100,
      progress: json['progress'] ?? 0,
    );
  }
}
