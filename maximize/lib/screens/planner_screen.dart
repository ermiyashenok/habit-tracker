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
          SizedBox(height: 24.0),

          // Render view based on toggle
          _isWeekView ? _buildWeekView() : _buildMonthView(),
        ],
      ),
    );
  }

  Widget _buildWeekView() {
    final now = DateTime.now();
    final months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
    final weekNumber = ((now.difference(DateTime(now.year, 1, 1)).inDays + DateTime(now.year, 1, 1).weekday) / 7).ceil();
    final dayNames = ['MON','TUE','WED','THU','FRI','SAT','SUN'];
    // Start of current week (Monday)
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    // Compute per-day completion
    final logs = widget.state.dailyLogs;
    final activities = widget.state.activeActivities;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Month Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              months[now.month - 1],
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                fontSize: 24.0,
                color: ChunkyColors.onSurface,
              ),
            ),
            Text(
              'WEEK $weekNumber',
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

        // Horizontal Week Days — real data
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(7, (i) {
              final day = startOfWeek.add(Duration(days: i));
              final dateStr = '${day.year.toString().padLeft(4,'0')}-${day.month.toString().padLeft(2,'0')}-${day.day.toString().padLeft(2,'0')}';
              final doneLogs = logs.where((l) => l.date == dateStr && l.status == 'done').length;
              final totalActs = activities.length;
              final progress = totalActs > 0 ? (doneLogs / totalActs).clamp(0.0, 1.0) : 0.0;
              final isToday = day.year == now.year && day.month == now.month && day.day == now.day;
              return Padding(
                padding: EdgeInsets.only(right: i < 6 ? 12.0 : 0),
                child: _buildDayCard(
                  dayName: dayNames[i],
                  dayNum: '${day.day}',
                  progress: progress,
                  isActive: isToday,
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 24.0),

        // Weekly progress summary
        Builder(builder: (context) {
          final totalActs = activities.length;
          final doneTodayCount = logs.where((l) => l.date == '${now.year.toString().padLeft(4,'0')}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')}' && l.status == 'done').length;
          final pct = totalActs > 0 ? (doneTodayCount / totalActs * 100).round() : 0;
          return ChunkyCard(
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
                      child: Text(
                        "TODAY'S PROGRESS",
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
                        color: ChunkyColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Icon(Icons.track_changes, color: ChunkyColors.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Text(
                  totalActs == 0
                      ? 'No missions yet — add your first quest!'
                      : '$doneTodayCount of $totalActs missions completed',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w800,
                    fontSize: 18.0,
                    color: ChunkyColors.onSurface,
                  ),
                ),
                const SizedBox(height: 12.0),
                if (totalActs > 0) ...
                [
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: doneTodayCount / totalActs,
                            minHeight: 12.0,
                            backgroundColor: ChunkyColors.surfaceContainerLow,
                            color: ChunkyColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Text(
                        '$pct%',
                        style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.bold,
                          color: ChunkyColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        }),
        const SizedBox(height: 16.0),

        Row(
          children: [
            // Quick Add Card — fixed icon visibility
            Expanded(
              child: GestureDetector(
                onTap: widget.onAddQuestPressed,
                child: Container(
                  height: 120.0,
                  decoration: BoxDecoration(
                    color: ChunkyColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: ChunkyColors.primary, width: 2.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: ChunkyColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 22.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
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
            SizedBox(width: 16.0),
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
                    Row(
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
                    SizedBox(height: 16.0),
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
                        SizedBox(width: 4.0),
                        Text(
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
        SizedBox(height: 24.0),

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
              onTap: () => _showAllSuggestions(context),
              child: Text(
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

        ..._suggestedActivities().take(3).map((s) => Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _buildSuggestedActivityItem(
            title: s['title'] as String,
            subtitle: s['subtitle'] as String,
            icon: s['icon'] as IconData,
            color: s['color'] as Color,
            category: s['category'] as String,
            duration: s['duration'] as int?,
          ),
        )),
        const SizedBox(height: 24.0),
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
                Icon(Icons.auto_graph, color: ChunkyColors.primary, size: 16.0),
                SizedBox(width: 4.0),
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
        SizedBox(height: 16.0),
        ChunkyCard(
          borderColor: ChunkyColors.surfaceContainerHighest,
          child: HeatmapGrid(
            logs: widget.state.dailyLogs,
            month: DateTime.now().month,
            year: DateTime.now().year,
          ),
        ),
        SizedBox(height: 24.0),

        // Monthly Goals Title
        Text(
          'Monthly Goals',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
            color: ChunkyColors.onSurface,
          ),
        ),
        SizedBox(height: 16.0),

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
        SizedBox(height: 12.0),
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
        SizedBox(height: 24.0),

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
            Text(
              'Edit',
              style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                color: ChunkyColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),

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
            SizedBox(width: 16.0),
            Expanded(
              child: ChunkyCard(
                borderColor: ChunkyColors.surfaceContainerHighest,
                child: Column(
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
        SizedBox(height: 24.0),
        ChunkyButton(
          backgroundColor: ChunkyColors.primaryContainer,
          shadowColor: ChunkyColors.primary,
          onTap: widget.onAddQuestPressed,
          child: Row(
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
        SizedBox(height: 32.0),
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
            SizedBox(height: 4.0),
            Text(
              dayNum,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                fontSize: 20.0,
                color: textColor,
              ),
            ),
            SizedBox(height: 8.0),
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

  List<Map<String, dynamic>> _suggestedActivities() {
    return [
      {'title': 'Morning Gym Session', 'subtitle': '45 mins • Health', 'icon': Icons.fitness_center, 'color': ChunkyColors.primary, 'category': 'Health', 'duration': 45},
      {'title': 'Read 10 Pages', 'subtitle': '20 mins • Learning', 'icon': Icons.menu_book, 'color': ChunkyColors.secondary, 'category': 'Learning', 'duration': 20},
      {'title': 'Daily Mindfulness', 'subtitle': '10 mins • Spirit', 'icon': Icons.self_improvement, 'color': const Color(0xFF9C27B0), 'category': 'Spirit', 'duration': 10},
      {'title': 'Evening Walk', 'subtitle': '30 mins • Health', 'icon': Icons.directions_walk, 'color': const Color(0xFF4CAF50), 'category': 'Health', 'duration': 30},
      {'title': 'Drink 8 Glasses of Water', 'subtitle': 'One action • Health', 'icon': Icons.water_drop, 'color': const Color(0xFF2196F3), 'category': 'Health', 'duration': null},
      {'title': 'Journal Entry', 'subtitle': '15 mins • Mind', 'icon': Icons.edit_note, 'color': const Color(0xFFFF9800), 'category': 'Mind', 'duration': 15},
      {'title': 'Cold Shower', 'subtitle': 'One action • Health', 'icon': Icons.shower, 'color': const Color(0xFF00BCD4), 'category': 'Health', 'duration': null},
      {'title': 'Practice Gratitude', 'subtitle': '5 mins • Spirit', 'icon': Icons.favorite, 'color': const Color(0xFFE91E63), 'category': 'Spirit', 'duration': 5},
      {'title': 'Stretching Routine', 'subtitle': '15 mins • Health', 'icon': Icons.accessibility_new, 'color': ChunkyColors.primary, 'category': 'Health', 'duration': 15},
      {'title': 'Language Practice', 'subtitle': '20 mins • Learning', 'icon': Icons.translate, 'color': const Color(0xFF607D8B), 'category': 'Learning', 'duration': 20},
      {'title': 'No Social Media', 'subtitle': 'One action • Mind', 'icon': Icons.phone_locked, 'color': const Color(0xFFFF5722), 'category': 'Mind', 'duration': null},
      {'title': 'Cook a Healthy Meal', 'subtitle': '30 mins • Health', 'icon': Icons.restaurant, 'color': const Color(0xFF8BC34A), 'category': 'Health', 'duration': 30},
    ];
  }

  void _showAllSuggestions(BuildContext context) {
    final suggestions = _suggestedActivities();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (ctx, scrollController) => Container(
          decoration: BoxDecoration(
            color: ChunkyColors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(color: ChunkyColors.outlineVariant),
          ),
          child: Column(
            children: [
              Container(
                width: 40, height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: ChunkyColors.outline.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
                child: Row(
                  children: [
                    Text(
                      'All Suggested Activities',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: ChunkyColors.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  itemCount: suggestions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (ctx2, i) {
                    final s = suggestions[i];
                    return _buildSuggestedActivityItem(
                      title: s['title'] as String,
                      subtitle: s['subtitle'] as String,
                      icon: s['icon'] as IconData,
                      color: s['color'] as Color,
                      category: s['category'] as String,
                      duration: s['duration'] as int?,
                      onAdded: () => Navigator.of(ctx2).pop(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestedActivityItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String category,
    int? duration,
    VoidCallback? onAdded,
  }) {
    final alreadyAdded = widget.state.activities.any((a) => a.name == title && !a.isArchived);
    return ChunkyCard(
      borderColor: ChunkyColors.outlineVariant,
      onTap: alreadyAdded ? null : () {
        final newAct = Activity(
          id: 'act_${DateTime.now().millisecondsSinceEpoch}',
          name: title,
          category: category,
          time: 'Anytime',
          repeatPattern: 'daily',
          createdAt: DateTime.now(),
          durationMinutes: duration,
        );
        widget.state.addActivity(newAct);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ChunkyColors.primaryContainer,
            content: Text('"$title" added to your quests!',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        );
        onAdded?.call();
      },
      child: Row(
        children: [
          Container(
            width: 48.0, height: 48.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(icon, color: color, size: 24.0),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold, fontSize: 16.0,
                    color: alreadyAdded ? ChunkyColors.outline : ChunkyColors.onSurface,
                    decoration: alreadyAdded ? TextDecoration.lineThrough : null,
                  )),
                Text(subtitle,
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro', fontSize: 12.0,
                    color: ChunkyColors.outline,
                  )),
              ],
            ),
          ),
          if (alreadyAdded)
            Icon(Icons.check_circle, color: ChunkyColors.primary, size: 24)
          else
            Container(
              width: 36.0, height: 36.0,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2.0),
              ),
              child: Icon(Icons.add, color: color, size: 18.0),
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
                      '$current/$target',
                      style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.bold,
                        color: ChunkyColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
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




