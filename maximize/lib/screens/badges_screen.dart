import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/chunky_colors.dart';
import '../widgets/chunky_card.dart';
import '../widgets/chunky_button.dart';
import '../providers/app_state.dart';
import '../models/achievement.dart';

class BadgesScreen extends StatefulWidget {
  final AppState state;

  const BadgesScreen({
    super.key,
    required this.state,
  });

  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  Achievement? _selectedBadge;

  @override
  Widget build(BuildContext context) {
    final achievements = widget.state.achievements;
    final unlockedCount = achievements.where((a) => a.isUnlocked).length;
    final totalCount = achievements.length;

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title & Counter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Badges',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w800,
                      fontSize: 24.0,
                      color: ChunkyColors.onSurface,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: ChunkyColors.primaryFixedDim.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: ChunkyColors.primary, width: 2.0),
                    ),
                    child: Text(
                      '$unlockedCount / $totalCount UNLOCKED',
                      style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                        color: ChunkyColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.0),



              // Badges Grid
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                alignment: WrapAlignment.start,
                children: achievements.map((ach) {
                  return SizedBox(
                    width: (MediaQuery.of(context).size.width - 64) / 2, // Approximate width for 2 items per row with padding
                    height: 180, // Fixed height to prevent stretching
                    child: _buildBadgeCell(ach),
                  );
                }).toList(),
              ),
              SizedBox(height: 120.0), // Padding for bottom nav bar
            ],
          ),
        ),

        // Popover Details Modal
        if (_selectedBadge != null) _buildPopoverModal(),
      ],
    );
  }

  Widget _buildBadgeCell(Achievement ach) {
    final Color badgeBg = ach.isUnlocked ? _getCategoryBgColor(ach.categoryColor) : ChunkyColors.surfaceContainerLow;
    final Color badgeIconColor = ach.isUnlocked ? _getCategoryIconColor(ach.categoryColor) : ChunkyColors.outlineVariant;
    final Color borderColor = ach.isUnlocked ? ChunkyColors.darkBorder : ChunkyColors.surfaceContainerHighest;
    final Color shadowColor = ach.isUnlocked ? ChunkyColors.darkBorder : ChunkyColors.surfaceContainerHighest;

    return ChunkyCard(
      backgroundColor: ChunkyColors.surfaceContainerHigh,
      borderColor: borderColor,
      shadowColor: shadowColor,
      shadowHeight: 4,
      onTap: () {
        setState(() {
          _selectedBadge = ach;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Badge Circle Representation
          Stack(
            children: [
              Container(
                width: 72.0,
                height: 72.0,
                decoration: BoxDecoration(
                  color: badgeBg,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ChunkyColors.darkBorder,
                    width: 2.0,
                  ),
                ),
                child: Center(
                  child: Icon(
                    _getIconData(ach.icon),
                    color: badgeIconColor,
                    size: 36.0,
                  ),
                ),
              ),
              if (!ach.isUnlocked)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: ChunkyColors.onSurface,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
                    ),
                    child: Icon(
                      Icons.lock,
                      size: 14.0,
                      color: ChunkyColors.outline,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.0),
          Text(
            ach.title,
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              color: ach.isUnlocked ? ChunkyColors.onSurface : ChunkyColors.outline,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.0),
          Text(
            ach.isUnlocked ? 'Unlocked' : 'Locked',
            style: TextStyle(
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w500,
              fontSize: 11.0,
              color: ach.isUnlocked ? ChunkyColors.primary : ChunkyColors.outlineVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopoverModal() {
    final ach = _selectedBadge!;
    final Color badgeBg = ach.isUnlocked ? _getCategoryBgColor(ach.categoryColor) : ChunkyColors.surfaceContainerLow;
    final Color badgeIconColor = ach.isUnlocked ? _getCategoryIconColor(ach.categoryColor) : ChunkyColors.outlineVariant;

    return Container(
      color: ChunkyColors.background.withOpacity(0.5),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ChunkyCard(
          shadowHeight: 8,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Large Badge Icon
              Container(
                width: 96.0,
                height: 96.0,
                decoration: BoxDecoration(
                  color: badgeBg,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ChunkyColors.darkBorder,
                    width: 3.0,
                  ),
                ),
                child: Center(
                  child: Icon(
                    _getIconData(ach.icon),
                    color: badgeIconColor,
                    size: 48.0,
                  ),
                ),
              ),
              SizedBox(height: 20.0),

              // Title
              Text(
                ach.title,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 22.0,
                  color: ChunkyColors.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),

              // Description
              Text(
                ach.description,
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontSize: 14.0,
                  color: ChunkyColors.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),

              // Progress or unlocked status
              if (ach.isUnlocked)
                Text(
                  '🎉 UNLOCKED! Keep it up.',
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.bold,
                    color: ChunkyColors.primary,
                  ),
                )
              else
                Column(
                  children: [
                    Text(
                      'PROGRESS: ${ach.progress}/${ach.threshold}',
                      style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.bold,
                        color: ChunkyColors.primary,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: LinearProgressIndicator(
                        value: ach.progress / ach.threshold,
                        minHeight: 8.0,
                        backgroundColor: ChunkyColors.surfaceContainerLow,
                        color: ChunkyColors.onSurface,
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 24.0),

              // Awesome Button
              ChunkyButton(
                onTap: () {
                  setState(() {
                    _selectedBadge = null;
                  });
                },
                child: Text(
                  'AWESOME!',
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.bold,
                    color: ChunkyColors.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryBgColor(String col) {
    switch (col) {
      case 'primary':
        return ChunkyColors.primaryFixedDim.withOpacity(0.4);
      case 'secondary':
        return ChunkyColors.surfaceContainerLow;
      case 'tertiary':
        return ChunkyColors.surfaceContainerLow;
      case 'purple':
        return ChunkyColors.primary.withOpacity(0.2);
      default:
        return ChunkyColors.surfaceContainerLow;
    }
  }

  Color _getCategoryIconColor(String col) {
    switch (col) {
      case 'primary':
        return ChunkyColors.primary;
      case 'secondary':
        return ChunkyColors.primary;
      case 'tertiary':
        return ChunkyColors.primary;
      case 'purple':
        return ChunkyColors.primary;
      default:
        return ChunkyColors.outline;
    }
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'local_fire_department':
        return Icons.local_fire_department;
      case 'dark_mode':
        return Icons.dark_mode;
      case 'group':
        return Icons.group;
      case 'wb_sunny':
        return Icons.wb_sunny;
      case 'star':
        return Icons.star;
      case 'trophy':
        return Icons.emoji_events;
      case 'military_tech':
        return Icons.military_tech;
      default:
        return Icons.workspace_premium;
    }
  }
}




