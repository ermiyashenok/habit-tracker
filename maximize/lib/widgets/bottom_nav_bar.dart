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
    return Container(
      decoration: const BoxDecoration(
        color: ChunkyColors.surface,
        border: Border(
          top: BorderSide(
            color: ChunkyColors.surfaceContainerHighest,
            width: 1.0,
          ),
        ),
      ),
      padding: EdgeInsets.only(
        top: 8.0,
        bottom: MediaQuery.of(context).padding.bottom + 8.0,
        left: 8.0,
        right: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            tab: CurrentTab.today,
            icon: Icons.bolt,
            label: 'Today',
          ),
          _buildNavItem(
            tab: CurrentTab.planner,
            icon: Icons.calendar_month,
            label: 'Planner',
          ),
          _buildNavItem(
            tab: CurrentTab.stats,
            icon: Icons.leaderboard,
            label: 'Stats',
          ),
          _buildNavItem(
            tab: CurrentTab.friends,
            icon: Icons.group,
            label: 'Friends',
          ),
          _buildNavItem(
            tab: CurrentTab.badges,
            icon: Icons.workspace_premium,
            label: 'Badges',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required CurrentTab tab,
    required IconData icon,
    required String label,
  }) {
    final isActive = currentTab == tab;

    if (isActive) {
      return GestureDetector(
        onTap: () => onTabSelected(tab),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: ChunkyColors.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: ChunkyColors.primary,
                size: 24.0,
              ),
              const SizedBox(height: 2.0),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: ChunkyColors.primary,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => onTabSelected(tab),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: ChunkyColors.outline,
                size: 24.0,
              ),
              const SizedBox(height: 2.0),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: ChunkyColors.outline,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
