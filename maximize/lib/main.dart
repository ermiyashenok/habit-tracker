import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/chunky_colors.dart';
import 'widgets/bottom_nav_bar.dart';
import 'providers/app_state.dart';
import 'screens/today_screen.dart';
import 'screens/planner_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/friends_screen.dart';
import 'screens/badges_screen.dart';
import 'screens/new_quest_screen.dart';
import 'screens/quest_detail_screen.dart';
import 'models/activity.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const QuestLogApp());
}

class QuestLogApp extends StatelessWidget {
  const QuestLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quest Log',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: ChunkyColors.primaryContainer,
          primary: ChunkyColors.primary,
          secondary: ChunkyColors.secondary,
          surface: ChunkyColors.surface,
          error: ChunkyColors.errorRed,
        ),
        scaffoldBackgroundColor: ChunkyColors.background,
        textTheme: GoogleFonts.plusJakartaSansTextTheme(),
        useMaterial3: true,
      ),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final AppState _appState = AppState();

  // Sub-navigation state
  bool _showNewQuestScreen = false;
  Activity? _selectedActivity;

  @override
  void initState() {
    super.initState();
    _appState.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    _appState.removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged() {
    if (mounted) setState(() {});
  }

  void _navigateToNewQuest() {
    setState(() {
      _showNewQuestScreen = true;
      _selectedActivity = null;
    });
  }

  void _navigateToQuestDetail(Activity activity) {
    setState(() {
      _selectedActivity = activity;
      _showNewQuestScreen = false;
    });
  }

  void _navigateBack() {
    setState(() {
      _showNewQuestScreen = false;
      _selectedActivity = null;
    });
  }

  void _onTabSelected(CurrentTab tab) {
    setState(() {
      _appState.currentTab = tab;
      _showNewQuestScreen = false;
      _selectedActivity = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show New Quest Screen as a full-page overlay
    if (_showNewQuestScreen) {
      return NewQuestScreen(
        state: _appState,
        onCancel: _navigateBack,
      );
    }

    // Show Quest Detail Screen as a full-page overlay
    if (_selectedActivity != null) {
      return QuestDetailScreen(
        activity: _selectedActivity!,
        state: _appState,
        onBack: _navigateBack,
      );
    }

    return Scaffold(
      backgroundColor: ChunkyColors.background,
      appBar: AppBar(
        backgroundColor: ChunkyColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ChunkyColors.primaryContainer, width: 2.0),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAAcPH8KsDjc80EHZXxfve3z1KCmHRKxbYDvvIWLNcPQWckU71u_7Nv8pGRqfGdi8yrPI0QjgDNDIpMZ44UrUr8qbRjdBlJSflltrW6lNLto9VxscxEInwzfCJUFjYogG-hfXfmm4TJGLBxOWS4z0f1Q32MptONBYsEGlFyD7p9_sCuocJ5VPmeib8Ov5btE9btVZejSJjD1WJrlpKammtOKRhjVbB5wGmO0xzZuTfW13DYelg5FSLeaKLFxHIYjquBiirwqhZGLJQL',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getGreeting(),
                  style: const TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontSize: 12.0,
                    color: ChunkyColors.outline,
                  ),
                ),
                Text(
                  'Quest Log',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w800,
                    fontSize: 20.0,
                    color: ChunkyColors.onSurface,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // XP Badge
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: ChunkyColors.secondaryFixed,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: ChunkyColors.secondary, width: 2.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.stars, color: ChunkyColors.secondary, size: 16.0),
                const SizedBox(width: 4.0),
                Text(
                  '${_appState.userXp}',
                  style: const TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: ChunkyColors.secondary,
                  ),
                ),
              ],
            ),
          ),
          // Streak Badge
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: ChunkyColors.primaryFixedDim.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: ChunkyColors.primary, width: 2.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.local_fire_department, color: ChunkyColors.secondaryContainer, size: 16.0),
                const SizedBox(width: 4.0),
                Text(
                  '${_appState.userStreak}',
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
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: ChunkyColors.surfaceContainerHighest,
            height: 4.0,
          ),
        ),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavBar(
        currentTab: _appState.currentTab,
        onTabSelected: _onTabSelected,
      ),
    );
  }

  Widget _buildBody() {
    switch (_appState.currentTab) {
      case CurrentTab.today:
        return TodayScreen(
          state: _appState,
          onAddQuestPressed: _navigateToNewQuest,
          onSelectQuest: _navigateToQuestDetail,
        );
      case CurrentTab.planner:
        return PlannerScreen(
          state: _appState,
          onAddQuestPressed: _navigateToNewQuest,
        );
      case CurrentTab.stats:
        return StatsScreen(
          state: _appState,
          onViewAchievementsPressed: () => _onTabSelected(CurrentTab.badges),
        );
      case CurrentTab.friends:
        return FriendsScreen(state: _appState);
      case CurrentTab.badges:
        return BadgesScreen(state: _appState);
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning ☀️';
    if (hour < 17) return 'Good afternoon 🌤️';
    return 'Good evening 🌙';
  }
}
