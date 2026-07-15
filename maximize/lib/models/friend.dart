class Friend {
  final String id;
  final String name;
  final String avatarUrl;
  final int xp;
  final int streak;

  Friend({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.xp,
    required this.streak,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'xp': xp,
      'streak': streak,
    };
  }

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Adventurer',
      avatarUrl: json['avatarUrl'] as String? ?? '',
      xp: (json['xp'] as num?)?.toInt() ?? (json['points'] as num?)?.toInt() ?? 0,
      streak: (json['streak'] as num?)?.toInt() ?? 0,
    );
  }
}
