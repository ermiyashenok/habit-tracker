import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
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
  int _userXp = 2450;
  int get userXp => _userXp;
  int _userStreak = 12;
  int get userStreak => _userStreak;
  int _userBestStreak = 24;
  int get userBestStreak => _userBestStreak;
  int _level = 12;
  int get level => _level;
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
    _loadInitialData();
  }

  // Persistence methods
  Future<File> _getFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$fileName.json');
  }

  Future<void> _loadInitialData() async {
    try {
      final activitiesFile = await _getFile('activities');
      final logsFile = await _getFile('logs');
      final achievementsFile = await _getFile('achievements');

      if (await activitiesFile.exists()) {
        final content = await activitiesFile.readAsString();
        final List<dynamic> jsonList = jsonDecode(content);
        _activities = jsonList.map((e) => Activity.fromJson(e)).toList();
      } else {
        _activities = _getDefaultActivities();
      }

      if (await logsFile.exists()) {
        final content = await logsFile.readAsString();
        final List<dynamic> jsonList = jsonDecode(content);
        _dailyLogs = jsonList.map((e) => DailyLog.fromJson(e)).toList();
      } else {
        _dailyLogs = _getDefaultLogs();
      }

      if (await achievementsFile.exists()) {
        final content = await achievementsFile.readAsString();
        final List<dynamic> jsonList = jsonDecode(content);
        _achievements = jsonList.map((e) => Achievement.fromJson(e)).toList();
      } else {
        _achievements = _getDefaultAchievements();
      }
    } catch (e) {
      if (kDebugMode) print('Error loading data: $e');
      _activities = _getDefaultActivities();
      _dailyLogs = _getDefaultLogs();
      _achievements = _getDefaultAchievements();
    }

    _friends = _getDefaultFriends();
    _recalculateStreaks();
    notifyListeners();
  }

  Future<void> saveAllData() async {
    try {
      final activitiesFile = await _getFile('activities');
      final logsFile = await _getFile('logs');
      final achievementsFile = await _getFile('achievements');

      await activitiesFile.writeAsString(jsonEncode(_activities.map((e) => e.toJson()).toList()));
      await logsFile.writeAsString(jsonEncode(_dailyLogs.map((e) => e.toJson()).toList()));
      await achievementsFile.writeAsString(jsonEncode(_achievements.map((e) => e.toJson()).toList()));
    } catch (e) {
      if (kDebugMode) print('Error saving data: $e');
    }
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

    if (logIndex != -1) {
      final log = _dailyLogs[logIndex];
      _dailyLogs[logIndex] = log.copyWith(
        durationSeconds: log.durationSeconds + seconds,
        status: 'done', // if tracking duration, mark it done
        completedAt: log.completedAt ?? DateTime.now(),
      );
    } else {
      _dailyLogs.add(DailyLog(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        activityId: activityId,
        date: todayStr,
        status: 'done',
        completedAt: DateTime.now(),
        durationSeconds: seconds,
      ));
    }
    _recalculateStreaks();
    saveAllData();
  }

  void addActivity(Activity activity) {
    _activities.add(activity);
    saveAllData();
    _scheduleNotificationForActivity(activity);
    notifyListeners();
  }

  void updateActivity(Activity activity) {
    final index = _activities.indexWhere((a) => a.id == activity.id);
    if (index != -1) {
      _activities[index] = activity;
      saveAllData();
      _scheduleNotificationForActivity(activity);
      notifyListeners();
    }
  }

  void deleteActivity(String id) {
    final index = _activities.indexWhere((a) => a.id == id);
    if (index != -1) {
      _activities[index] = _activities[index].copyWith(isArchived: true);
      saveAllData();
      NotificationService().cancelReminder(id.hashCode);
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
      if (updated.isActive) {
        _scheduleNotificationForActivity(updated);
      } else {
        NotificationService().cancelReminder(id.hashCode);
      }
      notifyListeners();
    }
  }

  void _scheduleNotificationForActivity(Activity activity) {
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

    if (logIndex != -1) {
      final log = _dailyLogs[logIndex];
      if (log.status == 'done') {
        // Toggle off
        _dailyLogs[logIndex] = log.copyWith(
          status: 'missed',
          completedAt: null,
        );
      } else {
        // Toggle on
        _dailyLogs[logIndex] = log.copyWith(
          status: 'done',
          completedAt: DateTime.now(),
        );
        _awardXpForActivity(activityId);
      }
    } else {
      // Create new done log
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
    _userXp += activity.xpReward;
    _recalculateLevel();
  }

  void _recalculateLevel() {
    // Basic level calculation: level 1 = 0 XP, each level is 200 XP
    int newLevel = (_userXp / 200).floor();
    if (newLevel < 1) newLevel = 1;
    
    if (newLevel > _level) {
      // Reward 1 streak freeze per level up
      _totalEarnedFreezes += (newLevel - _level);
    }
    
    _level = newLevel;
  }

  void _recalculateStreaks() {
    // Computes overall streak and per-activity streaks from DailyLogs
    // For now, let's update userStreak and userBestStreak based on overall check-ins.
    // In a real app we trace the consecutive days of completed logs.
    // Let's compute actual streak of daily completion of at least one task.
    final completedDates = _dailyLogs
        .where((l) => l.status == 'done')
        .map((l) => l.date)
        .toSet()
        .toList();

    completedDates.sort((a, b) => b.compareTo(a)); // desc order

    if (completedDates.isEmpty) {
      _userStreak = 0;
      return;
    }

    int currentStreak = 0;
    int freezesUsed = 0;
    final int maxFreezes = _totalEarnedFreezes; // Freezes user has earned
    
    final today = DateTime.now();
    DateTime checkDate = today;

    while (true) {
      final dateStr = _formatDate(checkDate);
      if (completedDates.contains(dateStr)) {
        currentStreak++;
      } else {
        // If it's today and we haven't done it yet, it's not a broken streak yet.
        if (checkDate.year == today.year && checkDate.month == today.month && checkDate.day == today.day) {
          // Do nothing, continue to yesterday
        } else {
          if (freezesUsed < maxFreezes) {
            freezesUsed++;
            currentStreak++; // Grace day keeps the streak alive
          } else {
            break; // No freezes left, streak is broken
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

  // Default data generation
  List<Activity> _getDefaultActivities() {
    return [
      Activity(
        id: 'act_1',
        name: 'Morning Run',
        category: 'Health',
        time: '07:00',
        repeatPattern: 'daily',
        xpReward: 100,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      Activity(
        id: 'act_2',
        name: 'Deep Work Session',
        category: 'Work',
        time: '09:00',
        repeatPattern: 'daily',
        xpReward: 150,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      Activity(
        id: 'act_3',
        name: 'Learn Spanish',
        category: 'Mind',
        time: '13:00',
        repeatPattern: 'daily',
        xpReward: 120,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      Activity(
        id: 'act_4',
        name: 'Read 10 Pages',
        category: 'Mind',
        time: '20:00',
        repeatPattern: 'daily',
        xpReward: 80,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
    ];
  }

  List<DailyLog> _getDefaultLogs() {
    final logs = <DailyLog>[];
    final now = DateTime.now();

    // Populate past 30 days
    for (int i = 1; i <= 30; i++) {
      final date = now.subtract(Duration(days: i));
      final dateStr = _formatDate(date);

      // Simulate completion rates: Morning Run (70%), Deep Work (80%), Spanish (60%), Read (50%)
      if (i % 3 != 0) {
        logs.add(DailyLog(
          id: 'log_${i}_1',
          activityId: 'act_1',
          date: dateStr,
          status: 'done',
          completedAt: date,
          durationSeconds: 1800,
        ));
      }
      if (i % 4 != 0) {
        logs.add(DailyLog(
          id: 'log_${i}_2',
          activityId: 'act_2',
          date: dateStr,
          status: 'done',
          completedAt: date,
          durationSeconds: 5400,
        ));
      }
      if (i % 5 != 0) {
        logs.add(DailyLog(
          id: 'log_${i}_3',
          activityId: 'act_3',
          date: dateStr,
          status: 'done',
          completedAt: date,
          durationSeconds: 900,
        ));
      }
      if (i % 2 == 0) {
        logs.add(DailyLog(
          id: 'log_${i}_4',
          activityId: 'act_4',
          date: dateStr,
          status: 'done',
          completedAt: date,
          durationSeconds: 1200,
        ));
      }
    }

    // Add today's log - Morning Run is pre-completed
    logs.add(DailyLog(
      id: 'log_today_1',
      activityId: 'act_1',
      date: _formatDate(now),
      status: 'done',
      completedAt: now,
      durationSeconds: 1800,
    ));

    return logs;
  }

  List<Achievement> _getDefaultAchievements() {
    return [
      Achievement(
        id: 'ach_1',
        title: 'Firestarter',
        description: 'Complete 7-day streak of daily activities',
        icon: 'local_fire_department',
        categoryColor: 'secondary',
        isUnlocked: true,
        unlockedAt: DateTime.now().subtract(const Duration(days: 5)),
        threshold: 7,
        progress: 12,
      ),
      Achievement(
        id: 'ach_2',
        title: 'Night Owl',
        description: 'Complete a quest after 9:00 PM',
        icon: 'dark_mode',
        categoryColor: 'purple',
        isUnlocked: true,
        unlockedAt: DateTime.now().subtract(const Duration(days: 8)),
        threshold: 1,
        progress: 1,
      ),
      Achievement(
        id: 'ach_3',
        title: 'Socialite',
        description: 'Cheer on 3 friends after their quests',
        icon: 'group',
        categoryColor: 'tertiary',
        isUnlocked: true,
        unlockedAt: DateTime.now().subtract(const Duration(days: 2)),
        threshold: 3,
        progress: 3,
      ),
      Achievement(
        id: 'ach_4',
        title: 'Early Bird',
        description: 'Complete a quest before 8:00 AM',
        icon: 'wb_sunny',
        categoryColor: 'primary',
        isUnlocked: true,
        unlockedAt: DateTime.now().subtract(const Duration(days: 4)),
        threshold: 1,
        progress: 1,
      ),
      Achievement(
        id: 'ach_5',
        title: 'Jackpot',
        description: 'Complete all daily quests in a single day',
        icon: 'star',
        categoryColor: 'secondary',
        isUnlocked: true,
        unlockedAt: DateTime.now().subtract(const Duration(days: 12)),
        threshold: 1,
        progress: 1,
      ),
      Achievement(
        id: 'ach_6',
        title: 'Consistency King',
        description: 'Complete 15 daily quests this month',
        icon: 'trophy',
        categoryColor: 'grey',
        isUnlocked: false,
        threshold: 15,
        progress: 12,
      ),
      Achievement(
        id: 'ach_7',
        title: 'The Finisher',
        description: 'Reach a streak of 50 days in any activity',
        icon: 'military_tech',
        categoryColor: 'grey',
        isUnlocked: false,
        threshold: 50,
        progress: 42,
      ),
    ];
  }

  List<Friend> _getDefaultFriends() {
    return [
      Friend(
        id: 'friend_1',
        name: 'Alex Rivera',
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuACEZ1WBKs4GvsBmzcVy6P3DDYG7L4JLGmM0y-Cm6Xp5lQa3jQ_mxs2XU7o7a1cLaq04a65jDuyWx6ortg5RqP9A8EjHJDFh5oocsu7Qn7-MFMXxhC26tVyIz9wWk4rq-Py1a9XsyIyXmxpOUhKIyQM44KyV36Iuxwhuh0uR0ddoThFnibsOQTAE2EdRvcE3yuolsFVCiP_Wqkp4LTjSgL3GpSzOrSHK4eP0gkkv6XT5xoMXW6CqRhK-EahuLdTQTLMtw7GPEfP4e7S',
        points: 12400,
        streak: 42,
        recentActivity: 'completed Morning Yoga',
        recentActivityTime: '30m ago',
      ),
      Friend(
        id: 'friend_2',
        name: 'Sarah Chen',
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB8woGpjJatAxyCgA2o9DswLyh-rHj_VhmTxnmdG1dR-HVIKUoxEZdkJH3AzU6TsOPPbPz9ZAy3NEQoqWKlWI52e4pwSt0NLyRKRp67crGlnTuisL62mScDU-MUGTkyDTOgKdhbxuf69dcQJR0VkUjpc9Rgspci9feRXWxzHNQYDVbJkcfZiZWxhauGsBZ9tj4Y69acj3XfOJn7Z7qMtn0kXjKimOy5YUfNwisFR1Dc6NvKEuLKva8NoOYuiKIx8AollxtQIbFCjpju',
        points: 8450,
        streak: 15,
        recentActivity: 'earned the Early Bird badge!',
        recentActivityTime: '2h ago',
        badgeEarned: 'Early Bird Lv. 3',
        badgeIcon: 'wb_sunny',
        badgeCategory: 'New Badge',
      ),
      Friend(
        id: 'friend_3',
        name: 'Jordan Lee',
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDWJtltf9LyNby49oR2OYbyAstu64ao2GI0yTSS8rfE2oH7HjnXlqpItpPrFzQct_hnnK8d4Y9z5TEeJBdBYGdUwDMpQYyPDUCD6B_X9M26Cqn2pRLlIMRytL_6iu9i-7Uz2MwpoomeFwGOVv9Yv6JYh-xD5f9n5SlHfhz01o4f0JoFbNQfsmoUbG0C6AzaxBUBPcMLeQpjlqOuXom7qzw3hzl4zl2368619Wg1hpJN01TLeyatlznd23K2bp1h87flCQut1hiTGzlQ',
        points: 10150,
        streak: 28,
        recentActivity: 'completed 30 min of Deep Work',
        recentActivityTime: '3h ago',
      ),
      Friend(
        id: 'friend_4',
        name: 'Mika',
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAp8r6lTIfOqEwWVY-zEsgIVc-QfRbKZefgUrBxharFsU5GzUWM50Bu7gC8OEwZc15CbA4KvfUxPmwddwGd0kI7VoiA-ubEu83Z__7RnXCYoiJnZXH6X6_sTVsV0ud5_UBclZPJ1caZZyZiXiDd_GAwKhQzSHaUqP9Ge8V1Yc1TR4j9LZjPZE89-XEpBd9ZYYXnrfbmaSMEULE4O2MCU4USGR_zR8sAlcr6xTcwtFyXxsN29zHPladcLkzwLNlSe88xIRH8HwH50VaP',
        points: 5800,
        streak: 30,
        recentActivity: 'hit a 30 Day Streak!',
        recentActivityTime: '5h ago',
      ),
    ];
  }
}
