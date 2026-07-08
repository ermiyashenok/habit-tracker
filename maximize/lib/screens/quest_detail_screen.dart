import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/chunky_colors.dart';
import '../widgets/chunky_card.dart';
import '../widgets/chunky_button.dart';
import '../models/activity.dart';
import '../providers/app_state.dart';

class QuestDetailScreen extends StatelessWidget {
  final Activity activity;
  final AppState state;
  final VoidCallback onBack;

  const QuestDetailScreen({
    super.key,
    required this.activity,
    required this.state,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final currentStreak = state.getActivityStreak(activity.id);
    final bestStreak = state.getActivityBestStreak(activity.id);
    final totalCompletions = state.getActivityTotalCompletions(activity.id);

    return Scaffold(
      backgroundColor: ChunkyColors.background,
      appBar: AppBar(
        backgroundColor: ChunkyColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ChunkyColors.primary, size: 28.0),
          onPressed: onBack,
        ),
        title: Text(
          activity.name,
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
            color: ChunkyColors.onSurface,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: ChunkyColors.surfaceContainerHighest,
            height: 4.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Category Badge & Details
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(activity.category).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: _getCategoryColor(activity.category), width: 2.0),
                  ),
                  child: Text(
                    activity.category.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.w800,
                      color: _getCategoryColor(activity.category),
                      fontSize: 11.0,
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                const Icon(Icons.stars, color: ChunkyColors.onSurface, size: 20.0),
                const SizedBox(width: 4.0),
                Text(
                  '${activity.xpReward} XP Reward',
                  style: const TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.bold,
                    color: ChunkyColors.onSurfaceVariant,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // Bento Stats Grid
            Row(
              children: [
                Expanded(
                  child: ChunkyCard(
                    borderColor: ChunkyColors.surfaceContainerHighest,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.bolt, color: ChunkyColors.onSurface, size: 24.0),
                        const SizedBox(height: 8.0),
                        const Text(
                          'STREAK',
                          style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                            color: ChunkyColors.outline,
                          ),
                        ),
                        Text(
                          '$currentStreak Days',
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w800,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: ChunkyCard(
                    borderColor: ChunkyColors.surfaceContainerHighest,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.workspace_premium, color: ChunkyColors.primary, size: 24.0),
                        const SizedBox(height: 8.0),
                        const Text(
                          'BEST STREAK',
                          style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                            color: ChunkyColors.outline,
                          ),
                        ),
                        Text(
                          '$bestStreak Days',
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w800,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            ChunkyCard(
              borderColor: ChunkyColors.surfaceContainerHighest,
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: ChunkyColors.primary, size: 28.0),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TOTAL COMPLETIONS',
                          style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                            color: ChunkyColors.outline,
                          ),
                        ),
                        Text(
                          '$totalCompletions completions',
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w800,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),

            // Time and Repeat Patterns info
            Text(
              'Quest Schedule & Timing',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                fontSize: 18.0,
                color: ChunkyColors.onSurface,
              ),
            ),
            const SizedBox(height: 12.0),
            ChunkyCard(
              borderColor: ChunkyColors.outlineVariant,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Scheduled Reminder:',
                        style: TextStyle(fontFamily: 'BeVietnamPro', color: ChunkyColors.outline),
                      ),
                      Text(
                        activity.time ?? 'Anytime',
                        style: const TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Repeat Pattern:',
                        style: TextStyle(fontFamily: 'BeVietnamPro', color: ChunkyColors.outline),
                      ),
                      Text(
                        activity.repeatPattern.toUpperCase(),
                        style: const TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),

            // Notes Section
            if (activity.notes.isNotEmpty) ...[
              Text(
                'Quest Notes & Tactics',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0,
                  color: ChunkyColors.onSurface,
                ),
              ),
              const SizedBox(height: 12.0),
              ChunkyCard(
                borderColor: ChunkyColors.outlineVariant,
                backgroundColor: ChunkyColors.surfaceContainerLow,
                child: Text(
                  activity.notes,
                  style: const TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontSize: 14.0,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
            ],

            // Danger actions
            ChunkyButton(
              backgroundColor: ChunkyColors.surfaceContainerHigh,
              borderColor: ChunkyColors.darkBorder,
              shadowColor: ChunkyColors.surfaceContainerHighest,
              onTap: () {
                // Pause activity
                final updated = activity.copyWith(isActive: !activity.isActive);
                state.updateActivity(updated);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: ChunkyColors.primaryContainer,
                    content: Text(
                      activity.isActive ? 'Quest reminders paused.' : 'Quest reminders enabled!',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
                onBack();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(activity.isActive ? Icons.pause : Icons.play_arrow, color: ChunkyColors.onSurface),
                  const SizedBox(width: 8.0),
                  Text(
                    activity.isActive ? 'PAUSE QUEST' : 'RESUME QUEST',
                    style: const TextStyle(
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.bold,
                      color: ChunkyColors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            ChunkyButton(
              backgroundColor: ChunkyColors.errorRed,
              shadowColor: ChunkyColors.errorRed,
              onTap: () {
                // Soft Delete / Archive
                state.deleteActivity(activity.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: ChunkyColors.errorRed,
                    content: Text(
                      '"${activity.name}" archived successfully.',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
                onBack();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.archive, color: ChunkyColors.onSurface),
                  SizedBox(width: 8.0),
                  Text(
                    'ARCHIVE QUEST',
                    style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.bold,
                      color: ChunkyColors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String cat) {
    switch (cat.toLowerCase()) {
      case 'health':
        return ChunkyColors.errorRed;
      case 'work':
        return ChunkyColors.primary;
      case 'mind':
        return ChunkyColors.primary;
      default:
        return ChunkyColors.onSurface;
    }
  }
}
