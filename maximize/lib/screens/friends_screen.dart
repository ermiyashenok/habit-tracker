import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/chunky_colors.dart';
import '../widgets/chunky_card.dart';
import '../providers/app_state.dart';
import '../models/friend.dart';

class FriendsScreen extends StatefulWidget {
  final AppState state;

  const FriendsScreen({
    super.key,
    required this.state,
  });

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _reactedFriends = {};

  void _triggerCheerEffect(String friendId) {
    setState(() {
      _reactedFriends.add(friendId);
    });

    // Reset after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _reactedFriends.remove(friendId);
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final friends = widget.state.friends;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search Box
          FocusScope(
            child: Focus(
              onFocusChange: (hasFocus) {},
              child: Builder(
                builder: (context) {
                  final hasFocus = Focus.of(context).hasFocus;
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      color: ChunkyColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: hasFocus ? ChunkyColors.primaryContainer : ChunkyColors.surfaceContainerHighest,
                        width: 2.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: hasFocus ? ChunkyColors.primaryContainer : const Color(0xFFE3E2E2),
                          offset: const Offset(0, 4),
                          blurRadius: 0,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(fontFamily: 'BeVietnamPro', fontSize: 16.0),
                      decoration: InputDecoration(
                        hintText: 'Find friends...',
                        prefixIcon: Icon(Icons.search, color: ChunkyColors.outline),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 24.0),

          // Stats Quick Look (Horizontal Scroll)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildQuickStatCard(
                  title: 'Quest Points',
                  value: '2,450',
                  icon: Icons.stars,
                  cardColor: ChunkyColors.surfaceContainerLow,
                  borderColor: ChunkyColors.primary,
                ),
                SizedBox(width: 12.0),
                _buildQuickStatCard(
                  title: 'Active Streak',
                  value: '${widget.state.userStreak} Days',
                  icon: Icons.bolt,
                  cardColor: ChunkyColors.primaryFixedDim.withOpacity(0.4),
                  borderColor: ChunkyColors.primary,
                ),
                SizedBox(width: 12.0),
                _buildQuickStatCard(
                  title: 'Badges',
                  value: '8',
                  icon: Icons.emoji_events,
                  cardColor: ChunkyColors.surfaceContainerLow,
                  borderColor: ChunkyColors.primary,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),

          // Leaderboard
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Weekly Leaderboard',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 20.0,
                  color: ChunkyColors.onSurface,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.bold,
                  color: ChunkyColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          ChunkyCard(
            backgroundColor: ChunkyColors.surfaceContainerLow,
            borderColor: ChunkyColors.outlineVariant,
            shadowColor: ChunkyColors.outlineVariant,
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                _buildLeaderboardRow(
                  rank: 1,
                  name: 'Alex Rivera',
                  points: '12,400 pts',
                  streak: 42,
                  avatarUrl: friends[0].avatarUrl,
                  rankColor: ChunkyColors.onSurface,
                ),
                SizedBox(height: 12.0),
                _buildLeaderboardRow(
                  rank: 2,
                  name: 'Jordan Lee',
                  points: '10,150 pts',
                  streak: 28,
                  avatarUrl: friends[2].avatarUrl,
                  rankColor: ChunkyColors.surfaceContainerHighest,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),

          // Friends Activities
          Text(
            'Recent Achievements',
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w800,
              fontSize: 20.0,
              color: ChunkyColors.onSurface,
            ),
          ),
          SizedBox(height: 12.0),

          // Sarah Chen achievement card
          _buildActivityCard(
            friend: friends[1],
            badgeTitle: 'Early Bird Lv. 3',
            badgeCategory: 'New Badge',
            badgeIcon: Icons.wb_sunny,
            badgeColor: ChunkyColors.primary,
          ),
          SizedBox(height: 16.0),

          // Mika achievement card
          _buildActivityCard(
            friend: friends[3],
            badgeTitle: '30 Day Streak!',
            badgeCategory: 'Milestone',
            badgeIcon: Icons.local_fire_department,
            badgeColor: ChunkyColors.primary,
            isStreakMilestone: true,
          ),
          SizedBox(height: 32.0),
        ],
      ),
    );
  }

