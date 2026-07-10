import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/chunky_colors.dart';
import '../widgets/chunky_card.dart';
import '../widgets/chunky_button.dart';
import '../providers/app_state.dart';
import 'friends_screen.dart';
import 'badges_screen.dart';

class ProfileScreen extends StatelessWidget {
  final AppState state;

  const ProfileScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Profile Header
          ChunkyCard(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(color: ChunkyColors.primary, width: 3.0),
                    boxShadow: [
                      BoxShadow(
                        color: ChunkyColors.primary.withValues(alpha: 0.3),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.local_fire_department,
                      color: ChunkyColors.primary,
                      size: 40.0,
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Adventurer',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w900,
                          fontSize: 24.0,
                          color: ChunkyColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Level ${state.level} Habit Master',
                        style: const TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: ChunkyColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),


          _buildSettingsSection('SETTINGS'),
          _buildMenuCard(
            context,
            title: 'Push Notifications',
            icon: Icons.notifications_active,
            color: ChunkyColors.onSurface,
            onTap: () {},
          ),
          _buildMenuCard(
            context,
            title: 'Dark Mode Theme',
            icon: Icons.dark_mode,
            color: ChunkyColors.onSurface,
            onTap: () {},
          ),
          _buildMenuCard(
            context,
            title: 'Backup & Sync',
            icon: Icons.cloud_sync,
            color: ChunkyColors.onSurface,
            onTap: () {},
          ),

          const SizedBox(height: 32.0),
          ChunkyButton(
            backgroundColor: ChunkyColors.surfaceContainerHigh,
            borderColor: ChunkyColors.errorRed,
            shadowColor: ChunkyColors.errorRed,
            onTap: () {
              // Usually logs out the user
            },
            child: const Center(
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
          const SizedBox(height: 32.0),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0, top: 8.0),
      child: Text(
        title,
        style: const TextStyle(
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
                color: color.withValues(alpha: 0.15),
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
            const Icon(Icons.chevron_right, color: ChunkyColors.outline, size: 28.0),
          ],
        ),
      ),
    );
  }
}
