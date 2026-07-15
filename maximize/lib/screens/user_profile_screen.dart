import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/chunky_colors.dart';
import '../widgets/chunky_card.dart';
import '../widgets/avatar_helper.dart';

class UserProfileScreen extends StatefulWidget {
  final String uid;
  final String displayName;
  final String? photoUrl;
  final bool isFriend;
  final VoidCallback? onAddFriend;
  final VoidCallback? onRemoveFriend;

  const UserProfileScreen({
    super.key,
    required this.uid,
    required this.displayName,
    this.photoUrl,
    this.isFriend = false,
    this.onAddFriend,
    this.onRemoveFriend,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Map<String, dynamic>? _profileData;
  List<Map<String, dynamic>> _badges = [];
  bool _isLoading = true;
  bool _isFriend = false;

  @override
  void initState() {
    super.initState();
    _isFriend = widget.isFriend;
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      // Load public profile
      final profileDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // Load achievements from app_data
      final stateDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection('app_data')
          .doc('state')
          .get();

      List<Map<String, dynamic>> badges = [];
      if (stateDoc.exists) {
        final data = stateDoc.data() as Map<String, dynamic>;
        if (data['achievements'] != null) {
          final List<dynamic> achList = data['achievements'];
          badges = achList
              .map((a) => a as Map<String, dynamic>)
              .where((a) => a['isUnlocked'] == true)
              .toList();
        }
      }

      setState(() {
        _profileData = profileDoc.exists
            ? profileDoc.data() as Map<String, dynamic>
            : {'displayName': widget.displayName, 'xp': 0, 'level': 1, 'streak': 0};
        _badges = badges;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _profileData = {'displayName': widget.displayName, 'xp': 0, 'level': 1, 'streak': 0};
        _isLoading = false;
      });
    }
  }

  Color _getBadgeColor(String categoryColor) {
    switch (categoryColor) {
      case 'primary': return ChunkyColors.primary;
      case 'secondary': return ChunkyColors.secondary;
      case 'tertiary': return const Color(0xFF4CAF50);
      case 'purple': return const Color(0xFF9C27B0);
      default: return ChunkyColors.outline;
    }
  }

  IconData _getBadgeIcon(String iconName) {
    const iconMap = {
      'bolt': Icons.bolt,
      'eco': Icons.eco,
      'lock': Icons.lock,
      'nightlight_round': Icons.nightlight_round,
      'local_fire_department': Icons.local_fire_department,
      'workspace_premium': Icons.workspace_premium,
      'account_balance': Icons.account_balance,
      'spa': Icons.spa,
      'school': Icons.school,
      'auto_awesome': Icons.auto_awesome,
      'shield': Icons.shield,
      'military_tech': Icons.military_tech,
      'emoji_events': Icons.emoji_events,
      'rocket_launch': Icons.rocket_launch,
      'wb_sunny': Icons.wb_sunny,
      'dark_mode': Icons.dark_mode,
      'landscape': Icons.landscape,
    };
    return iconMap[iconName] ?? Icons.star;
  }

  @override
  Widget build(BuildContext context) {
    final xp = _profileData?['xp'] ?? 0;
    final level = _profileData?['level'] ?? 1;
    final streak = _profileData?['streak'] ?? 0;
    final photoUrl = _profileData?['photoUrl'] ?? widget.photoUrl;
    final displayName = _profileData?['displayName'] ?? widget.displayName;
    final bio = _profileData?['bio'] as String?;

    return Scaffold(
      backgroundColor: ChunkyColors.background,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: ChunkyColors.background,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: ChunkyColors.onSurface),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              if (widget.onAddFriend != null || widget.onRemoveFriend != null)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _isFriend
                        ? OutlinedButton.icon(
                            key: const ValueKey('remove'),
                            onPressed: () {
                              widget.onRemoveFriend?.call();
                              setState(() => _isFriend = false);
                            },
                            icon: const Icon(Icons.person_remove, size: 18),
                            label: const Text('Friends'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: ChunkyColors.errorRed,
                              side: BorderSide(color: ChunkyColors.errorRed),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                          )
                        : ElevatedButton.icon(
                            key: const ValueKey('add'),
                            onPressed: () {
                              widget.onAddFriend?.call();
                              setState(() => _isFriend = true);
                            },
                            icon: const Icon(Icons.person_add, size: 18),
                            label: const Text('Add Friend'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ChunkyColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                  ),
                ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ChunkyColors.primary.withOpacity(0.15),
                      ChunkyColors.background,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      // Avatar
                      Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: ChunkyColors.primary, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: ChunkyColors.primary.withOpacity(0.35),
                              blurRadius: 18,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: buildAvatarWidget(photoUrl, size: 82, fallbackLetter: displayName),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        displayName,
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          color: ChunkyColors.onSurface,
                        ),
                      ),
                      if (bio != null && bio.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                          child: Text(
                            bio,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontSize: 13,
                              color: ChunkyColors.outline,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          if (_isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Stats Row
                  Row(
                    children: [
                      _buildStatCard('Level', '$level', Icons.military_tech, ChunkyColors.primary),
                      const SizedBox(width: 12),
                      _buildStatCard('Total XP', '$xp', Icons.stars, ChunkyColors.secondary),
                      const SizedBox(width: 12),
                      _buildStatCard('Streak', '$streak days', Icons.local_fire_department, const Color(0xFFFF6B35)),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // XP Progress bar
                  _buildXpBar(xp, level),
                  const SizedBox(height: 28),

                  // Badges
                  Row(
                    children: [
                      Text(
                        'ACHIEVEMENTS',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 1.5,
                          color: ChunkyColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: ChunkyColors.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${_badges.length} unlocked',
                          style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: ChunkyColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  if (_badges.isEmpty)
                    ChunkyCard(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Icon(Icons.emoji_events_outlined, size: 48, color: ChunkyColors.outline),
                              const SizedBox(height: 8),
                              Text(
                                'No badges unlocked yet',
                                style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  color: ChunkyColors.outline,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.6,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: _badges.length,
                      itemBuilder: (context, index) {
                        final badge = _badges[index];
                        final color = _getBadgeColor(badge['categoryColor'] ?? 'grey');
                        final icon = _getBadgeIcon(badge['icon'] ?? 'star');
                        return ChunkyCard(
                          borderColor: color.withOpacity(0.4),
                          shadowColor: color.withOpacity(0.2),
                          shadowHeight: 3,
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(icon, color: color, size: 22),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      badge['title'] ?? '',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: ChunkyColors.onSurface,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      badge['description'] ?? '',
                                      style: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontSize: 10,
                                        color: ChunkyColors.outline,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                  const SizedBox(height: 40),
                ]),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: ChunkyCard(
        borderColor: color.withOpacity(0.3),
        shadowColor: color.withOpacity(0.15),
        shadowHeight: 3,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 6),
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: ChunkyColors.onSurface,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontSize: 11,
                color: ChunkyColors.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildXpBar(int xp, int level) {
    int expAccumulated = 0;
    for (int lvl = 1; lvl < level; lvl++) {
      expAccumulated += ((100 * (lvl * lvl * lvl)) ~/ 1000 + 100) ~/ 10 * 10;
    }
    final currentLevelXp = xp - expAccumulated;
    final nextLevelXp = ((100 * (level * level * level)) ~/ 1000 + 100) ~/ 10 * 10;
    final progress = nextLevelXp > 0 ? (currentLevelXp / nextLevelXp).clamp(0.0, 1.0) : 1.0;

    return ChunkyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Level $level Progress',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: ChunkyColors.onSurface,
                ),
              ),
              Text(
                'Level ${level + 1}',
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontSize: 12,
                  color: ChunkyColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: ChunkyColors.surfaceContainerHigh,
              color: ChunkyColors.primary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$currentLevelXp / $nextLevelXp XP',
            style: TextStyle(
              fontFamily: 'BeVietnamPro',
              fontSize: 11,
              color: ChunkyColors.outline,
            ),
          ),
        ],
      ),
    );
  }
}
