import 'package:flutter/material.dart';
import 'chunky_colors.dart';
import '../models/daily_log.dart';

class HeatmapGrid extends StatelessWidget {
  final List<DailyLog> logs;
  final int month;
  final int year;

  const HeatmapGrid({
    super.key,
    required this.logs,
    required this.month,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    // Days in September: 30 days
    const totalDays = 30;
    // September starts with 4 grayed cells (28, 29, 30, 31) from August
    final grayedDays = [28, 29, 30, 31];

    // Let's build lists of grid items
    final List<Widget> gridItems = [];

    // Add M, T, W, T, F, S, S headers
    const headers = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    for (final h in headers) {
      gridItems.add(
        Center(
          child: Text(
            h,
            style: TextStyle(
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: ChunkyColors.outline,
            ),
          ),
        ),
      );
    }

    // Add grayed days from previous month
    for (final day in grayedDays) {
      gridItems.add(
        Container(
          decoration: BoxDecoration(
            color: ChunkyColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: ChunkyColors.surfaceContainerHighest,
              width: 2.0,
            ),
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: ChunkyColors.outlineVariant,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Get today's day if it's the current month and year
    final now = DateTime.now();
    final isCurrentMonth = now.month == month && now.year == year;
    final todayDay = now.day;

    // Add days of the month
    for (int day = 1; day <= totalDays; day++) {
      // Find logs for this date
      final dateStr = '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
      final dayLogs = logs.where((l) => l.date == dateStr && l.status == 'done').toList();

      Color cellColor = ChunkyColors.surfaceContainerLow;
      Color textColor = ChunkyColors.onSurfaceVariant;

      if (dayLogs.length >= 3) {
        cellColor = ChunkyColors.primary;
        textColor = ChunkyColors.onSurface;
      } else if (dayLogs.isNotEmpty) {
        cellColor = ChunkyColors.primaryContainer;
        textColor = ChunkyColors.onSurface;
      }

      final isToday = isCurrentMonth && day == todayDay;

      gridItems.add(
        Container(
          decoration: BoxDecoration(
            color: cellColor,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: isToday ? ChunkyColors.secondaryContainer : Colors.transparent,
              width: 2.0,
            ),
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    '$day',
                    style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: textColor,
                    ),
                  ),
                ),
                if (isToday)
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: ChunkyColors.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: gridItems,
    );
  }
}


