import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/chunky_colors.dart';
import '../widgets/chunky_card.dart';
import '../widgets/chunky_button.dart';
import '../providers/app_state.dart';
import '../models/activity.dart';
import '../models/daily_log.dart';
import 'dart:math';

class TodayScreen extends StatefulWidget {
  final AppState state;
  final VoidCallback onAddQuestPressed;
  final ValueChanged<Activity> onSelectQuest;

  const TodayScreen({
    super.key,
    required this.state,
    required this.onAddQuestPressed,
    required this.onSelectQuest,
  });

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  String _formatDuration(int seconds) {
    final m = (seconds / 60).floor().toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final activities = widget.state.activeActivities;
    final logs = widget.state.dailyLogs;

    final today = DateTime.now();
    final y = today.year.toString().padLeft(4, '0');
    final m = today.month.toString().padLeft(2, '0');
    final d = today.day.toString().padLeft(2, '0');
    final todayStr = '$y-$m-$d';

    int completedCount = 0;
    for (final act in activities) {
      final isDone = logs.any((l) => l.activityId == act.id && l.date == todayStr && l.status == 'done');
      if (isDone) completedCount++;
    }

    final double completionProgress = activities.isEmpty ? 0 : completedCount / activities.length;
    final int completionPercent = (completionProgress * 100).round();
    final int streak = widget.state.userStreak;
    final int nextMilestone = ((streak ~/ 10) + 1) * 10;
    final int daysToMilestone = nextMilestone - streak;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 24), // Balance
              Text(
                'DAY STREAK',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  letterSpacing: 2.0,
                  color: ChunkyColors.onSurface,
                ),
              ),
              Icon(Icons.info_outline, color: ChunkyColors.onSurfaceVariant),
            ],
          ),
          SizedBox(height: 32.0),

          // Hero Flame
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF9A00), Color(0xFFFF5A00)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF5A00).withValues(alpha: 0.3),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.local_fire_department,
                  size: 72,
                  color: ChunkyColors.onSurface,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),

          // Streak Number
          Center(
            child: Text(
              '$streak',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                fontSize: 64.0,
                color: ChunkyColors.onSurface,
                height: 1.0,
              ),
            ),
          ),
          Center(
            child: Text(
              'DAY STREAK',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                letterSpacing: 1.5,
                color: ChunkyColors.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(height: 32.0),

          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCol('Nov 25, 2025', 'Streak started'),
              Container(width: 1, height: 40, color: ChunkyColors.outlineVariant),
              _buildStatCol('${max(streak, 12)}', 'Max streak'), // Dummy max streak
            ],
          ),
          SizedBox(height: 32.0),

          // THIS WEEK Card
          ChunkyCard(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'THIS WEEK',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    letterSpacing: 1.5,
                    color: ChunkyColors.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(7, (index) {
                    final dayNames = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
                    final isToday = index == today.weekday - 1;
                    final isPast = index < today.weekday - 1;
                    
                    return Column(
                      children: [
                        Text(
                          dayNames[index],
                          style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: isToday ? ChunkyColors.onSurface : ChunkyColors.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        if (isPast || (isToday && completionPercent == 100))
                          Icon(Icons.local_fire_department, color: ChunkyColors.primary, size: 28)
                        else
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ChunkyColors.outlineVariant,
                                style: BorderStyle.solid,
                                width: 2,
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // MILESTONE Card
          ChunkyCard(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                // Current milestone circle
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ChunkyColors.primary, width: 2),
                  ),
                  child: Center(
                    child: Icon(Icons.local_fire_department, color: ChunkyColors.primary, size: 24),
                  ),
                ),
                SizedBox(width: 16),
                // Progress Bar
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '$daysToMilestone more days',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: ChunkyColors.onSurface,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: ChunkyColors.outlineVariant,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: FractionallySizedBox(
                          widthFactor: (10 - daysToMilestone) / 10.0,
                          alignment: Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              color: ChunkyColors.primary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'to unlock your next milestone.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10.0,
                          color: ChunkyColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                // Next milestone circle
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ChunkyColors.outlineVariant, width: 2),
                    color: ChunkyColors.surfaceContainerLow,
                  ),
                  child: Center(
                    child: Text(
                      '$nextMilestone',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: ChunkyColors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.0),

          // Missions Title
          Text(
            "TODAY'S MISSIONS",
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 1.5,
              color: ChunkyColors.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 12.0),

          // Checklist
          if (activities.isEmpty)
            ChunkyCard(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Icon(Icons.sentiment_dissatisfied, size: 48, color: ChunkyColors.outlineVariant),
                  SizedBox(height: 12),
                  Text(
                    'No missions scheduled for today.',
                    style: TextStyle(fontFamily: 'BeVietnamPro', fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Click below to add a new quest.',
                    style: TextStyle(fontFamily: 'BeVietnamPro', fontSize: 14, color: ChunkyColors.onSurfaceVariant),
                  ),
                ],
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.0),
              itemBuilder: (context, index) {
                final act = activities[index];
                final isDone = logs.any((l) => l.activityId == act.id && l.date == todayStr && l.status == 'done');
                final log = logs.firstWhere(
                  (l) => l.activityId == act.id && l.date == todayStr,
                  orElse: () => DailyLog(id: '', activityId: act.id, date: todayStr, status: 'missed'),
                );

                final isTimerRunning = widget.state.activeTimerActivityId == act.id;
                final accumulatedSeconds = log.durationSeconds + (isTimerRunning ? widget.state.timerSeconds : 0);

                return ChunkyCard(
                  backgroundColor: isDone ? ChunkyColors.surfaceContainerLow : ChunkyColors.surfaceContainerHigh,
                  borderColor: isDone ? ChunkyColors.outlineVariant : Colors.transparent,
                  onTap: () => widget.onSelectQuest(act),
                  child: Row(
                    children: [
                      // Checklist bubble
                      GestureDetector(
                        onTap: () => widget.state.toggleTask(act.id, todayStr),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 150),
                          width: 36.0,
                          height: 36.0,
                          decoration: BoxDecoration(
                            color: isDone ? ChunkyColors.primary : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDone ? ChunkyColors.primary : ChunkyColors.outline,
                              width: 2.0,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: isDone ? ChunkyColors.onSurface : Colors.transparent,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),

                      // Text info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              act.name,
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                decoration: isDone ? TextDecoration.lineThrough : null,
                                color: isDone ? ChunkyColors.onSurfaceVariant : ChunkyColors.onSurface,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '${act.category.toUpperCase()} • ${act.time ?? "Anytime"}${accumulatedSeconds > 0 ? " • ${_formatDuration(accumulatedSeconds)}" : ""}',
                              style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontSize: 12.0,
                                color: ChunkyColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Timer start/stop action
                      if (!isDone)
                        GestureDetector(
                          onTap: () {
                            if (isTimerRunning) {
                              widget.state.stopTimer();
                            } else {
                              widget.state.startTimer(act.id);
                            }
                          },
                          child: Container(
                            width: 36.0,
                            height: 36.0,
                            decoration: BoxDecoration(
                              color: isTimerRunning ? ChunkyColors.errorRed.withValues(alpha: 0.2) : ChunkyColors.surfaceContainerLow,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isTimerRunning ? Icons.stop : Icons.play_arrow,
                              color: isTimerRunning ? ChunkyColors.errorRed : ChunkyColors.onSurfaceVariant,
                              size: 20.0,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          SizedBox(height: 24.0),

          ChunkyButton(
            backgroundColor: ChunkyColors.surfaceContainerLow,
            onTap: widget.onAddQuestPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: ChunkyColors.onSurface),
                SizedBox(width: 8),
                Text(
                  'NEW MISSION',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: ChunkyColors.onSurface,
                    letterSpacing: 1.2,
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

  Widget _buildStatCol(String topText, String bottomText) {
    return Column(
      children: [
        Text(
          topText,
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: ChunkyColors.onSurface,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          bottomText,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12.0,
            color: ChunkyColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}


