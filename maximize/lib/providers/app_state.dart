import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/activity.dart';
import '../models/daily_log.dart';
import '../models/friend.dart';
import '../models/achievement.dart';
import '../services/notification_service.dart';
import '../widgets/chunky_colors.dart';

enum CurrentTab { today, planner, stats, social, profile }

class AppState extends ChangeNotifier {
  // Navigation
  CurrentTab _currentTab = CurrentTab.today;
  CurrentTab get currentTab => _currentTab;

  set currentTab(CurrentTab tab) {
    _currentTab = tab;
    notifyListeners();
  }

  // Active page context (e.g. detail view of a quest)
  Activity? _selectedActivity;
  Activity? get selectedActivity => _selectedActivity;
  set selectedActivity(Activity? activity) {
    _selectedActivity = activity;
    notifyListeners();
  }

  // Timer fields
  String? _activeTimerActivityId;
  String? get activeTimerActivityId => _activeTimerActivityId;
  int _timerSeconds = 0;
  int get timerSeconds => _timerSeconds;
  Timer? _timer;

  // Data fields
  List<Activity> _activities = [];
  List<DailyLog> _dailyLogs = [];
  List<Achievement> _achievements = [];
  List<Friend> _friends = [];

  List<Activity> get activities => _activities.where((a) => !a.isArchived).toList();
  List<Activity> get activeActivities => _activities.where((a) => !a.isArchived && a.isActive).toList();
  List<DailyLog> get dailyLogs => _dailyLogs;
  List<Achievement> get achievements => _achievements;
  List<Friend> get friends => _friends;

  // User Stats
  int _userXp = 0;
  int get userXp => _userXp;
  int _userStreak = 0;
  int get userStreak => _userStreak;
  int _userBestStreak = 0;
  int get userBestStreak => _userBestStreak;
  int _level = 1;
  int get level => _level;

  bool _showLevelUpDialog = false;
  bool get showLevelUpDialog => _showLevelUpDialog;
  int _levelUpTo = 1;
  int get levelUpTo => _levelUpTo;

  void dismissLevelUpDialog() {
    _showLevelUpDialog = false;
  }

  bool _showMissionCompleteCelebration = false;
  bool get showMissionCompleteCelebration => _showMissionCompleteCelebration;
  String _missionCompleteName = '';
  String get missionCompleteName => _missionCompleteName;
  int _missionCompleteXp = 0;
  int get missionCompleteXp => _missionCompleteXp;

  void dismissMissionCompleteCelebration() {
    _showMissionCompleteCelebration = false;
  }
  
  int get currentLevelXp {
    int lvl = 1;
    int expAccumulated = 0;
    while (lvl < _level) {
      expAccumulated += ((100 * math.pow(lvl, 1.5)) / 10).round() * 10;
      lvl++;
    }
    return _userXp - expAccumulated;
  }

  int get nextLevelXpRequired {
    if (_level >= 50) return 0;
    return ((100 * math.pow(_level, 1.5)) / 10).round() * 10;
  }

  int _totalEarnedFreezes = 2; // Starts with 2 freezes
  int _userFreezesRemaining = 2;
  int get userFreezesRemaining => _userFreezesRemaining;

  // Theme
  bool get isLightMode => ChunkyColors.isLightMode;

  void toggleTheme() {
    ChunkyColors.isLightMode = !ChunkyColors.isLightMode;
    notifyListeners();
  }

