class Friend {
  final String id;
  final String name;
  final String avatarUrl;
  final int points;
  final int streak;
  final String recentActivity;
  final String recentActivityTime;
  final String? badgeEarned;
  final String? badgeIcon;
  final String? badgeCategory;

  Friend({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.points,
    required this.streak,
    required this.recentActivity,
    required this.recentActivityTime,
    this.badgeEarned,
    this.badgeIcon,
    this.badgeCategory,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'points': points,
      'streak': streak,
      'recentActivity': recentActivity,
      'recentActivityTime': recentActivityTime,
      'badgeEarned': badgeEarned,
      'badgeIcon': badgeIcon,
      'badgeCategory': badgeCategory,
    };
  }

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      points: json['points'],
      streak: json['streak'],
      recentActivity: json['recentActivity'],
      recentActivityTime: json['recentActivityTime'],
      badgeEarned: json['badgeEarned'],
      badgeIcon: json['badgeIcon'],
      badgeCategory: json['badgeCategory'],
    );
  }
}
