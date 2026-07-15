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

  String _todayStr() {
    final today = DateTime.now();
    final y = today.year.toString().padLeft(4, '0');
    final m = today.month.toString().padLeft(2, '0');
    final d = today.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  @override
  Widget build(BuildContext context) {
    final activities = widget.state.activeActivities;
    final logs = widget.state.dailyLogs;
    final todayStr = _todayStr();
    final today = DateTime.now();

    final int streak = widget.state.userStreak;
    final int bestStreak = widget.state.userBestStreak;
    final int nextMilestone = ((streak ~/ 10) + 1) * 10;
    final int daysToMilestone = nextMilestone - streak;

    // Paused quests
    final pausedQuests = widget.state.activities.where((a) => !a.isActive).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Header ────────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 24),
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
          const SizedBox(height: 32.0),

          // ── Hero Flame ────────────────────────────────────────────
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
          const SizedBox(height: 16.0),

          // ── Streak Number ─────────────────────────────────────────
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
          const SizedBox(height: 32.0),

          // ── Stats Row ─────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCol(
                streak == 0 ? 'Not started' : _streakStartDate(streak),
                'Streak started',
              ),
              Container(width: 1, height: 40, color: ChunkyColors.outlineVariant),
              _buildStatCol('$bestStreak', 'Best streak'),
            ],
          ),
          const SizedBox(height: 32.0),

          // ── This Week Card ────────────────────────────────────────
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
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(7, (index) {
                    final dayNames = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
                    final isToday = index == today.weekday - 1;

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
                        const SizedBox(height: 8.0),
                        Builder(builder: (context) {
                          final dateForDay = today.add(Duration(days: index - (today.weekday - 1)));
                          final dateStr =
                              '${dateForDay.year.toString().padLeft(4, '0')}-${dateForDay.month.toString().padLeft(2, '0')}-${dateForDay.day.toString().padLeft(2, '0')}';
                          final hasDoneTask = logs.any((l) => l.date == dateStr && l.status == 'done');

                          if (hasDoneTask) {
                            return Icon(Icons.local_fire_department, color: ChunkyColors.primary, size: 28);
                          } else {
                            return Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ChunkyColors.outlineVariant,
                                  width: 2,
                                ),
                              ),
                            );
                          }
                        }),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),

          // ── Milestone Card ────────────────────────────────────────
          ChunkyCard(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ChunkyColors.primary, width: 2),
                  ),
                  child: Center(child: Icon(Icons.local_fire_department, color: ChunkyColors.primary, size: 24)),
                ),
                const SizedBox(width: 16),
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
                      const SizedBox(height: 8),
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: ChunkyColors.outlineVariant,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: FractionallySizedBox(
                          widthFactor: ((10 - daysToMilestone) / 10.0).clamp(0.0, 1.0),
                          alignment: Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              color: ChunkyColors.primary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
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
                const SizedBox(width: 16),
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
          const SizedBox(height: 32.0),

          // ── Today's Missions ──────────────────────────────────────
          Text(
            "TODAY'S MISSIONS",
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 1.5,
              color: ChunkyColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12.0),

          if (activities.isEmpty)
            ChunkyCard(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Icon(Icons.sentiment_dissatisfied, size: 48, color: ChunkyColors.outlineVariant),
                  const SizedBox(height: 12),
                  Text(
                    'No missions scheduled for today.',
                    style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ChunkyColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap "New Mission" below to add your first quest.',
                    textAlign: TextAlign.center,
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
              separatorBuilder: (_, __) => const SizedBox(height: 12.0),
              itemBuilder: (context, index) {
                final act = activities[index];
                final isDone = logs.any(
                    (l) => l.activityId == act.id && l.date == todayStr && l.status == 'done');
                final log = logs.firstWhere(
                  (l) => l.activityId == act.id && l.date == todayStr,
                  orElse: () => DailyLog(
                      id: '', activityId: act.id, date: todayStr, status: 'missed'),
                );

                final isTimed = act.durationMinutes != null && act.durationMinutes! > 0;
                final isTimerRunning = widget.state.activeTimerActivityId == act.id;
                final accumulatedSeconds =
                    log.durationSeconds + (isTimerRunning ? widget.state.timerSeconds : 0);
                final targetSeconds = isTimed ? act.durationMinutes! * 60 : 0;
                final remainingSeconds = isTimed
                    ? max(0, targetSeconds - accumulatedSeconds)
                    : 0;

                return ChunkyCard(
                  backgroundColor:
                      isDone ? ChunkyColors.surfaceContainerLow : ChunkyColors.surfaceContainerHigh,
                  borderColor: isDone ? ChunkyColors.outlineVariant : Colors.transparent,
                  onTap: () => widget.onSelectQuest(act),
                  child: Row(
                    children: [
                      // ── Done indicator bubble ──
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
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
                          child: isDone
                              ? Icon(Icons.check, color: ChunkyColors.onSurface, size: 20.0)
                              : isTimed
                                  ? Icon(Icons.timer, color: ChunkyColors.outline, size: 16.0)
                                  : Icon(Icons.check, color: Colors.transparent, size: 20.0),
                        ),
                      ),
                      const SizedBox(width: 12.0),

                      // ── Text Info ──────────────
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
                                color: isDone
                                    ? ChunkyColors.onSurfaceVariant
                                    : ChunkyColors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            if (isTimed && !isDone)
                              // Live countdown
                              Row(
                                children: [
                                  Text(
                                    '${act.category.toUpperCase()} • ',
                                    style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontSize: 12.0,
                                      color: ChunkyColors.onSurfaceVariant,
                                    ),
                                  ),
                                  Icon(
                                    isTimerRunning
                                        ? Icons.timer
                                        : Icons.hourglass_empty,
                                    color: isTimerRunning
                                        ? ChunkyColors.primary
                                        : ChunkyColors.outline,
                                    size: 13,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    isTimerRunning
                                        ? '${_formatDuration(remainingSeconds)} left'
                                        : '${act.durationMinutes} min required',
                                    style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontSize: 12.0,
                                      fontWeight: isTimerRunning
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isTimerRunning
                                          ? ChunkyColors.primary
                                          : ChunkyColors.outline,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Text(
                                '${act.category.toUpperCase()} • ${act.time ?? "Anytime"}${isTimed && isDone ? " • ✓ Timed" : ""}',
                                style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontSize: 12.0,
                                  color: ChunkyColors.onSurfaceVariant,
                                ),
                              ),
                          ],
                        ),
                      ),

                      // ── Action Button ──────────
                      if (!isDone) ...[
                        if (isTimed)
                          // Timer start/stop button
                          GestureDetector(
                            onTap: () {
                              if (isTimerRunning) {
                                widget.state.stopTimer();
                              } else {
                                widget.state.startTimer(act.id);
                              }
                            },
                            child: Container(
                              width: 44.0,
                              height: 44.0,
                              decoration: BoxDecoration(
                                color: isTimerRunning
                                    ? ChunkyColors.errorRed.withValues(alpha: 0.15)
                                    : ChunkyColors.primary.withValues(alpha: 0.12),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isTimerRunning
                                      ? ChunkyColors.errorRed
                                      : ChunkyColors.primary,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                isTimerRunning ? Icons.stop_rounded : Icons.play_arrow_rounded,
                                color: isTimerRunning
                                    ? ChunkyColors.errorRed
                                    : ChunkyColors.primary,
                                size: 22.0,
                              ),
                            ),
                          )
                        else
                          // Done button for one-action missions
                          GestureDetector(
                            onTap: () {
                              widget.state.toggleTask(act.id, todayStr);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: ChunkyColors.primary,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: ChunkyColors.primary.withValues(alpha: 0.3),
                                    offset: const Offset(0, 3),
                                    blurRadius: 0,
                                  ),
                                ],
                              ),
                              child: Text(
                                'DONE',
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ],
                  ),
                );
              },
            ),
          const SizedBox(height: 24.0),

          // ── New Mission Button ─────────────────────────────────────
          ChunkyButton(
            backgroundColor: ChunkyColors.surfaceContainerLow,
            onTap: widget.onAddQuestPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: ChunkyColors.onSurface),
                const SizedBox(width: 8),
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

          // ── Paused Quests (moved from Planner) ────────────────────
          if (pausedQuests.isNotEmpty) ...[
            const SizedBox(height: 32.0),
            Text(
              'PAUSED QUESTS',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                letterSpacing: 1.5,
                color: ChunkyColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12.0),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pausedQuests.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10.0),
              itemBuilder: (context, index) {
                final quest = pausedQuests[index];
                return ChunkyCard(
                  borderColor: ChunkyColors.outlineVariant,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: ChunkyColors.surfaceContainerLow,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.pause_rounded, color: ChunkyColors.outline, size: 20),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              quest.name,
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: ChunkyColors.onSurface,
                              ),
                            ),
                            Text(
                              '${quest.category.toUpperCase()} • ${quest.durationMinutes != null && quest.durationMinutes! > 0 ? "${quest.durationMinutes} min timer" : "One-action"}',
                              style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                color: ChunkyColors.outline,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ChunkyButton(
                        backgroundColor: ChunkyColors.primaryContainer,
                        shadowColor: ChunkyColors.primary,
                        shadowHeight: 2,
                        height: 38.0,
                        onTap: () {
                          widget.state.toggleActivityPause(quest.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${quest.name} resumed!'),
                              backgroundColor: ChunkyColors.primary,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Text(
                            'RESUME',
                            style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: ChunkyColors.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],

          const SizedBox(height: 32.0),
        ],
      ),
    );
  }

  /// Estimates when the streak started based on the current streak count.
  String _streakStartDate(int streak) {
    final startDate = DateTime.now().subtract(Duration(days: streak - 1));
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[startDate.month - 1]} ${startDate.day}, ${startDate.year}';
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
        const SizedBox(height: 4.0),
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
