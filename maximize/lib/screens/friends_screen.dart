import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/chunky_colors.dart';
import '../widgets/chunky_card.dart';
import '../providers/app_state.dart';
import '../models/friend.dart';

class LeaderboardEntry {
  final String name;
  final int points;
  final int streak;
  final String avatarUrl;
  final bool isCurrentUser;

  LeaderboardEntry({
    required this.name,
    required this.points,
    required this.streak,
    required this.avatarUrl,
    required this.isCurrentUser,
  });
}

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

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {});
  }

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
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final friends = widget.state.friends;
    final potentialFriends = widget.state.potentialFriends;

    final filteredFriends = query.isEmpty 
        ? friends 
        : friends.where((f) => f.name.toLowerCase().contains(query)).toList();

    final filteredPotential = query.isEmpty
        ? <Friend>[]
        : potentialFriends.where((p) => p.name.toLowerCase().contains(query)).toList();

    // Stats
    final unlockedBadgesCount = widget.state.achievements.where((a) => a.isUnlocked).length;

    // Leaderboard
    final List<LeaderboardEntry> leaderboard = [];
    final currentUser = FirebaseAuth.instance.currentUser;
    leaderboard.add(LeaderboardEntry(
      name: (currentUser?.displayName != null && currentUser!.displayName!.isNotEmpty) ? currentUser.displayName! : 'You (Adventurer)',
      points: widget.state.userXp,
      streak: widget.state.userStreak,
      avatarUrl: currentUser?.photoURL ?? 'https://lh3.googleusercontent.com/aida-public/AB6AXuAp8r6lTIfOqEwWVY-zEsgIVc-QfRbKZefgUrBxharFsU5GzUWM50Bu7gC8OEwZc15CbA4KvfUxPmwddwGd0kI7VoiA-ubEu83Z__7RnXCYoiJnZXH6X6_sTVsV0ud5_UBclZPJ1caZZyZiXiDd_GAwKhQzSHaUqP9Ge8V1Yc1TR4j9LZjPZE89-XEpBd9ZYYXnrfbmaSMEULE4O2MCU4USGR_zR8sAlcr6xTcwtFyXxsN29zHPladcLkzwLNlSe88xIRH8HwH50VaP',
      isCurrentUser: true,
    ));
    for (var f in friends) {
      leaderboard.add(LeaderboardEntry(
        name: f.name,
        points: f.points,
        streak: f.streak,
        avatarUrl: f.avatarUrl,
        isCurrentUser: false,
      ));
    }
    leaderboard.sort((a, b) => b.points.compareTo(a.points));

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
                        suffixIcon: query.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () => _searchController.clear(),
                              )
                            : null,
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

          if (query.isNotEmpty) ...[
            // Search Mode Results
            Text(
              'MY FRIENDS',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                letterSpacing: 1.5,
                color: ChunkyColors.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 12.0),
            if (filteredFriends.isEmpty)
              ChunkyCard(
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'No friends found matching your search.',
                      style: TextStyle(fontFamily: 'BeVietnamPro', color: Colors.grey),
                    ),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredFriends.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.0),
                itemBuilder: (context, index) {
                  final f = filteredFriends[index];
                  return ChunkyCard(
                    child: Row(
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: ChunkyColors.surfaceContainerHighest, width: 2.0),
                            image: DecorationImage(
                              image: NetworkImage(f.avatarUrl),
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
                                f.name,
                                style: const TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                              Text(
                                '${f.points} XP • Streak: ${f.streak} days',
                                style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  color: ChunkyColors.outline,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.person_remove, color: ChunkyColors.errorRed),
                          onPressed: () {
                            widget.state.removeFriend(f.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${f.name} removed from friends.'),
                                backgroundColor: ChunkyColors.errorRed,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            SizedBox(height: 24.0),
            Text(
              'SEARCH DIRECTORY',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                letterSpacing: 1.5,
                color: ChunkyColors.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 12.0),
            if (filteredPotential.isEmpty)
              ChunkyCard(
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'No new users found.',
                      style: TextStyle(fontFamily: 'BeVietnamPro', color: Colors.grey),
                    ),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredPotential.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.0),
                itemBuilder: (context, index) {
                  final f = filteredPotential[index];
                  return ChunkyCard(
                    child: Row(
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: ChunkyColors.surfaceContainerHighest, width: 2.0),
                            image: DecorationImage(
                              image: NetworkImage(f.avatarUrl),
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
                                f.name,
                                style: const TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                              Text(
                                '${f.points} XP • Streak: ${f.streak} days',
                                style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  color: ChunkyColors.outline,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.person_add, color: ChunkyColors.primary),
                          onPressed: () {
                            widget.state.addFriend(f);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${f.name} added to friends!'),
                                backgroundColor: ChunkyColors.primary,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
          ] else ...[
            // Default Mode
            // Stats Quick Look (Horizontal Scroll)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildQuickStatCard(
                    title: 'Quest Points',
                    value: '${widget.state.userXp}',
                    icon: Icons.stars,
                    cardColor: ChunkyColors.surfaceContainerLow,
                    borderColor: ChunkyColors.primary,
                  ),
                  SizedBox(width: 12.0),
                  _buildQuickStatCard(
                    title: 'Active Streak',
                    value: '${widget.state.userStreak} Days',
                    icon: Icons.bolt,
                    cardColor: ChunkyColors.primaryFixedDim.withOpacity(0.15),
                    borderColor: ChunkyColors.primary,
                  ),
                  SizedBox(width: 12.0),
                  _buildQuickStatCard(
                    title: 'Badges Unlocked',
                    value: '$unlockedBadgesCount',
                    icon: Icons.emoji_events,
                    cardColor: ChunkyColors.surfaceContainerLow,
                    borderColor: ChunkyColors.primary,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),

            // Leaderboard Title
            Text(
              'Weekly Leaderboard',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                fontSize: 20.0,
                color: ChunkyColors.onSurface,
              ),
            ),
            SizedBox(height: 12.0),
            ChunkyCard(
              backgroundColor: ChunkyColors.surfaceContainerLow,
              borderColor: ChunkyColors.outlineVariant,
              shadowColor: ChunkyColors.outlineVariant,
              padding: const EdgeInsets.all(12.0),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: leaderboard.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12.0),
                itemBuilder: (context, index) {
                  final entry = leaderboard[index];
                  return _buildLeaderboardRow(
                    rank: index + 1,
                    name: entry.name,
                    points: '${entry.points} pts',
                    streak: entry.streak,
                    avatarUrl: entry.avatarUrl,
                    rankColor: index == 0 
                        ? const Color(0xFFFFD700) 
                        : (index == 1 ? const Color(0xFFC0C0C0) : (index == 2 ? const Color(0xFFCD7F32) : ChunkyColors.outline)),
                    isCurrentUser: entry.isCurrentUser,
                  );
                },
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

            if (friends.isEmpty)
              ChunkyCard(
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text(
                      'Search and add friends to see their achievements here!',
                      style: TextStyle(fontFamily: 'BeVietnamPro', color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            else
              Builder(builder: (context) {
                // Find friends with achievements/streaks
                final achievementFriends = friends.where((f) => f.badgeEarned != null).toList();
                final streakFriends = friends.where((f) => f.streak >= 30).toList();

                if (achievementFriends.isEmpty && streakFriends.isEmpty) {
                  // Fall back to showing latest actions of any friends
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: friends.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16.0),
                    itemBuilder: (context, index) {
                      final f = friends[index];
                      return _buildActivityCard(
                        friend: f,
                        badgeTitle: f.recentActivity,
                        badgeCategory: 'Activity',
                        badgeIcon: Icons.check_circle_outline,
                        badgeColor: ChunkyColors.primary,
                        isStreakMilestone: false,
                      );
                    },
                  );
                }

                // Combine them
                final List<Widget> items = [];
                for (var f in achievementFriends) {
                  items.add(_buildActivityCard(
                    friend: f,
                    badgeTitle: f.badgeEarned ?? 'Achievement',
                    badgeCategory: f.badgeCategory ?? 'Badge',
                    badgeIcon: Icons.wb_sunny,
                    badgeColor: ChunkyColors.primary,
                  ));
                }
                for (var f in streakFriends) {
                  items.add(_buildActivityCard(
                    friend: f,
                    badgeTitle: '${f.streak} Day Streak!',
                    badgeCategory: 'Milestone',
                    badgeIcon: Icons.local_fire_department,
                    badgeColor: ChunkyColors.primary,
                    isStreakMilestone: true,
                  ));
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16.0),
                  itemBuilder: (context, index) => items[index],
                );
              }),
            SizedBox(height: 32.0),
          ],
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
                fontSize: 13.0,
                color: borderColor,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                fontSize: 22.0,
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
    bool isCurrentUser = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isCurrentUser ? ChunkyColors.primaryContainer : ChunkyColors.onSurface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: isCurrentUser ? ChunkyColors.primary : ChunkyColors.surfaceContainerHighest,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isCurrentUser ? ChunkyColors.primary.withOpacity(0.3) : ChunkyColors.surfaceContainerHighest,
            offset: const Offset(0, 4),
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
                  color: isCurrentUser ? ChunkyColors.onSurface : ChunkyColors.surface,
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
                    color: isCurrentUser ? ChunkyColors.onSurface : ChunkyColors.surface,
                  ),
                ),
                Text(
                  points,
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    color: isCurrentUser ? ChunkyColors.onSurfaceVariant : ChunkyColors.surfaceContainerHigh,
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
                  color: isCurrentUser ? ChunkyColors.onSurface : ChunkyColors.surface,
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
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: isStreakMilestone ? ' hit a ' : ' ',
                          ),
                          TextSpan(
                            text: isStreakMilestone ? badgeTitle : friend.recentActivity,
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
          if (!isStreakMilestone && friend.badgeEarned != null)
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
                        style: const TextStyle(
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
                              color: ChunkyColors.primary,
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
                      offset: const Offset(0, 4),
                      blurRadius: 0,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    isStreakMilestone ? '🔥' : '👏',
                    style: const TextStyle(fontSize: 20.0),
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
