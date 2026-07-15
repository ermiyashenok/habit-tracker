import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/chunky_colors.dart';
import '../widgets/chunky_card.dart';
import '../widgets/avatar_helper.dart';
import '../providers/app_state.dart';
import '../models/friend.dart';
import 'user_profile_screen.dart';

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
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;
  bool _showSearch = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchUsers(String query) async {
    if (query.trim().isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    setState(() => _isSearching = true);

    try {
      final currentUid = FirebaseAuth.instance.currentUser?.uid;
      final q = query.trim().toLowerCase();
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('searchTerms', arrayContains: q)
          .limit(20)
          .get();

      final results = snapshot.docs
          .where((doc) => doc.id != currentUid) // exclude self
          .map((doc) {
            final data = doc.data();
            return {
              'uid': doc.id,
              'displayName': data['displayName'] ?? 'Adventurer',
              'photoUrl': data['photoUrl'] ?? '',
              'xp': data['xp'] ?? 0,
              'level': data['level'] ?? 1,
              'streak': data['streak'] ?? 0,
            };
          })
          .toList();

      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      setState(() => _isSearching = false);
    }
  }

  void _openUserProfile(Map<String, dynamic> userData) {
    final uid = userData['uid'] as String;
    final isFriend = widget.state.friends.any((f) => f.id == uid);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => UserProfileScreen(
          uid: uid,
          displayName: userData['displayName'] ?? 'Adventurer',
          photoUrl: userData['photoUrl'],
          isFriend: isFriend,
          onAddFriend: () {
            widget.state.addFriend(Friend(
              id: uid,
              name: userData['displayName'] ?? 'Adventurer',
              avatarUrl: userData['photoUrl'] ?? '',
              xp: userData['xp'] ?? 0,
              streak: userData['streak'] ?? 0,
            ));
          },
          onRemoveFriend: () {
            widget.state.removeFriend(uid);
          },
        ),
      ),
    );
  }

  Widget _buildAvatar(String? photoUrl, {double size = 48, String? name}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ChunkyColors.primary.withOpacity(0.5), width: 2),
      ),
      child: buildAvatarWidget(photoUrl, size: size - 4, fallbackLetter: name),
    );
  }

  @override
  Widget build(BuildContext context) {
    final friends = widget.state.friends;
    final currentUser = FirebaseAuth.instance.currentUser;
    final myXp = widget.state.userXp;
    final myStreak = widget.state.userStreak;
    final myBadges = widget.state.achievements.where((a) => a.isUnlocked).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── My Stats ──────────────────────────────────────────────
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildStatCard('Quest Points', '$myXp', Icons.stars, ChunkyColors.primary),
                const SizedBox(width: 12),
                _buildStatCard('Streak', '$myStreak Days', Icons.bolt, ChunkyColors.secondary),
                const SizedBox(width: 12),
                _buildStatCard('Badges', '$myBadges', Icons.emoji_events, const Color(0xFFFF9800)),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── Search Toggle ─────────────────────────────────────────
          if (!_showSearch)
            ChunkyCard(
              borderColor: ChunkyColors.primary.withOpacity(0.4),
              shadowColor: ChunkyColors.primary.withOpacity(0.25),
              shadowHeight: 4,
              onTap: () => setState(() => _showSearch = true),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_search, color: ChunkyColors.primary, size: 24),
                  const SizedBox(width: 10),
                  Text(
                    'Search for Friends',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: ChunkyColors.primary,
                    ),
                  ),
                ],
              ),
            )
          else ...[
            // Search box
            Container(
              decoration: BoxDecoration(
                color: ChunkyColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ChunkyColors.primary.withOpacity(0.5), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: ChunkyColors.primary.withOpacity(0.2),
                    offset: const Offset(0, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                style: TextStyle(fontFamily: 'BeVietnamPro', fontSize: 16, color: ChunkyColors.onSurface),
                onChanged: _searchUsers,
                decoration: InputDecoration(
                  hintText: 'Search by display name...',
                  hintStyle: TextStyle(fontFamily: 'BeVietnamPro', color: ChunkyColors.outline),
                  prefixIcon: Icon(Icons.search, color: ChunkyColors.primary),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close, color: ChunkyColors.outline),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _showSearch = false;
                        _searchResults = [];
                      });
                    },
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Search results
            if (_isSearching)
              const Center(child: CircularProgressIndicator())
            else if (_searchController.text.isNotEmpty && _searchResults.isEmpty)
              ChunkyCard(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Icon(Icons.search_off, size: 48, color: ChunkyColors.outline),
                        const SizedBox(height: 8),
                        Text(
                          'No users found for "${_searchController.text}"',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'BeVietnamPro', color: ChunkyColors.outline),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _searchResults.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final user = _searchResults[index];
                  final uid = user['uid'] as String;
                  final alreadyFriend = widget.state.friends.any((f) => f.id == uid);
                  return ChunkyCard(
                    onTap: () => _openUserProfile(user),
                    child: Row(
                      children: [
                        _buildAvatar(user['photoUrl'], size: 46, name: user['displayName']),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user['displayName'],
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: ChunkyColors.onSurface,
                                ),
                              ),
                              Text(
                                'Lv.${user['level']}  •  ${user['xp']} XP  •  🔥 ${user['streak']} days',
                                style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontSize: 12,
                                  color: ChunkyColors.outline,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (alreadyFriend)
                          Icon(Icons.check_circle, color: ChunkyColors.primary, size: 28)
                        else
                          IconButton(
                            icon: Icon(Icons.person_add, color: ChunkyColors.primary),
                            onPressed: () {
                              widget.state.addFriend(Friend(
                                id: uid,
                                name: user['displayName'] ?? 'Adventurer',
                                avatarUrl: user['photoUrl'] ?? '',
                                xp: user['xp'] ?? 0,
                                streak: user['streak'] ?? 0,
                              ));
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${user['displayName']} added!'),
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
          ],

          const SizedBox(height: 24),

          // ── Leaderboard ───────────────────────────────────────────
          if (friends.isNotEmpty) ...[
            Text(
              'LEADERBOARD',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1.5,
                color: ChunkyColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            ChunkyCard(
              backgroundColor: ChunkyColors.surfaceContainerLow,
              borderColor: ChunkyColors.outlineVariant,
              shadowColor: ChunkyColors.outlineVariant,
              padding: const EdgeInsets.all(12),
              child: Column(
                children: () {
                  // Build leaderboard: me + friends sorted by XP
                  final entries = <Map<String, dynamic>>[
                    {
                      'uid': currentUser?.uid ?? '',
                      'name': (currentUser?.displayName?.isNotEmpty == true)
                          ? currentUser!.displayName!
                          : 'You',
                      'photoUrl': currentUser?.photoURL ?? '',
                      'xp': myXp,
                      'streak': myStreak,
                      'isMe': true,
                    },
                    ...friends.map((f) => {
                      'uid': f.id,
                      'name': f.name,
                      'photoUrl': f.avatarUrl,
                      'xp': f.xp,
                      'streak': f.streak,
                      'isMe': false,
                    }),
                  ]..sort((a, b) => (b['xp'] as int).compareTo(a['xp'] as int));

                  return entries.asMap().entries.map((e) {
                    final rank = e.key + 1;
                    final entry = e.value;
                    final isMe = entry['isMe'] as bool;
                    final rankColors = [const Color(0xFFFFD700), const Color(0xFFC0C0C0), const Color(0xFFCD7F32)];
                    final rankColor = rank <= 3 ? rankColors[rank - 1] : ChunkyColors.outline;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: isMe ? null : () => _openUserProfile(entry),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isMe ? ChunkyColors.primary.withOpacity(0.1) : ChunkyColors.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isMe ? ChunkyColors.primary : ChunkyColors.outlineVariant,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 30, height: 30,
                                decoration: BoxDecoration(color: rankColor, shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    '$rank',
                                    style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.bold,
                                      color: isMe ? ChunkyColors.background : Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              _buildAvatar(entry['photoUrl'] as String?, size: 38, name: entry['name'] as String?),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isMe ? 'You' : (entry['name'] as String),
                                      style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: isMe ? ChunkyColors.primary : ChunkyColors.onSurface,
                                      ),
                                    ),
                                    Text(
                                      '${entry['xp']} XP',
                                      style: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontSize: 12,
                                        color: ChunkyColors.outline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.local_fire_department, color: ChunkyColors.primary, size: 18),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${entry['streak']}',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: ChunkyColors.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList();
                }(),
              ),
            ),
            const SizedBox(height: 24),

            // Friends list
            Text(
              'MY FRIENDS',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1.5,
                color: ChunkyColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: friends.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final f = friends[index];
                return ChunkyCard(
                  onTap: () => _openUserProfile({
                    'uid': f.id,
                    'displayName': f.name,
                    'photoUrl': f.avatarUrl,
                    'xp': f.xp,
                    'level': 1,
                    'streak': f.streak,
                  }),
                  child: Row(
                    children: [
                      _buildAvatar(f.avatarUrl.isNotEmpty ? f.avatarUrl : null, size: 46, name: f.name),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              f.name,
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: ChunkyColors.onSurface,
                              ),
                            ),
                            Text(
                              '${f.xp} XP  •  🔥 ${f.streak} day streak',
                              style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontSize: 12,
                                color: ChunkyColors.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.person_remove_outlined, color: ChunkyColors.outline),
                        onPressed: () {
                          widget.state.removeFriend(f.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${f.name} removed.'),
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
          ] else if (!_showSearch) ...[
            // Empty state
            ChunkyCard(
              borderColor: ChunkyColors.outlineVariant,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: ChunkyColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.group_outlined, size: 40, color: ChunkyColors.primary),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No friends yet',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: ChunkyColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Search for adventurers and add\nthem to your crew!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontSize: 14,
                        color: ChunkyColors.outline,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => setState(() => _showSearch = true),
                      icon: const Icon(Icons.person_search),
                      label: const Text('Find Friends'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ChunkyColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return ChunkyCard(
      backgroundColor: color.withOpacity(0.08),
      borderColor: color.withOpacity(0.4),
      shadowColor: color.withOpacity(0.2),
      shadowHeight: 4,
      child: SizedBox(
        width: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                fontSize: 22,
                color: ChunkyColors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