  Widget _buildQuickStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color cardColor,
    required Color borderColor,
  }) {
    return ChunkyCard(
      backgroundColor: cardColor,
      borderColor: borderColor,
      shadowColor: borderColor,
      shadowHeight: 4,
      child: SizedBox(
        width: 140.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: borderColor, size: 24.0),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: borderColor,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                fontSize: 24.0,
                color: ChunkyColors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardRow({
    required int rank,
    required String name,
    required String points,
    required int streak,
    required String avatarUrl,
    required Color rankColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: ChunkyColors.onSurface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: ChunkyColors.surfaceContainerHighest,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: ChunkyColors.surfaceContainerHighest,
            offset: Offset(0, 4),
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 32.0,
            height: 32.0,
            decoration: BoxDecoration(
              color: rankColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$rank',
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.bold,
                  color: ChunkyColors.surface,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: ChunkyColors.surfaceContainerHighest, width: 2.0),
              image: DecorationImage(
                image: NetworkImage(avatarUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: ChunkyColors.surface,
                  ),
                ),
                Text(
                  points,
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    color: ChunkyColors.surfaceContainerHigh,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.local_fire_department, color: ChunkyColors.primary, size: 20.0),
              SizedBox(width: 4.0),
              Text(
                '$streak',
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: ChunkyColors.surface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard({
    required Friend friend,
    required String badgeTitle,
    required String badgeCategory,
    required IconData badgeIcon,
    required Color badgeColor,
    bool isStreakMilestone = false,
  }) {
    final hasReacted = _reactedFriends.contains(friend.id);

    return ChunkyCard(
      borderColor: ChunkyColors.surfaceContainerHighest,
      shadowColor: ChunkyColors.surfaceContainerHighest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: badgeColor, width: 2.0),
                  image: DecorationImage(
                    image: NetworkImage(friend.avatarUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontSize: 14.0,
                          color: ChunkyColors.onSurface,
                        ),
                        children: [
                          TextSpan(
                            text: friend.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: isStreakMilestone ? ' hit a ' : ' earned the ',
                          ),
                          TextSpan(
                            text: isStreakMilestone ? '30 Day Streak' : 'Early Bird',
                            style: TextStyle(fontWeight: FontWeight.bold, color: badgeColor),
                          ),
                          const TextSpan(text: '!'),
                        ],
                      ),
                    ),
                    Text(
                      friend.recentActivityTime,
                      style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        color: ChunkyColors.outline,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),

          // Detail box
          if (!isStreakMilestone)
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: ChunkyColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: ChunkyColors.surfaceContainerHighest),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: badgeColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Icon(badgeIcon, color: badgeColor),
                  ),
                  SizedBox(width: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        badgeCategory.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0,
                          color: badgeColor,
                          letterSpacing: 1.0,
                        ),
                      ),
                      Text(
                        badgeTitle,
                        style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          SizedBox(height: 12.0),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _triggerCheerEffect(friend.id),
                  child: Container(
                    height: 44.0,
                    decoration: BoxDecoration(
                      color: hasReacted ? ChunkyColors.primaryFixedDim.withOpacity(0.3) : ChunkyColors.onSurface,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: hasReacted ? ChunkyColors.primary : ChunkyColors.surfaceContainerHighest,
                        width: 2.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: hasReacted ? Colors.transparent : ChunkyColors.surfaceContainerHighest,
                          offset: Offset(0, hasReacted ? 0 : 4),
                          blurRadius: 0,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              hasReacted ? Icons.check_circle : Icons.local_fire_department,
                              color: hasReacted ? ChunkyColors.primary : ChunkyColors.primary,
                              size: 20.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              hasReacted ? 'Sent!' : 'Cheer',
                              style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.bold,
                                color: hasReacted ? ChunkyColors.primary : ChunkyColors.surface,
                              ),
                            ),
                          ],
                        ),
                        if (hasReacted)
                          const Positioned(
                            top: -10,
                            child: Text(
                              '🎉',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.0),
              Container(
                width: 48.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: ChunkyColors.onSurface,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: ChunkyColors.surfaceContainerHighest,
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ChunkyColors.surfaceContainerHighest,
                      offset: Offset(0, 4),
                      blurRadius: 0,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    isStreakMilestone ? '🔥' : '👏',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



