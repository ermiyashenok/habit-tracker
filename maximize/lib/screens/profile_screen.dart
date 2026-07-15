import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import '../widgets/chunky_colors.dart';
import '../widgets/chunky_card.dart';
import '../widgets/chunky_button.dart';
import '../widgets/avatar_helper.dart';
import '../providers/app_state.dart';
import 'package:flutter/foundation.dart';
import '../services/notification_service.dart';
import 'login_screen.dart';


class ProfileScreen extends StatefulWidget {
  final AppState state;

  const ProfileScreen({
    super.key,
    required this.state,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _bio;

  @override
  void initState() {
    super.initState();
    _loadBio();
  }

  Future<void> _loadBio() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists && mounted) {
        setState(() {
          _bio = (doc.data() as Map<String, dynamic>)['bio'] as String?;
        });
      }
    } catch (_) {}
  }

  Future<void> _showEditProfileSheet() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final nameController = TextEditingController(text: user.displayName ?? '');
    final photoController = TextEditingController(text: user.photoURL ?? '');
    final bioController = TextEditingController(text: _bio ?? '');
    String? currentPhotoUrl = user.photoURL;
    bool isSaving = false;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              decoration: BoxDecoration(
                color: ChunkyColors.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                border: Border.all(color: ChunkyColors.outlineVariant),
              ),
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: ChunkyColors.outline.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Text(
                      'Edit Profile',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        color: ChunkyColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Image selector & Avatar Preview
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: ChunkyColors.outlineVariant, width: 2),
                            ),
                            child: buildAvatarWidget(currentPhotoUrl, size: 86, fallbackLetter: nameController.text),
                          ),
                          const SizedBox(height: 8),
                          TextButton.icon(
                            onPressed: () async {
                              try {
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  maxWidth: 200,
                                  maxHeight: 200,
                                  imageQuality: 70,
                                );
                                if (pickedFile != null) {
                                  final bytes = await pickedFile.readAsBytes();
                                  final base64Str = 'data:image/jpeg;base64,' + base64Encode(bytes);
                                  setSheetState(() {
                                    currentPhotoUrl = base64Str;
                                    photoController.text = base64Str;
                                  });
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error picking image: $e'),
                                      backgroundColor: ChunkyColors.errorRed,
                                    ),
                                  );
                                }
                              }
                            },
                            icon: Icon(Icons.photo_library, color: ChunkyColors.primary, size: 18),
                            label: Text(
                              'Choose from Files',
                              style: GoogleFonts.plusJakartaSans(
                                color: ChunkyColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    _buildLabel('Display Name'),
                    const SizedBox(height: 8),
                    _buildEditField(nameController, 'Your adventurer name', Icons.person_outline),
                    const SizedBox(height: 16),

                    _buildLabel('Avatar URL'),
                    const SizedBox(height: 8),
                    _buildEditField(
                      photoController,
                      'https://...',
                      Icons.image_outlined,
                      onChanged: (val) {
                        setSheetState(() {
                          currentPhotoUrl = val.trim();
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    _buildLabel('Bio'),
                    const SizedBox(height: 8),
                    _buildEditField(bioController, 'Tell other adventurers about yourself...', Icons.edit_note, maxLines: 3),
                    const SizedBox(height: 28),

                    ChunkyButton(
                      backgroundColor: ChunkyColors.primary,
                      borderColor: ChunkyColors.primary,
                      shadowColor: ChunkyColors.primary.withOpacity(0.4),
                      onTap: isSaving ? null : () async {
                        setSheetState(() => isSaving = true);
                        try {
                          final newName = nameController.text.trim();
                          final newPhoto = photoController.text.trim();
                          final newBio = bioController.text.trim();

                          // Update Firebase Auth profile
                          await user.updateDisplayName(newName.isEmpty ? 'Adventurer' : newName);
                          if (newPhoto.isNotEmpty) {
                            await user.updatePhotoURL(newPhoto);
                          }

                          // Update public Firestore profile
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .set({
                            'displayName': newName.isEmpty ? 'Adventurer' : newName,
                            'photoUrl': newPhoto,
                            'bio': newBio,
                          }, SetOptions(merge: true));

                          // Reload user to get updated data
                          await FirebaseAuth.instance.currentUser?.reload();

                          if (context.mounted) {
                            Navigator.of(context).pop();
                            setState(() {
                              _bio = newBio;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Profile updated!'),
                                backgroundColor: ChunkyColors.primary,
                              ),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to update: $e'),
                                backgroundColor: ChunkyColors.errorRed,
                              ),
                            );
                          }
                        } finally {
                          setSheetState(() => isSaving = false);
                        }
                      },
                      child: Center(
                        child: isSaving
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : Text(
                                'SAVE CHANGES',
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    // Refresh display after sheet closes
    if (mounted) setState(() {});
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'BeVietnamPro',
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: ChunkyColors.outline,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildEditField(TextEditingController controller, String hint, IconData icon, {int maxLines = 1, ValueChanged<String>? onChanged}) {
    return Container(
      decoration: BoxDecoration(
        color: ChunkyColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ChunkyColors.outlineVariant),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        onChanged: onChanged,
        style: TextStyle(
          fontFamily: 'BeVietnamPro',
          fontSize: 15,
          color: ChunkyColors.onSurface,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontFamily: 'BeVietnamPro', color: ChunkyColors.outline),
          prefixIcon: Icon(icon, color: ChunkyColors.outline, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }


  String _getMonthName(int month) {
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    if (month >= 1 && month <= 12) return months[month - 1];
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = (user?.displayName?.isNotEmpty == true) ? user!.displayName! : 'Adventurer';
    final photoUrl = user?.photoURL;
    final creationTime = user?.metadata.creationTime;
    final joinedText = creationTime != null 
        ? 'Joined ${_getMonthName(creationTime.month)} ${creationTime.year}' 
        : 'Joined recently';

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Profile Header ────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        color: ChunkyColors.onSurface,
                      ),
                    ),
                    Text(
                      user?.email?.split('@').first ?? 'Adventurer',
                      style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontSize: 14.0,
                        color: ChunkyColors.outline,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 16, color: ChunkyColors.outline),
                        const SizedBox(width: 6),
                        Text(
                          joinedText,
                          style: TextStyle(fontFamily: 'BeVietnamPro', fontSize: 13, color: ChunkyColors.outline),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.group, size: 16, color: ChunkyColors.outline),
                        const SizedBox(width: 6),
                        Text(
                          '${widget.state.friends.length} Friends',
                          style: TextStyle(fontFamily: 'BeVietnamPro', fontSize: 13, color: ChunkyColors.outline),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _showEditProfileSheet,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ChunkyColors.outlineVariant, width: 2, style: BorderStyle.solid),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      buildAvatarWidget(photoUrl, size: 76, fallbackLetter: displayName),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit, color: Colors.white, size: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          Divider(color: ChunkyColors.outlineVariant, thickness: 1),
          const SizedBox(height: 24),

          // ── Statistics ─────────────────────────────────────────────
          Text(
            'Statistics',
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: ChunkyColors.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.2,
            children: [
              _buildDuolingoStatCard(
                icon: Icons.local_fire_department,
                iconColor: Colors.orange,
                value: '${widget.state.userStreak}',
                label: 'Day streak',
              ),
              _buildDuolingoStatCard(
                icon: Icons.flash_on,
                iconColor: Colors.amber,
                value: '${widget.state.userXp}',
                label: 'Total XP',
              ),
              _buildDuolingoStatCard(
                icon: Icons.emoji_events,
                iconColor: Colors.amber,
                value: '${widget.state.achievements.where((a) => a.isUnlocked).length}',
                label: 'Total Badges',
              ),
              _buildDuolingoStatCard(
                icon: Icons.shield,
                iconColor: Colors.brown.shade300,
                value: 'Lvl ${widget.state.level}',
                label: 'League',
              ),
            ],
          ),

          const SizedBox(height: 32),
          Divider(color: ChunkyColors.outlineVariant, thickness: 1),
          const SizedBox(height: 24),

          // ── Friends ─────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Friends',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: ChunkyColors.onSurface,
                ),
              ),
              IconButton(
                icon: Icon(Icons.settings, color: ChunkyColors.outline),
                onPressed: _showSettingsSheet,
              )
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: ChunkyColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ChunkyColors.outlineVariant, width: 2),
            ),
            child: widget.state.friends.isEmpty 
              ? Center(
                  child: Text(
                    'No friends yet.',
                    style: TextStyle(fontFamily: 'BeVietnamPro', color: ChunkyColors.outline),
                  )
                )
              : Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.state.friends.take(5).map((f) => 
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: buildAvatarWidget(f.avatarUrl, size: 40, fallbackLetter: f.name),
                      )
                    ).toList(),
                  ),
                ),
          ),
          
          const SizedBox(height: 120.0), // Padding for navbar
        ],
      ),
    );
  }

  void _showSettingsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: ChunkyColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          border: Border.all(color: ChunkyColors.outlineVariant),
        ),
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: ChunkyColors.outline.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Text(
              'Settings',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                color: ChunkyColors.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            _buildMenuCard(
              context,
              title: 'Edit Profile',
              icon: Icons.manage_accounts,
              color: ChunkyColors.primary,
              onTap: () {
                Navigator.pop(context);
                _showEditProfileSheet();
              },
            ),
            _buildMenuCard(
              context,
              title: 'Test Push Notification',
              icon: Icons.notifications_active,
              color: ChunkyColors.secondary,
              onTap: () async {
                Navigator.pop(context);
                if (kIsWeb) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Push notifications are not supported on Web in this demo.'),
                      backgroundColor: ChunkyColors.errorRed,
                    ),
                  );
                } else {
                  try {
                    await NotificationService().showTestNotification();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Test notification triggered!'),
                          backgroundColor: ChunkyColors.primary,
                        ),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to trigger notification: $e'),
                          backgroundColor: ChunkyColors.errorRed,
                        ),
                      );
                    }
                  }
                }
              },
            ),
            _buildMenuCard(
              context,
              title: widget.state.isLightMode ? 'Dark Mode Theme' : 'Light Mode Theme',
              icon: widget.state.isLightMode ? Icons.dark_mode : Icons.light_mode,
              color: ChunkyColors.onSurface,
              onTap: () {
                Navigator.pop(context);
                widget.state.toggleTheme();
              },
            ),
            _buildMenuCard(
              context,
              title: 'Remove All Data',
              icon: Icons.delete_forever,
              color: ChunkyColors.errorRed,
              onTap: () async {
                Navigator.pop(context);
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: ChunkyColors.surface,
                    title: Text(
                      'Delete Data?',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        color: ChunkyColors.onSurface,
                      ),
                    ),
                    content: Text(
                      'This will permanently delete all your quests, streaks, and progress. This action cannot be undone.',
                      style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        color: ChunkyColors.onSurfaceVariant,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Cancel', style: TextStyle(color: ChunkyColors.primary, fontWeight: FontWeight.bold)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Delete', style: TextStyle(color: ChunkyColors.errorRed, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await widget.state.clearAllData();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('All data has been wiped clean.'),
                        backgroundColor: ChunkyColors.errorRed,
                      ),
                    );
                  }
                }
              },
            ),
            const SizedBox(height: 16),
            ChunkyButton(
              backgroundColor: ChunkyColors.surfaceContainerHigh,
              borderColor: ChunkyColors.errorRed,
              shadowColor: ChunkyColors.errorRed,
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                if (!mounted) return;
                Navigator.of(context, rootNavigator: true).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Center(
                child: Text(
                  'LOG OUT',
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: ChunkyColors.errorRed,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDuolingoStatCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return ChunkyCard(
      backgroundColor: ChunkyColors.surface,
      borderColor: ChunkyColors.outlineVariant,
      shadowColor: ChunkyColors.outlineVariant.withOpacity(0.5),
      shadowHeight: 3,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: ChunkyColors.onSurface,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontSize: 12,
                    color: ChunkyColors.outline,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Getter for backward compat
  AppState get state => widget.state;

  Widget _buildSettingsSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0, top: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'BeVietnamPro',
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
          color: ChunkyColors.outline,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ChunkyCard(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(icon, color: color, size: 24.0),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: ChunkyColors.onSurface,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: ChunkyColors.outline, size: 28.0),
          ],
        ),
      ),
    );
  }
}