  AppState() {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      await _loadInitialData();
      if (user != null) {
        await _syncPublicProfile();
      }
    });
  }

  // Persistence methods
  DocumentReference get _dbDoc {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? 'guest_user';
    return FirebaseFirestore.instance.collection('users').doc(uid).collection('app_data').doc('state');
  }

  Future<void> _loadInitialData() async {
    try {
      final docSnapshot = await _dbDoc.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        
        if (data['activities'] != null) {
          final List<dynamic> jsonList = data['activities'];
          _activities = jsonList.map((e) => Activity.fromJson(e as Map<String, dynamic>)).toList();
        } else {
          _activities = [];
        }

        if (data['dailyLogs'] != null) {
          final List<dynamic> jsonList = data['dailyLogs'];
          _dailyLogs = jsonList.map((e) => DailyLog.fromJson(e as Map<String, dynamic>)).toList();
        } else {
          _dailyLogs = [];
        }

        if (data['achievements'] != null) {
          final List<dynamic> jsonList = data['achievements'];
          _achievements = jsonList.map((e) => Achievement.fromJson(e as Map<String, dynamic>)).toList();
        } else {
          _achievements = _getEmptyAchievements();
        }
        _syncAchievements();

        _userXp = data['userXp'] ?? 0;
        _userBestStreak = data['userBestStreak'] ?? 0;

        if (data['friends'] != null) {
          final List<dynamic> jsonList = data['friends'];
          _friends = jsonList.map((e) => Friend.fromJson(e as Map<String, dynamic>)).toList();
        } else {
          _friends = [];
        }
      } else {
        _activities = [];
        _dailyLogs = [];
        _achievements = _getEmptyAchievements();
        _userXp = 0;
        _userBestStreak = 0;
        _friends = [];
        await saveAllData();
      }
    } catch (e) {
      if (kDebugMode) print('Error loading data from Firestore: $e');
      _activities = [];
      _dailyLogs = [];
      _achievements = _getEmptyAchievements();
      _userXp = 0;
      _userBestStreak = 0;
      _friends = [];
    }

    _recalculateStreaks();
    notifyListeners();
  }

  Future<void> saveAllData() async {
    try {
      await _dbDoc.set({
        'activities': _activities.map((e) => e.toJson()).toList(),
        'dailyLogs': _dailyLogs.map((e) => e.toJson()).toList(),
        'achievements': _achievements.map((e) => e.toJson()).toList(),
        'userXp': _userXp,
        'userBestStreak': _userBestStreak,
        'friends': _friends.map((e) => e.toJson()).toList(),
      }, SetOptions(merge: true));
      // Sync public profile so other users can find/view this user
      await _syncPublicProfile();
    } catch (e) {
      if (kDebugMode) print('Error saving data to Firestore: $e');
    }
  }

  Future<void> _syncPublicProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      final displayName = user.displayName?.isNotEmpty == true ? user.displayName! : 'Adventurer';
      final email = user.email ?? '';

      List<String> generateSearchTerms(String name, String email) {
        final Set<String> terms = {};
        final nameParts = name.toLowerCase().split(' ');
        for (final part in nameParts) {
          if (part.isNotEmpty) terms.add(part);
        }
        if (name.isNotEmpty) terms.add(name.toLowerCase());
        if (email.isNotEmpty) {
          terms.add(email.toLowerCase());
          final emailName = email.split('@').first.toLowerCase();
          terms.add(emailName);
        }
        return terms.toList();
      }

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'displayName': displayName,
        'email': email,
        'searchTerms': generateSearchTerms(displayName, email),
        'photoUrl': user.photoURL ?? '',
        'xp': _userXp,
        'level': _level,
        'streak': _userStreak,
        'badgeCount': _achievements.where((a) => a.isUnlocked).length,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      if (kDebugMode) print('Error syncing public profile: $e');
    }
  }

  Future<void> clearAllData() async {
    _activities.clear();
    _dailyLogs.clear();
    _achievements.clear();
    _userXp = 0;
    _level = 1;
    _recalculateStreaks();
    notifyListeners();
    await saveAllData();
  }

  // Timer controls
  void startTimer(String activityId) {
    if (_activeTimerActivityId == activityId) return;

    if (_activeTimerActivityId != null) {
      stopTimer();
    }

    _activeTimerActivityId = activityId;
    _timerSeconds = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timerSeconds++;
      
      // Check if target duration is reached
      final activity = _activities.firstWhere((a) => a.id == activityId);
      if (activity.durationMinutes != null && activity.durationMinutes! > 0) {
        final todayStr = _getTodayString();
        final logIndex = _dailyLogs.indexWhere((l) => l.activityId == activityId && l.date == todayStr);
        final loggedSeconds = logIndex != -1 ? _dailyLogs[logIndex].durationSeconds : 0;
        final totalSeconds = loggedSeconds + _timerSeconds;
        
        if (totalSeconds >= activity.durationMinutes! * 60) {
          stopTimer(); // Stops the timer and marks as done
          return;
        }
      }
      
      notifyListeners();
    });
    notifyListeners();
  }

  void stopTimer() {
    if (_activeTimerActivityId == null) return;

    final activityId = _activeTimerActivityId!;
    final seconds = _timerSeconds;

    _timer?.cancel();
    _timer = null;
    _activeTimerActivityId = null;
    _timerSeconds = 0;

    // Log the duration
    logDuration(activityId, seconds);
    notifyListeners();
  }

  void logDuration(String activityId, int seconds) {
    final todayStr = _getTodayString();
    final logIndex = _dailyLogs.indexWhere((l) => l.activityId == activityId && l.date == todayStr);
    final activity = _activities.firstWhere((a) => a.id == activityId);

    if (logIndex != -1) {
      final log = _dailyLogs[logIndex];
      final newDuration = log.durationSeconds + seconds;
      
      // Determine if completed (either no timer required, or timer duration is reached)
      final isCompleted = activity.durationMinutes == null || 
                          activity.durationMinutes == 0 || 
                          newDuration >= activity.durationMinutes! * 60;

      _dailyLogs[logIndex] = log.copyWith(
        durationSeconds: newDuration,
        status: isCompleted ? 'done' : log.status,
        completedAt: isCompleted ? (log.completedAt ?? DateTime.now()) : null,
      );
      if (isCompleted && log.status != 'done') {
        _awardXpForActivity(activityId);
      }
    } else {
      final isCompleted = activity.durationMinutes == null || 
                          activity.durationMinutes == 0 || 
                          seconds >= activity.durationMinutes! * 60;
                          
      _dailyLogs.add(DailyLog(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        activityId: activityId,
        date: todayStr,
        status: isCompleted ? 'done' : 'missed',
        completedAt: isCompleted ? DateTime.now() : null,
        durationSeconds: seconds,
      ));
      if (isCompleted) {
        _awardXpForActivity(activityId);
      }
    }
    _recalculateStreaks();
    saveAllData();
  }

  void addActivity(Activity activity) {
    _activities.add(activity);
    saveAllData();
    if (!kIsWeb) _scheduleNotificationForActivity(activity);
    notifyListeners();
  }

  void updateActivity(Activity activity) {
    final index = _activities.indexWhere((a) => a.id == activity.id);
    if (index != -1) {
      _activities[index] = activity;
      saveAllData();
      if (!kIsWeb) _scheduleNotificationForActivity(activity);
      notifyListeners();
    }
  }

  void deleteActivity(String id) {
    final index = _activities.indexWhere((a) => a.id == id);
    if (index != -1) {
      _activities[index] = _activities[index].copyWith(isArchived: true);
      saveAllData();
      if (!kIsWeb) NotificationService().cancelReminder(id.hashCode);
      notifyListeners();
    }
  }

  void toggleActivityPause(String id) {
    final index = _activities.indexWhere((a) => a.id == id);
    if (index != -1) {
      final act = _activities[index];
      final updated = act.copyWith(isActive: !act.isActive);
      _activities[index] = updated;
      saveAllData();
      if (!kIsWeb) {
        if (updated.isActive) {
          _scheduleNotificationForActivity(updated);
        } else {
          NotificationService().cancelReminder(id.hashCode);
        }
      }
      notifyListeners();
    }
  }

  void _scheduleNotificationForActivity(Activity activity) {
    if (kIsWeb) return;
    if (!activity.isActive || activity.isArchived || activity.time == null || activity.time == 'Anytime') {
      NotificationService().cancelReminder(activity.id.hashCode);
      return;
    }
    
    try {
      final parts = activity.time!.split(':');
      if (parts.length == 2) {
        final hour = int.parse(parts[0]);
        final min = int.parse(parts[1]);
        NotificationService().scheduleDailyReminder(
          activity.id.hashCode,
          'Time for your quest!',
          'Don\'t forget to complete: ${activity.name}',
          hour,
          min,
        );
      }
    } catch (e) {
      if (kDebugMode) print('Error scheduling notification: $e');
    }
  }

  void toggleTask(String activityId, String dateStr) {
    final logIndex = _dailyLogs.indexWhere((l) => l.activityId == activityId && l.date == dateStr);
    final activity = _activities.firstWhere((a) => a.id == activityId);

    if (logIndex != -1) {
      final log = _dailyLogs[logIndex];
      if (log.status == 'done') {
        // Toggle off
        _dailyLogs[logIndex] = log.copyWith(
          status: 'missed',
          completedAt: null,
        );
      } else {
        // Toggle on (only if no timer required or timer is completed)
        if (activity.durationMinutes != null && activity.durationMinutes! > 0) {
          final loggedSeconds = log.durationSeconds;
          if (loggedSeconds < activity.durationMinutes! * 60) {
            return; // Can't complete manually
          }
        }
        _dailyLogs[logIndex] = log.copyWith(
          status: 'done',
          completedAt: DateTime.now(),
        );
        _awardXpForActivity(activityId);
      }
    } else {
      // Create new done log (only if no timer required)
      if (activity.durationMinutes != null && activity.durationMinutes! > 0) {
        return; // Can't complete manually
      }
      _dailyLogs.add(DailyLog(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        activityId: activityId,
        date: dateStr,
        status: 'done',
        completedAt: DateTime.now(),
      ));
      _awardXpForActivity(activityId);
    }

    _recalculateStreaks();
    saveAllData();
    notifyListeners();
  }

  void _awardXpForActivity(String activityId) {
    final activity = _activities.firstWhere((a) => a.id == activityId);
    final int xpAwarded = 25; // Capped at 25 XP per done rate
    _userXp += xpAwarded;
    
    // Set mission complete celebration details
    _showMissionCompleteCelebration = true;
    _missionCompleteName = activity.name;
    _missionCompleteXp = xpAwarded;

    _recalculateLevel();

    // Check special badges
    final now = DateTime.now();
    _updateAchievementProgress('ach_kickstart', 1);
    
    if (now.hour < 8) {
      _updateAchievementProgress('ach_early_bird', 1);
    }
    if (now.hour >= 21) {
      _updateAchievementProgress('ach_night_owl', 1);
    }
    
    final todayStr = _getTodayString();
    int completedToday = _dailyLogs.where((l) => l.date == todayStr && l.status == 'done').length;
    _updateAchievementProgress('ach_apex_day', completedToday);
  }

  void _recalculateLevel() {
    int newLevel = 1;
    int expAccumulated = 0;
    
    while (newLevel < 50) {
      int expNeededForNext = ((100 * math.pow(newLevel, 1.5)) / 10).round() * 10;
      if (_userXp >= expAccumulated + expNeededForNext) {
        expAccumulated += expNeededForNext;
        newLevel++;
      } else {
        break;
      }
    }
    
    if (newLevel > _level) {
      // Reward 1 streak freeze per level up
      _totalEarnedFreezes += (newLevel - _level);
      _checkLevelBadges(newLevel);
      _showLevelUpDialog = true;
      _levelUpTo = newLevel;
      if (!kIsWeb) {
        NotificationService().showLevelUpNotification(newLevel);
      }
    }
    
    _level = newLevel;
  }

  void _checkLevelBadges(int currentLevel) {
    _updateAchievementProgress('ach_novice', currentLevel);
    _updateAchievementProgress('ach_initiate', currentLevel);
    _updateAchievementProgress('ach_acolyte', currentLevel);
    _updateAchievementProgress('ach_stalwart', currentLevel);
    _updateAchievementProgress('ach_vanguard', currentLevel);
    _updateAchievementProgress('ach_master', currentLevel);
  }

  void _checkStreakBadges(int maxStreak) {
    _updateAchievementProgress('ach_spark', maxStreak);
    _updateAchievementProgress('ach_routine', maxStreak);
    _updateAchievementProgress('ach_habit', maxStreak);
    _updateAchievementProgress('ach_lunar', maxStreak);
    _updateAchievementProgress('ach_fire', maxStreak);
    _updateAchievementProgress('ach_centurion', maxStreak);
    _updateAchievementProgress('ach_monumental', maxStreak);
  }

  void _updateAchievementProgress(String achievementId, int newProgress) {
    final index = _achievements.indexWhere((a) => a.id == achievementId);
    if (index != -1) {
      final ach = _achievements[index];
      if (!ach.isUnlocked) {
        final progress = math.min(newProgress, ach.threshold).toInt();
        bool newlyUnlocked = false;
        DateTime? unlockedAt;
        if (progress >= ach.threshold) {
          newlyUnlocked = true;
          unlockedAt = DateTime.now();
        }
        _achievements[index] = ach.copyWith(
          progress: progress,
          isUnlocked: newlyUnlocked,
          unlockedAt: unlockedAt,
        );
        
        if (newlyUnlocked) {
          _userXp += 50;
          _recalculateLevel();
        }
      }
    }
  }

  void _recalculateStreaks() {
    // Collect unique dates where at least one task was completed
    // (Uses .toSet() so completing 5 tasks in a day = 1 streak day, not 5)
    final completedDates = _dailyLogs
        .where((l) => l.status == 'done')
        .map((l) => l.date)
        .toSet()
        .toList();

    completedDates.sort((a, b) => b.compareTo(a)); // desc order (newest first)

    if (completedDates.isEmpty) {
      _userStreak = 0;
      _userFreezesRemaining = _totalEarnedFreezes;
      _checkStreakBadges(0);
      return;
    }

    int currentStreak = 0;
    int freezesUsed = 0;
    final int maxFreezes = _totalEarnedFreezes;

    final today = DateTime.now();
    DateTime checkDate = today;

    // Max look-back = number of completed dates + freezes + today, capped at 365
    final maxLookBack = math.min(completedDates.length + maxFreezes + 1, 365);

    for (int i = 0; i < maxLookBack; i++) {
      final dateStr = _formatDate(checkDate);
      if (completedDates.contains(dateStr)) {
        currentStreak++;
      } else {
        // Today: no completion yet doesn't break streak
        if (checkDate.year == today.year &&
            checkDate.month == today.month &&
            checkDate.day == today.day) {
          // skip today if not yet done — don't break streak
        } else {
          if (freezesUsed < maxFreezes) {
            freezesUsed++;
            currentStreak++; // Grace day — freeze used
          } else {
            break; // Streak broken
          }
        }
      }
      checkDate = checkDate.subtract(const Duration(days: 1));
    }

    _userStreak = currentStreak;
    _userFreezesRemaining = maxFreezes - freezesUsed;
    if (_userStreak > _userBestStreak) {
      _userBestStreak = _userStreak;
    }

    int highestActivityStreak = 0;
    for (var a in _activities) {
      final s = getActivityBestStreak(a.id);
      if (s > highestActivityStreak) highestActivityStreak = s;
    }
    final overallBest = math.max(_userBestStreak, highestActivityStreak).toInt();
    _checkStreakBadges(overallBest);
  }

  // Helpers
  String _getTodayString() {
    return _formatDate(DateTime.now());
  }

  String _formatDate(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  // Get streak for specific activity
  int getActivityStreak(String activityId) {
    final completedDates = _dailyLogs
        .where((l) => l.activityId == activityId && l.status == 'done')
        .map((l) => l.date)
        .toSet()
        .toList();

    completedDates.sort((a, b) => b.compareTo(a));

    if (completedDates.isEmpty) return 0;

    int streak = 0;
    final today = DateTime.now();
    final todayStr = _getTodayString();
    final yesterdayStr = _formatDate(today.subtract(const Duration(days: 1)));

    if (completedDates.contains(todayStr) || completedDates.contains(yesterdayStr)) {
      DateTime checkDate = completedDates.contains(todayStr) ? today : today.subtract(const Duration(days: 1));
      while (true) {
        final dateStr = _formatDate(checkDate);
        if (completedDates.contains(dateStr)) {
          streak++;
          checkDate = checkDate.subtract(const Duration(days: 1));
        } else {
          break;
        }
      }
    }
    return streak;
  }

  int getActivityBestStreak(String activityId) {
    final completedDates = _dailyLogs
        .where((l) => l.activityId == activityId && l.status == 'done')
        .map((l) => DateTime.parse(l.date))
        .toSet()
        .toList();

    completedDates.sort(); // ascending

    if (completedDates.isEmpty) return 0;

    int maxStreak = 0;
    int currentStreak = 0;
    DateTime? prevDate;

    for (final date in completedDates) {
      if (prevDate == null) {
        currentStreak = 1;
      } else {
        final diff = date.difference(prevDate).inDays;
        if (diff == 1) {
          currentStreak++;
        } else if (diff > 1) {
          if (currentStreak > maxStreak) maxStreak = currentStreak;
          currentStreak = 1;
        }
      }
      prevDate = date;
    }
    if (currentStreak > maxStreak) maxStreak = currentStreak;

    return maxStreak;
  }

  int getActivityTotalCompletions(String activityId) {
    return _dailyLogs.where((l) => l.activityId == activityId && l.status == 'done').length;
  }

  void _syncAchievements() {
    final defaultAchievements = _getEmptyAchievements();
    for (var defaultAch in defaultAchievements) {
      final existingIndex = _achievements.indexWhere((a) => a.id == defaultAch.id);
      if (existingIndex == -1) {
        _achievements.add(defaultAch);
      }
    }
  }

  List<Achievement> _getEmptyAchievements() {
    return [
      // Tier 1: Streak Milestones
      Achievement(id: 'ach_spark', title: 'Spark', description: 'Maintain any habit streak for 3 consecutive days.', icon: 'bolt', categoryColor: 'secondary', threshold: 3, progress: 0),
      Achievement(id: 'ach_routine', title: 'Routine Builder', description: 'Maintain any habit streak for 7 consecutive days.', icon: 'eco', categoryColor: 'primary', threshold: 7, progress: 0),
      Achievement(id: 'ach_habit', title: 'Habit Formed', description: 'Reach a 21-day streak.', icon: 'lock', categoryColor: 'tertiary', threshold: 21, progress: 0),
      Achievement(id: 'ach_lunar', title: 'Lunar Cycle', description: 'Complete a 30-day streak on a single habit.', icon: 'nightlight_round', categoryColor: 'purple', threshold: 30, progress: 0),
      Achievement(id: 'ach_fire', title: 'On Fire', description: 'Reach a 50-day streak on a single habit.', icon: 'local_fire_department', categoryColor: 'secondary', threshold: 50, progress: 0),
      Achievement(id: 'ach_centurion', title: 'Centurion', description: 'Hit an incredible 100-day streak.', icon: 'workspace_premium', categoryColor: 'grey', threshold: 100, progress: 0),
      Achievement(id: 'ach_monumental', title: 'Monumental', description: 'Reach a massive 365-day streak.', icon: 'account_balance', categoryColor: 'primary', threshold: 365, progress: 0),
      
      // Tier 2: Level Progression
      Achievement(id: 'ach_novice', title: 'Novice', description: 'Reach Level 5.', icon: 'spa', categoryColor: 'grey', threshold: 5, progress: 0),
      Achievement(id: 'ach_initiate', title: 'Initiate', description: 'Reach Level 10.', icon: 'school', categoryColor: 'primary', threshold: 10, progress: 0),
      Achievement(id: 'ach_acolyte', title: 'Acolyte', description: 'Reach Level 20.', icon: 'auto_awesome', categoryColor: 'secondary', threshold: 20, progress: 0),
      Achievement(id: 'ach_stalwart', title: 'Stalwart', description: 'Reach Level 30.', icon: 'shield', categoryColor: 'tertiary', threshold: 30, progress: 0),
      Achievement(id: 'ach_vanguard', title: 'Vanguard', description: 'Reach Level 40.', icon: 'military_tech', categoryColor: 'purple', threshold: 40, progress: 0),
      Achievement(id: 'ach_master', title: 'Master of Self', description: 'Reach Level 50.', icon: 'emoji_events', categoryColor: 'secondary', threshold: 50, progress: 0),

      // Tier 3 & 4: Daily Activity & Specialized
      Achievement(id: 'ach_kickstart', title: 'Kickstart', description: 'Complete your first habit of the day.', icon: 'rocket_launch', categoryColor: 'primary', threshold: 1, progress: 0),
      Achievement(id: 'ach_early_bird', title: 'Early Bird', description: 'Complete a habit before 8:00 AM.', icon: 'wb_sunny', categoryColor: 'secondary', threshold: 1, progress: 0),
      Achievement(id: 'ach_night_owl', title: 'Night Owl', description: 'Complete a habit after 9:00 PM.', icon: 'dark_mode', categoryColor: 'purple', threshold: 1, progress: 0),
      Achievement(id: 'ach_apex_day', title: 'Apex Day', description: 'Complete 8 or more habits in a single day.', icon: 'landscape', categoryColor: 'tertiary', threshold: 8, progress: 0),
    ];
  }




  void addFriend(Friend friend) {
    if (!_friends.any((f) => f.id == friend.id)) {
      _friends.add(friend);
      saveAllData();
      // Try to refresh friend data from their public profile
      _refreshFriendFromFirestore(friend.id);
      notifyListeners();
    }
  }

  Future<void> _refreshFriendFromFirestore(String uid) async {
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        final index = _friends.indexWhere((f) => f.id == uid);
        if (index != -1) {
          _friends[index] = Friend(
            id: uid,
            name: data['displayName'] ?? _friends[index].name,
            avatarUrl: data['photoUrl'] ?? _friends[index].avatarUrl,
            xp: data['xp'] ?? _friends[index].xp,
            streak: data['streak'] ?? _friends[index].streak,
          );
          saveAllData();
          notifyListeners();
        }
      }
    } catch (_) {}
  }

  void removeFriend(String id) {
    _friends.removeWhere((f) => f.id == id);
    saveAllData();
    notifyListeners();
  }
}
