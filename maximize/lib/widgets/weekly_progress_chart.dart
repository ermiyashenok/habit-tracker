import 'package:flutter/material.dart';
import 'chunky_colors.dart';

class WeeklyProgressChart extends StatefulWidget {
  const WeeklyProgressChart({super.key});

  @override
  State<WeeklyProgressChart> createState() => _WeeklyProgressChartState();
}

class _WeeklyProgressChartState extends State<WeeklyProgressChart> {
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    // Trigger animation after frame rendering
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _animate = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final days = [
      _BarData(label: 'M', value: 0.60, isDashed: false),
      _BarData(label: 'T', value: 0.85, isDashed: false),
      _BarData(label: 'W', value: 0.45, isDashed: false),
      _BarData(label: 'T', value: 0.95, isDashed: false),
      _BarData(label: 'F', value: 0.70, isDashed: false),
      _BarData(label: 'S', value: 0.30, isDashed: true),
      _BarData(label: 'S', value: 0.10, isDashed: false),
    ];

    return Container(
      height: 160.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: days.map((day) {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: _animate ? day.value : 0.0),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutBack,
                      builder: (context, val, child) {
                        return FractionallySizedBox(
                          heightFactor: val.clamp(0.01, 1.0),
                          child: day.isDashed
                              ? CustomPaint(
                                  size: const Size(double.infinity, double.infinity),
                                  painter: _DashedBarPainter(),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: ChunkyColors.primaryContainer,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  day.label,
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: day.isDashed ? FontWeight.bold : FontWeight.normal,
                    fontSize: 12.0,
                    color: day.isDashed ? ChunkyColors.primary : ChunkyColors.outline,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _BarData {
  final String label;
  final double value;
  final bool isDashed;

  _BarData({
    required this.label,
    required this.value,
    required this.isDashed,
  });
}

class _DashedBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ChunkyColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final fillPaint = Paint()
      ..color = ChunkyColors.primaryContainer
      ..style = PaintingStyle.fill;

    // Draw solid fill background
    final rect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, size.width, size.height),
      topLeft: const Radius.circular(8.0),
      topRight: const Radius.circular(8.0),
    );
    canvas.drawRRect(rect, fillPaint);

    // Draw dashed borders
    final path = Path()
      ..addRRect(rect);

    // Basic dashing implementation
    double distance = 0.0;
    const dashLength = 6.0;
    const gapLength = 4.0;
    final pathMetrics = path.computeMetrics();

    for (final metric in pathMetrics) {
      while (distance < metric.length) {
        final start = distance;
        final end = (distance + dashLength).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(start, end), paint);
        distance += dashLength + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


