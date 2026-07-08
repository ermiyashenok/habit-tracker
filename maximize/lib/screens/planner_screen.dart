import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/chunky_colors.dart';
import '../widgets/chunky_card.dart';
import '../widgets/chunky_button.dart';
import '../widgets/heatmap_grid.dart';
import '../providers/app_state.dart';
import '../models/activity.dart';

class PlannerScreen extends StatefulWidget {
  final AppState state;
  final VoidCallback onAddQuestPressed;

  const PlannerScreen({
    super.key,
    required this.state,
    required this.onAddQuestPressed,
  });

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  bool _isWeekView = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // View Toggle Selector
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: ChunkyColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: ChunkyColors.darkBorder,
                width: 2.0,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isWeekView = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      decoration: BoxDecoration(
                        color: _isWeekView ? ChunkyColors.primaryContainer : Colors.transparent,
                        borderRadius: BorderRadius.circular(12.0),
                        border: _isWeekView
                            ? Border.all(color: ChunkyColors.darkBorder, width: 2.0)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          'WEEK PLAN',
                          style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                            color: _isWeekView ? ChunkyColors.onSurface : ChunkyColors.outline,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isWeekView = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      decoration: BoxDecoration(
                        color: !_isWeekView ? ChunkyColors.primaryContainer : Colors.transparent,
                        borderRadius: BorderRadius.circular(12.0),
                        border: !_isWeekView
                            ? Border.all(color: ChunkyColors.darkBorder, width: 2.0)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          'MONTH PLAN',
                          style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                            color: !_isWeekView ? ChunkyColors.onSurface : ChunkyColors.outline,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // Render view based on toggle
          _isWeekView ? _buildWeekView() : _buildMonthView(),
        ],
      ),
    );
  }

  Widget _buildWeekView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Month Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'September',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                fontSize: 24.0,
                color: ChunkyColors.onSurface,
              ),
            ),
            const Text(
              'WEEK 38',
              style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: ChunkyColors.outline,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        // Horizontal Week Days selector
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildDayCard(dayName: 'MON', dayNum: '18', progress: 0.8),
              const SizedBox(width: 12.0),
              _buildDayCard(dayName: 'TUE', dayNum: '19', progress: 0.4, isActive: true),
              const SizedBox(width: 12.0),
              _buildDayCard(dayName: 'WED', dayNum: '20', progress: 0.0),
              const SizedBox(width: 12.0),
              _buildDayCard(dayName: 'THU', dayNum: '21', progress: 0.2),
              const SizedBox(width: 12.0),
              _buildDayCard(dayName: 'FRI', dayNum: '22', progress: 0.95),
            ],
          ),
        ),
        const SizedBox(height: 24.0),

        // Bento Grid Title
        Text(
          'Your Weekly Quests',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
            color: ChunkyColors.onSurface,
          ),
        ),
        const SizedBox(height: 16.0),

        // Goals & Streak Bento Grid
        ChunkyCard(
          borderColor: ChunkyColors.outlineVariant,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: ChunkyColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Text(
                      'CURRENT GOAL',
                      style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                        color: ChunkyColors.primary,
                      ),
                    ),
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: ChunkyColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Icon(Icons.translate, color: ChunkyColors.primary),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Text(
                'Finish Language Module',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0,
                  color: ChunkyColors.onSurface,
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LinearProgressIndicator(
                        value: 0.65,
                        minHeight: 12.0,
                        backgroundColor: ChunkyColors.surfaceContainerLow,
                        color: ChunkyColors.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  const Text(
                    '65%',
                    style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.bold,
                      color: ChunkyColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              const Text(
                '3 sessions left this week to reach your goal!',
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  color: ChunkyColors.onSurfaceVariant,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),

        Row(
          children: [
            // Quick Add Card
            Expanded(
              child: GestureDetector(
                onTap: widget.onAddQuestPressed,
                child: Container(
                  height: 120.0,
                  decoration: BoxDecoration(
                    color: ChunkyColors.onSurface.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: ChunkyColors.onSurface,
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: ChunkyColors.onSurface,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: ChunkyColors.onSurface, size: 20.0),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Quick Add Task',
                        style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.bold,
                          color: ChunkyColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            // Daily Streak Mini Card
            Expanded(
              child: ChunkyCard(
                borderColor: ChunkyColors.outlineVariant,
                shadowHeight: 4,
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.bolt, color: ChunkyColors.errorRed, size: 20.0),
                        SizedBox(width: 4.0),
                        Text(
                          'ACTIVE STREAK',
                          style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                            color: ChunkyColors.outline,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${widget.state.userStreak}',
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w800,
                            fontSize: 36.0,
                            color: ChunkyColors.errorRed,
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        const Text(
                          'DAYS',
                          style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: ChunkyColors.outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24.0),

        // Suggested activities
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Suggested Activities',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                fontSize: 20.0,
                color: ChunkyColors.onSurface,
              ),
            ),
            GestureDetector(
              onTap: widget.onAddQuestPressed,
              child: const Text(
                'SEE ALL',
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.bold,
                  color: ChunkyColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        _buildSuggestedActivityItem(
          title: 'Morning Gym Session',
          subtitle: '45 mins • Health',
          icon: Icons.fitness_center,
          color: ChunkyColors.primary,
        ),
        const SizedBox(height: 12.0),
        _buildSuggestedActivityItem(
          title: 'Read 10 Pages',
          subtitle: '20 mins • Learning',
          icon: Icons.book,
          color: ChunkyColors.onSurface,
        ),
        const SizedBox(height: 12.0),
        _buildSuggestedActivityItem(
          title: 'Daily Mindfulness',
          subtitle: '10 mins • Spirit',
          icon: Icons.mediation,
          color: ChunkyColors.onSurface,
        ),
        const SizedBox(height: 32.0),
      ],
    );
  }

  Widget _buildMonthView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Heatmap Grid
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'September',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                fontSize: 24.0,
                color: ChunkyColors.onSurface,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.auto_graph, color: ChunkyColors.primary, size: 16.0),
                const SizedBox(width: 4.0),
                Text(
                  '94% Consistency',
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.bold,
                    color: ChunkyColors.primary,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        ChunkyCard(
          borderColor: ChunkyColors.surfaceContainerHighest,
          child: HeatmapGrid(
            logs: widget.state.dailyLogs,
            month: DateTime.now().month,
            year: DateTime.now().year,
          ),
        ),
        const SizedBox(height: 24.0),

        // Monthly Goals Title
        Text(
          'Monthly Goals',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
            color: ChunkyColors.onSurface,
          ),
        ),
        const SizedBox(height: 16.0),

        // Goal card 1
        _buildMonthlyGoalCard(
          title: 'Read 2 Books',
          icon: Icons.menu_book,
          iconBg: ChunkyColors.onSurface,
          iconColor: ChunkyColors.primary,
          current: 1,
          target: 2,
          progress: 0.50,
        ),
        const SizedBox(height: 12.0),
        // Goal card 2
        _buildMonthlyGoalCard(
          title: '15 Gym Sessions',
          icon: Icons.fitness_center,
          iconBg: ChunkyColors.primary.withOpacity(0.3),
          iconColor: ChunkyColors.primary,
          current: 12,
          target: 15,
          progress: 0.80,
        ),
        const SizedBox(height: 24.0),

        // July Recurrence preview
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Plan for July',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                fontSize: 20.0,
                color: ChunkyColors.onSurface,
              ),
            ),
            const Text(
              'Edit',
              style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                color: ChunkyColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        Row(
          children: [
            Expanded(
              child: ChunkyCard(
                borderColor: ChunkyColors.surfaceContainerHighest,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.event_repeat, color: ChunkyColors.primary),
                        SizedBox(width: 6.0),
                        Text(
                          'Weekly Run',
                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Every Tuesday & Thursday morning.',
                      style: TextStyle(fontFamily: 'BeVietnamPro', fontSize: 13.0, color: ChunkyColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: ChunkyCard(
                borderColor: ChunkyColors.surfaceContainerHighest,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.savings, color: ChunkyColors.primary),
                        SizedBox(width: 6.0),
                        Text(
                          'Save \$500',
                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Automatic transfer on July 1st.',
                      style: TextStyle(fontFamily: 'BeVietnamPro', fontSize: 13.0, color: ChunkyColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        ChunkyButton(
          backgroundColor: ChunkyColors.primaryContainer,
          shadowColor: ChunkyColors.primary,
          onTap: widget.onAddQuestPressed,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_circle, color: ChunkyColors.onSurface),
              SizedBox(width: 8.0),
              Text(
                'ADD NEW QUEST',
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: ChunkyColors.onSurface,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32.0),
      ],
    );
  }

  Widget _buildDayCard({
    required String dayName,
    required String dayNum,
    required double progress,
    bool isActive = false,
  }) {
    final bgColor = isActive ? ChunkyColors.primaryContainer : ChunkyColors.surfaceContainerHigh;
    final borderColor = isActive ? ChunkyColors.primary : ChunkyColors.surfaceContainerHighest;
    final shadowColor = isActive ? ChunkyColors.primary : ChunkyColors.surfaceContainerHighest;
    final textColor = isActive ? ChunkyColors.onSurface : ChunkyColors.onSurface;
    final labelColor = isActive ? ChunkyColors.onSurface.withOpacity(0.8) : ChunkyColors.outline;

    return ChunkyCard(
      backgroundColor: bgColor,
      borderColor: borderColor,
      shadowColor: shadowColor,
      shadowHeight: 4,
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: 52.0,
        child: Column(
          children: [
            Text(
              dayName,
              style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                color: labelColor,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              dayNum,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                fontSize: 20.0,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              height: 6.0,
              decoration: BoxDecoration(
                color: isActive ? ChunkyColors.onSurface.withOpacity(0.3) : ChunkyColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(3.0),
              ),
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: isActive ? ChunkyColors.onSurface : ChunkyColors.primaryContainer,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestedActivityItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return ChunkyCard(
      borderColor: ChunkyColors.outlineVariant,
      onTap: () {
        // Quick add the suggested activity to the state
        final newAct = Activity(
          id: 'act_${DateTime.now().millisecondsSinceEpoch}',
          name: title,
          category: title.contains('Mind') ? 'Mind' : (title.contains('Gym') ? 'Health' : 'Learning'),
          time: '08:00',
          repeatPattern: 'daily',
          createdAt: DateTime.now(),
        );
        widget.state.addActivity(newAct);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ChunkyColors.primaryContainer,
            content: Text(
              '"$title" added to today\'s missions!',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
      child: Row(
        children: [
          Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(icon, color: color, size: 24.0),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontSize: 12.0,
                    color: ChunkyColors.outline,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: ChunkyColors.onSurface,
              shape: BoxShape.circle,
              border: Border.all(
                color: ChunkyColors.primary,
                width: 2.0,
              ),
            ),
            child: const Icon(
              Icons.event_available,
              color: ChunkyColors.primary,
              size: 18.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyGoalCard({
    required String title,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required int current,
    required int target,
    required double progress,
  }) {
    return ChunkyCard(
      borderColor: ChunkyColors.surfaceContainerHighest,
      child: Row(
        children: [
          Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: iconColor,
                width: 2.0,
              ),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16.0),
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
                      '$current/$target',
                      style: const TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.bold,
                        color: ChunkyColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 12.0,
                    backgroundColor: ChunkyColors.surfaceContainerHighest,
                    color: iconColor,
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
