import 'package:flutter/material.dart';
import 'chunky_colors.dart';
import '../providers/app_state.dart';

class BottomNavBar extends StatelessWidget {
  final CurrentTab currentTab;
  final ValueChanged<CurrentTab> onTabSelected;

  const BottomNavBar({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = [
      CurrentTab.today,
      CurrentTab.planner,
      CurrentTab.stats,
      CurrentTab.social,
      CurrentTab.profile,
    ];
    
    final icons = [
      Icons.bolt,
      Icons.calendar_month,
      Icons.leaderboard,
      Icons.group,
      Icons.person_outline,
    ];

    int selectedIndex = tabs.indexOf(currentTab);
    if (selectedIndex == -1) {
      selectedIndex = 0; // Fallback for hot reload state mismatch
    }

    return Container(
      color: Colors.transparent,
      height: 90,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              painter: _NavBarPainter(selectedIndex, tabs.length),
              child: SizedBox(
                height: 75,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(tabs.length, (index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => onTabSelected(tabs[index]),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / tabs.length,
                          height: 75,
                          child: index != selectedIndex
                              ? Icon(
                                  icons[index],
                                  color: Colors.black87,
                                  size: 28.0,
                                )
                              : const SizedBox.shrink(),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
          // Floating active item
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            bottom: 35,
            left: _calculateActivePosition(context, selectedIndex, tabs.length),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 56.0,
                height: 56.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF91295A), // Similar to the maroon/pink in the image
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icons[selectedIndex],
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateActivePosition(BuildContext context, int index, int total) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tabWidth = screenWidth / total;
    // Center of the tab minus half of the circle width (28)
    return (tabWidth * index) + (tabWidth / 2) - 28;
  }
}

class _NavBarPainter extends CustomPainter {
  final int selectedIndex;
  final int totalTabs;

  _NavBarPainter(this.selectedIndex, this.totalTabs);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    
    // Top left rounded corner
    path.moveTo(0, 20);
    path.quadraticBezierTo(0, 0, 20, 0);

    final tabWidth = size.width / totalTabs;
    final centerX = (tabWidth * selectedIndex) + (tabWidth / 2);

    final holeRadius = 38.0;

    // Draw line to the start of the hole
    path.lineTo(centerX - holeRadius - 10, 0);
    
    // Draw the hole curve
    path.cubicTo(
      centerX - holeRadius + 5, 0,
      centerX - holeRadius + 10, holeRadius,
      centerX, holeRadius,
    );
    path.cubicTo(
      centerX + holeRadius - 10, holeRadius,
      centerX + holeRadius - 5, 0,
      centerX + holeRadius + 10, 0,
    );

    // Draw line to top right
    path.lineTo(size.width - 20, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 20);

    // Bottom right
    path.lineTo(size.width, size.height);
    // Bottom left
    path.lineTo(0, size.height);

    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _NavBarPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex;
  }
}
