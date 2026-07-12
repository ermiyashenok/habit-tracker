import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/chunky_colors.dart';
import '../widgets/chunky_card.dart';
import '../widgets/chunky_button.dart';
import '../widgets/weekly_progress_chart.dart';
import '../providers/app_state.dart';

class StatsScreen extends StatelessWidget {
  final AppState state;
  final VoidCallback onViewAchievementsPressed;

  const StatsScreen({
    super.key,
    required this.state,
    required this.onViewAchievementsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero Streak Section
          ChunkyCard(
            backgroundColor: ChunkyColors.surfaceCard,
            borderColor: ChunkyColors.surfaceContainerHighest,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CURRENT STREAK',
                      style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: ChunkyColors.outline,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${state.userStreak}',
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w800,
                            fontSize: 48.0,
                            color: ChunkyColors.primary,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'DAYS',
                          style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: ChunkyColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  right: -10,
                  top: -10,
                  child: Opacity(
                    opacity: 0.15,
                    child: Icon(
                      Icons.local_fire_department,
                      size: 100.0,
                      color: ChunkyColors.primary,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: ChunkyColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: ChunkyColors.primary,
                        width: 2.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Level ${state.level} Warrior',
                          style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: ChunkyColors.primary,
                          ),
                        ),
                        Text(
                          '${state.nextLevelXpRequired - state.currentLevelXp} XP to Level ${state.level + 1}',
                          style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontSize: 9.0,
                            color: ChunkyColors.primary.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Insights Grid
          Row(
            children: [
              Expanded(
                child: ChunkyCard(
                  borderColor: ChunkyColors.surfaceContainerHighest,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.verified, color: ChunkyColors.primary, size: 20.0),
                          SizedBox(width: 6.0),
                          Text(
                            'Completed',
                            style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.bold,
                              color: ChunkyColors.outline,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '128',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w800,
                          fontSize: 32.0,
                          color: ChunkyColors.onSurface,
                        ),
                      ),
                      Text(
                        '+12 this week',
                        style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontSize: 12.0,
                          color: ChunkyColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: ChunkyCard(
                  borderColor: ChunkyColors.surfaceContainerHighest,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.workspace_premium, color: ChunkyColors.primary, size: 20.0),
                          SizedBox(width: 6.0),
                          Text(
                            'Best Streak',
                            style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.bold,
                              color: ChunkyColors.outline,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '${state.userBestStreak}',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w800,
                          fontSize: 32.0,
                          color: ChunkyColors.onSurface,
                        ),
                      ),
                      Text(
                        'Personal Record',
                        style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontSize: 12.0,
                          color: ChunkyColors.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),

          // Freezes Card
          ChunkyCard(
            borderColor: ChunkyColors.surfaceContainerHighest,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: ChunkyColors.secondaryFixed.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: ChunkyColors.secondaryFixed, width: 2.0),
                  ),
                  child: Icon(Icons.ac_unit, color: ChunkyColors.secondaryFixed, size: 32.0),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'STREAK FREEZES',
                        style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0,
                          color: ChunkyColors.outline,
                        ),
                      ),
                      Text(
                        '${state.userFreezesRemaining} Remaining',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w800,
                          fontSize: 24.0,
                          color: ChunkyColors.onSurface,
                        ),
                      ),
                      Text(
                        'Grace days protect your streak if you miss a day.',
                        style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontSize: 11.0,
                          color: ChunkyColors.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Completion Chart Section
          ChunkyCard(
            borderColor: ChunkyColors.surfaceContainerHighest,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Weekly Progress',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                        color: ChunkyColors.onSurface,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: ChunkyColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: ChunkyColors.outlineVariant,
                          width: 2.0,
                        ),
                      ),
                      child: Text(
                        'LAST 7 DAYS',
                        style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0,
                          color: ChunkyColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                WeeklyProgressChart(),
                SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: ChunkyColors.primaryFixedDim.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: ChunkyColors.primary,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.trending_up, color: ChunkyColors.primaryContainer, size: 36.0),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "You're crushing it!",
                              style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.bold,
                                color: ChunkyColors.primary,
                              ),
                            ),
                            Text(
                              '82% average completion this week.',
                              style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontSize: 13.0,
                                color: ChunkyColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),

          // Category Breakdown
          Text(
            'Quest Categories',
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w800,
              fontSize: 20.0,
              color: ChunkyColors.onSurface,
            ),
          ),
          SizedBox(height: 16.0),

          _buildCategoryBreakdownCard(
            title: 'Health',
            percentage: 92,
            color: ChunkyColors.errorRed,
            icon: Icons.favorite,
          ),
          SizedBox(height: 12.0),
          _buildCategoryBreakdownCard(
            title: 'Work',
            percentage: 68,
            color: ChunkyColors.primary,
            icon: Icons.work,
          ),
          SizedBox(height: 12.0),
          _buildCategoryBreakdownCard(
            title: 'Social',
            percentage: 45,
            color: ChunkyColors.primary,
            icon: Icons.groups,
          ),
          SizedBox(height: 12.0),
          _buildCategoryBreakdownCard(
            title: 'Mind',
            percentage: 76,
            color: ChunkyColors.primaryContainer,
            icon: Icons.psychology,
          ),
          SizedBox(height: 24.0),

          // Achievement Preview Card
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: ChunkyColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: ChunkyColors.primary,
                width: 4.0,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.military_tech,
                      color: ChunkyColors.primary,
                      size: 64.0,
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: ChunkyColors.onSurface,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.check_circle, color: ChunkyColors.primary, size: 16.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Text(
                  'Almost there!',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: ChunkyColors.onSurface,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  "Complete 3 more quests to unlock the 'Consistency King' badge.",
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontSize: 14.0,
                    color: ChunkyColors.outline,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                ChunkyButton(
                  backgroundColor: ChunkyColors.primary,
                  shadowColor: Colors.purple.shade800,
                  onTap: onViewAchievementsPressed,
                  child: Text(
                    'VIEW ALL ACHIEVEMENTS',
                    style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: ChunkyColors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.0),
        ],
      ),
    );
  }

  Widget _buildCategoryBreakdownCard({
    required String title,
    required int percentage,
    required Color color,
    required IconData icon,
  }) {
    return ChunkyCard(
      borderColor: ChunkyColors.surfaceContainerHighest,
      child: Row(
        children: [
          Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: color,
                width: 2.0,
              ),
            ),
            child: Icon(icon, color: color),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: ChunkyColors.onSurface,
                      ),
                    ),
                    Text(
                      '$percentage%',
                      style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.bold,
                        color: ChunkyColors.outline,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: LinearProgressIndicator(
                    value: percentage / 100,
                    minHeight: 12.0,
                    backgroundColor: ChunkyColors.surfaceContainerHighest,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




