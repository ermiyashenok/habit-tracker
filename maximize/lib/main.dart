import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/chunky_colors.dart';
import 'widgets/chunky_button.dart';
import 'widgets/bottom_nav_bar.dart';
import 'providers/app_state.dart';
import 'screens/today_screen.dart';
import 'screens/planner_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/social_screen.dart';
import 'screens/new_quest_screen.dart';
import 'screens/quest_detail_screen.dart';
import 'screens/login_screen.dart';
import 'models/activity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await NotificationService().init();
  }

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully");
  } catch (e) {
    debugPrint("Firebase init error: $e");
    // If initialization fails, we might want to show an error or continue?
    // For now, we'll continue, but the app might not work properly.
    // In a real app, we should handle this more gracefully.
  }
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
      title: 'Maximize',
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
      home: FirebaseAuth.instance.currentUser != null ? const AppShell() : const LoginScreen(),
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
    if (_appState.showLevelUpDialog) {
      final level = _appState.levelUpTo;
      _appState.dismissLevelUpDialog();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLevelUpCelebrationDialog(context, level);
      });
    } else if (_appState.showMissionCompleteCelebration) {
      final name = _appState.missionCompleteName;
      final xp = _appState.missionCompleteXp;
      _appState.dismissMissionCompleteCelebration();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showMissionCompleteCelebrationDialog(context, name, xp);
      });
    }
    if (mounted) setState(() {});
  }

  void _showLevelUpCelebrationDialog(BuildContext context, int level) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: ChunkyColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: const BorderSide(color: Color(0xFFFFD700), width: 4), // Golden border
        ),
        title: Column(
          children: [
            const Icon(Icons.workspace_premium, color: Color(0xFFFFD700), size: 72),
            const SizedBox(height: 12),
            Text(
              'LEVEL UP! 🌟',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w900,
                fontSize: 26,
                color: ChunkyColors.onSurface,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Congratulations, adventurer!',
              style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontSize: 16,
                color: ChunkyColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Level ${level - 1}',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: ChunkyColors.outline,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(Icons.arrow_forward_rounded, color: ChunkyColors.primary, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Level $level',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w800,
                    fontSize: 28,
                    color: const Color(0xFFFFD700), // Golden level text
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ChunkyColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.ac_unit_rounded, color: ChunkyColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    '+1 Streak Freeze rewarded!',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: ChunkyColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ChunkyButton(
            backgroundColor: ChunkyColors.primary,
            shadowHeight: 3,
            onTap: () => Navigator.of(ctx).pop(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
              child: Text(
                'ONWARDS!',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMissionCompleteCelebrationDialog(BuildContext context, String questName, int xp) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ChunkyColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: ChunkyColors.primary, width: 3),
        ),
        title: Column(
          children: [
            Icon(Icons.local_fire_department, color: ChunkyColors.primary, size: 64),
            const SizedBox(height: 12),
            Text(
              'QUEST COMPLETE! 🎉',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                color: ChunkyColors.onSurface,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You completed the mission:',
              style: TextStyle(fontFamily: 'BeVietnamPro', color: ChunkyColors.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            Text(
              questName,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: ChunkyColors.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: ChunkyColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: ChunkyColors.primary),
              ),
              child: Text(
                '+$xp XP REWARD',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: ChunkyColors.primary,
                ),
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ChunkyButton(
            backgroundColor: ChunkyColors.primary,
            shadowHeight: 2,
            onTap: () => Navigator.of(ctx).pop(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                'VICTORY!',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
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

    final bool isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: ChunkyColors.background,
      body: SafeArea(
        child: isDesktop
            ? Row(
                children: [
                  _buildSideNavBar(),
                  Expanded(
                    child: Column(
                      children: [
                        _buildTopAppBar(),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(24)),
                            child: Container(
                              color: ChunkyColors.surface,
                              child: _buildBody(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : _buildBody(),
      ),
      bottomNavigationBar: isDesktop
          ? null
          : BottomNavBar(
              currentTab: _appState.currentTab,
              onTabSelected: _onTabSelected,
            ),
    );
  }

  Widget _buildTopAppBar() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Empty left side or title
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_outlined, color: ChunkyColors.onSurfaceVariant),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.workspace_premium_outlined, color: ChunkyColors.onSurfaceVariant),
                onPressed: () {},
              ),
              const SizedBox(width: 16),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ChunkyColors.primaryFixedDim,
                  border: Border.all(color: ChunkyColors.outlineVariant),
                  image: const DecorationImage(
                    image: AssetImage('assets/app_icon.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSideNavBar() {
    return Container(
      width: 250,
      color: ChunkyColors.surface,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Maximize',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    color: ChunkyColors.primary,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  'Level Up Life',
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    color: ChunkyColors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          _buildSideNavItem('Dashboard', Icons.dashboard, CurrentTab.today),
          _buildSideNavItem('Quests', Icons.rocket_launch, CurrentTab.planner),
          _buildSideNavItem('Analytics', Icons.equalizer, CurrentTab.stats),
          _buildSideNavItem('Social', Icons.group, CurrentTab.social),
          _buildSideNavItem('Settings', Icons.settings, CurrentTab.profile),
          
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ChunkyButton(
              backgroundColor: ChunkyColors.primaryContainer,
              borderColor: ChunkyColors.primary,
              shadowColor: ChunkyColors.primary.withValues(alpha: 0.4),
              onTap: _navigateToNewQuest,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'New Habit',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          const Divider(),
          _buildSideNavItem('Logout', Icons.logout, CurrentTab.profile), // We can update this later
        ],
      ),
    );
  }

  Widget _buildSideNavItem(String label, IconData icon, CurrentTab tab) {
    final bool isActive = _appState.currentTab == tab;
    return GestureDetector(
      onTap: () async {
        if (label == 'Logout') {
          await FirebaseAuth.instance.signOut();
          if (!mounted) return;
          Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          _onTabSelected(tab);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 24, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? ChunkyColors.secondaryContainer : Colors.transparent,
          borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
          border: isActive ? Border(left: BorderSide(color: ChunkyColors.primary, width: 4)) : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? ChunkyColors.onSurface : ChunkyColors.onSurfaceVariant,
              size: 22,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                color: isActive ? ChunkyColors.onSurface : ChunkyColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
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
          onViewAchievementsPressed: () => _onTabSelected(CurrentTab.profile),
        );
      case CurrentTab.social:
        return SocialScreen(state: _appState);
      case CurrentTab.profile:
        return ProfileScreen(state: _appState);
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning ☀️';
    if (hour < 17) return 'Good afternoon 🌤️';
    return 'Good evening 🌙';
  }
}

