import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/chunky_colors.dart';
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
  await NotificationService().init();

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
      body: SafeArea(
        child: _buildBody(),
      ),
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

