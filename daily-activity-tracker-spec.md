# Daily Activity Tracker — Product & Technical Specification

## 1. Overview

**Purpose:** A mobile app that lets a user track daily activities across any number of self-defined life areas (health, work, habits, learning, etc.) and reminds them to complete each one at the right time.

**Core promise:** One place to define what you want to do daily, get nudged at the right moment, and see your consistency over time.

**Platform target:** Native mobile (iOS + Android) or cross-platform (React Native / Flutter), since real push notifications require a native or near-native runtime — this is called out specifically in §6.

---

## 2. Core User Stories

- As a user, I can create a custom activity with a name, category, and optional scheduled time.
- As a user, I can mark an activity done/not done for today.
- As a user, I get a reminder (push notification) at the scheduled time if the activity isn't done yet.
- As a user, I can see my current and longest streak for each activity.
- As a user, I can see a day view (today's activities) and a history view (past days).
- As a user, I can define my own categories, not pick from a fixed list.
- As a user, I can edit, pause, or delete an activity without losing its history.
- As a user, I can see a weekly/monthly overview of completion rates.

---

## 3. Feature List

### 3.1 Activity management
| Feature | Description | Priority |
|---|---|---|
| Create activity | Name, category (free text), optional time, optional repeat pattern | Must |
| Edit activity | Change any field; history is preserved | Must |
| Delete activity | Soft delete recommended — keep history, hide from active list | Must |
| Pause/snooze activity | Temporarily stop reminders without deleting | Should |
| Categories | User-defined, auto-colored, reused via autocomplete | Must |
| Repeat pattern | Daily, specific weekdays, every N days, or "anytime" (no fixed time) | Must |
| Priority/importance flag | Optional, affects sort order or notification tone | Could |

### 3.2 Reminders & notifications
| Feature | Description | Priority |
|---|---|---|
| Time-based push notification | Fires at the activity's scheduled time | Must |
| Snooze from notification | 10/30/60 min snooze actions on the notification itself | Should |
| Mark done from notification | Complete the activity without opening the app | Should |
| Escalating reminder | Optional second nudge if still incomplete N minutes later | Could |
| Daily digest notification | Morning summary of everything scheduled today | Could |
| Quiet hours | User-defined window where no notifications fire | Should |

### 3.3 Tracking & history
| Feature | Description | Priority |
|---|---|---|
| Daily checklist view | Today's activities, sorted by time, with done/not-done state | Must |
| Streak counter | Consecutive days completed, per activity | Must |
| Calendar/heatmap view | Month grid showing completion density per day | Should |
| Weekly/monthly stats | Completion % per activity and overall | Should |
| Category breakdown | Completion rate grouped by category | Could |
| Notes per entry | Optional free-text note attached to a day's completion | Could |

### 3.4 Streaks (expanded)
| Feature | Description | Priority |
|---|---|---|
| Current streak | Consecutive days an activity was completed, up to and including today | Must |
| Longest streak | Best-ever streak per activity, kept even after it's broken | Must |
| Streak freeze / grace day | Limited "skip without breaking" tokens (e.g. 1-2 per month) so one missed day doesn't erase weeks of progress | Should |
| Overall streak | Consecutive days where *all* (or a chosen subset of) activities were completed — a "perfect day" streak | Should |
| Streak recovery window | Grace period (e.g. until 3am) before a missed day officially breaks a streak, for late-night completions | Could |
| Streak visibility | Shown on Today screen, Activity Detail, and as the number badge on the app icon (optional) | Should |

### 3.5 Achievements
| Feature | Description | Priority |
|---|---|---|
| Milestone badges | Auto-awarded at streak thresholds (e.g. 3, 7, 14, 30, 100, 365 days) per activity | Must |
| Consistency badges | Awarded for completion rate over a period (e.g. "90% completion this month") | Should |
| Variety badges | Awarded for using the app across categories (e.g. "Tracked activities in 5 different categories") | Could |
| Comeback badge | Awarded for resuming a streak after a break, to reward returning rather than punishing lapses | Could |
| Perfect day/week badge | All scheduled activities completed in a single day or week | Should |
| Achievement gallery | A screen showing earned badges, locked badges (with criteria hinted, not fully hidden), and progress toward the next one | Should |
| Unlock notification | Small celebratory notification/animation the moment a badge is earned | Should |
| Milestone notification | Separate from badges — a quick congrats push when a streak hits a round number, even if no formal badge exists at that number | Could |

**Design principle:** badges should reward *effort and consistency*, not just raw streak length — otherwise the system quietly punishes anyone who's had a rough week. A "comeback" badge and a "perfect week despite one freeze used" badge do more for long-term motivation than only ever rewarding unbroken streaks.

### 3.6 Planning (weekly & monthly)
| Feature | Description | Priority |
|---|---|---|
| Weekly planner view | Grid/list of the week, activities placed on specific days rather than "every day" | Should |
| Monthly planner view | Full month calendar showing every daily activity's completion status per day (a heatmap/dot per cell), *plus* the ability to add plans | Should |
| Monthly recurring plan | A plan item that recurs daily but only for a bounded period within the month (e.g. "Drink 2L water" for the next 21 days, or "No sugar" for July) — distinct from an `Activity`, which recurs indefinitely until paused | Should |
| Plan vs. actual | Overlay planned activities against what was actually completed, per week/month | Could |
| Recurring plan templates | Save a weekly layout as a template to reuse ("my normal week") | Could |
| Goals (non-daily) | Monthly targets not tied to a daily checklist (e.g. "read 2 books this month"), tracked separately from streak-based activities | Should |

### 3.7 Time tracking
| Feature | Description | Priority |
|---|---|---|
| Start/stop timer | Manual timer per task/habit, logs duration to that day's entry | Must |
| Manual time entry | Add/edit a duration after the fact, for when you forget to start the timer | Must |
| Daily time totals | Per-activity and total time tracked, shown on Today and Activity Detail | Must |
| Time-based reminders | "You haven't logged time on X today" nudge, separate from the done/not-done reminder | Should |
| Time goals | Optional daily/weekly target duration per activity (e.g. "30 min of reading/day") with progress bar | Should |
| Time history/trends | Chart of time spent per activity over the week/month | Could |

**Note:** this makes some activities dual-tracked — a simple done/not-done checkbox *and* a duration. The data model below adds a `durationSeconds` field to `DailyLog` so both can coexist on the same entry rather than needing a separate tracking system.

### 3.8 Friends & social
| Feature | Description | Priority |
|---|---|---|
| Add friends | Via username/invite link/QR code | Must |
| Friends list | See who you're connected with | Must |
| View friends' achievements | See badges friends have earned (not their raw daily activity list, by default — see privacy note) | Must |
| View friends' streaks | See current streak counts, if the friend has chosen to share them | Should |
| Leaderboard | Optional ranking among friends (longest streak, most badges, etc.) | Could |
| Cheer/react | Lightweight reaction (👏, 🔥) on a friend's new achievement | Could |
| Privacy controls | Per-user setting for what's visible to friends: nothing / achievements only / achievements + streaks / full activity list | Must |

**Privacy principle:** activity names can be personal (e.g. "Take medication," "Therapy homework"). Default new friend connections to **achievements-only visibility**, and make sharing streaks or full activity detail an explicit opt-in per activity, not a global toggle — some things a user tracks they won't want a friend to see even the *name* of, let alone the status.

### 3.9 Account & data
| Feature | Description | Priority |
|---|---|---|
| Local-first storage | App works fully offline | Must |
| Cloud sync / backup | Optional account so data survives device loss | Should |
| Export data | CSV/JSON export of history | Could |
| Multiple devices | Sync across phone/tablet | Could |

---

## 4. Data Model

```
User
 └─ id, name, timezone, quietHoursStart, quietHoursEnd

Activity
 ├─ id
 ├─ name (string, required)
 ├─ category (string, optional — free text, user-defined)
 ├─ color (derived from category, auto-assigned)
 ├─ time (HH:MM, optional — null means "anytime")
 ├─ repeatPattern (enum: daily | weekdays[] | everyNDays | anytime)
 ├─ startDate (date, optional — defaults to createdAt date)
 ├─ endDate (date, optional — null means indefinite; set this for a "recur daily for a month" plan, e.g. startDate=Jul 1, endDate=Jul 31)
 ├─ isActive (bool — false = paused)
 ├─ isArchived (bool — soft delete)
 ├─ createdAt (timestamp)
 └─ notificationSettings { enabled, snoozeAllowed, escalateAfterMin }

DailyLog
 ├─ id
 ├─ activityId (FK → Activity)
 ├─ date (YYYY-MM-DD)
 ├─ status (enum: done | skipped | missed)
 ├─ completedAt (timestamp, nullable)
 ├─ durationSeconds (int, nullable — for time-tracked activities)
 └─ note (string, optional)

TimeSession (raw timer log — supports multiple start/stops per day per activity)
 ├─ id
 ├─ activityId (FK → Activity)
 ├─ date (YYYY-MM-DD)
 ├─ startedAt, endedAt (timestamps)
 └─ durationSeconds (derived; rolled up into DailyLog.durationSeconds)

PlanEntry (weekly/monthly planner — for one-off items and non-daily goals only; recurring daily plans use Activity.startDate/endDate above)
 ├─ id
 ├─ title
 ├─ linkedActivityId (FK → Activity, nullable — link a one-off plan note to an existing tracked activity)
 ├─ scope (enum: week | month)
 ├─ periodKey (e.g. "2026-W28" or "2026-07")
 ├─ targetDate (nullable — for a specific-day plan item, e.g. "dentist appointment reminder on the 14th")
 └─ isGoal (bool — true for non-daily monthly goals like "read 2 books")

Friendship
 ├─ id
 ├─ userIdA, userIdB
 ├─ status (enum: pending | accepted | blocked)
 └─ createdAt

SharingSettings (per user, per friend OR global default)
 ├─ userId
 ├─ visibility (enum: none | achievementsOnly | achievementsAndStreaks | full)
 └─ perActivityOverrides (map of activityId → visibility, for exceptions)

Streak (derived, not stored — computed from DailyLog)
 ├─ current
 ├─ longest
 └─ freezesRemaining (resets monthly)

Achievement (definition, static/config data)
 ├─ id
 ├─ type (enum: streakMilestone | consistency | variety | comeback | perfectDay | perfectWeek)
 ├─ scope (enum: perActivity | global)
 ├─ threshold (e.g. 7, 30, 100 — days or %)
 ├─ title, description, icon

UserAchievement (join table — what's actually been earned)
 ├─ id
 ├─ achievementId (FK → Achievement)
 ├─ activityId (FK → Activity, nullable — null if global)
 ├─ earnedAt (timestamp)
 └─ seen (bool — for "new" badge indicators)
```

**Notes:**
- `DailyLog` is the append-only source of truth. Streaks, heatmaps, and completion stats are all derived from it — don't store streak counts directly, or they'll drift out of sync when history is edited.
- Soft-deleting activities (not hard-deleting) keeps historical stats accurate even after a user stops tracking something.
- Keep `Achievement` definitions in static config (a JSON list of badge rules), not the database — makes it trivial to add new badges in an app update without a migration.
- Achievement checks should run as a background pass whenever a `DailyLog` entry is written (i.e., whenever something is marked done), comparing current stats against unearned achievement thresholds.

---

## 5. Screens / IA (Information Architecture)

1. **Today** (home) — list of today's activities, sorted by time, "anytime" section at the bottom. Quick-tap to mark done; timer icon on time-tracked activities to start/stop.
2. **Add/Edit Activity** — form: name, category (autocomplete), time or "anytime" toggle, repeat pattern, notification settings, optional time goal.
3. **Weekly Planner** — 7-day grid, drag/tap to place activities or one-off plan items on specific days.
4. **Monthly Planner** — full-month calendar showing every daily activity's completion as a dot/heatmap per day (so you can see the whole month's consistency at a glance), plus the ability to add a new activity scoped to just that month (e.g. "No sugar — July") or a non-daily monthly goal. Also supports plan-vs-actual overlay.
5. **History** — calendar/heatmap view, tap a day to see what was done and time logged.
6. **Activity Detail** — single activity's streak, completion rate, time trend, history, edit/pause/delete actions.
7. **Stats/Insights** — weekly and monthly completion rates, time totals, best/worst categories, longest streaks.
8. **Achievements Gallery** — earned badges, locked badges with progress, milestone history.
9. **Friends** — friends list, add/invite, friend profile (their shared achievements/streaks per your privacy settings), optional leaderboard.
10. **Settings** — quiet hours, notification style, data export/backup, timezone, privacy/sharing defaults.

---

## 6. Reminders: Implementation Reality Check

This is the part most likely to trip up a first build, so it's worth being explicit:

- **True push/local notifications require a native app.** A web app (even installed as a PWA) cannot reliably fire notifications when it isn't open, especially on iOS. If you want notifications to work even when the phone is locked or the app is closed, you need:
  - React Native + `react-native-push-notification` / Expo Notifications (recommended if you want one codebase for iOS + Android), or
  - Native Swift (iOS) + Kotlin (Android) with local notification scheduling (`UNUserNotificationCenter` / `AlarmManager`).
- **Local notifications vs. push notifications:** since reminders are personal and don't need a server to trigger them, you likely want *local* notifications scheduled on-device (no backend required), not server-sent push. This simplifies the backend significantly.
- **Android battery optimization** can delay or kill scheduled notifications on some manufacturers (Xiaomi, Huawei, Samsung aggressive modes) — plan for a "disable battery optimization for this app" onboarding prompt.
- **iOS limits:** a maximum of 64 pending local notifications can be scheduled at once — if a user has many activities repeating daily, you'll need to reschedule in a rolling window (e.g., schedule the next 7 days, refresh daily) rather than scheduling indefinitely.

---

## 7. Suggested Tech Stack

| Layer | Recommended | Why |
|---|---|---|
| App framework | React Native (Expo) or Flutter | One codebase, mature local-notification support |
| Local storage | SQLite (via `expo-sqlite` / `drift` for Flutter) | Structured queries for streaks/history at scale |
| Notifications | Expo Notifications (or native `UNUserNotificationCenter`/`AlarmManager`) | Local scheduling, no backend needed for MVP |
| Backend | Supabase or Firebase | Friends/social requires a server — this is no longer optional once friends are in scope |
| Realtime updates (friends' achievements) | Supabase Realtime or Firestore listeners | Push new-badge updates to friends without polling |
| State management | Zustand/Redux (RN) or Riverpod/Provider (Flutter) | Predictable state for daily log updates |

**Note on scope:** adding friends changes the architecture more than any other feature in this doc — it's the one part of the spec that can't be offline-first. Everything else (activities, streaks, achievements, planner, time tracking) can be built fully local with no server. Consider shipping those as v1 fully offline, then layering in an account system + backend specifically to unlock friends in v2 — that keeps the core app usable and fast from day one, and avoids building auth/sync infrastructure before you know the core loop is worth using daily.

---

## 8. Build Phases

**Phase 1 — Core loop (MVP, fully offline)**
- Create/edit/delete activities (name, category, time or anytime)
- Today screen with mark-done
- Local notification at scheduled time
- Streak calculation (including current/longest, freeze tokens)
- Basic milestone achievements (streak thresholds only)

**Phase 2 — Retention features (still offline)**
- History/heatmap view
- Weekly stats
- Snooze/mark-done from notification
- Quiet hours
- Achievement gallery + full badge set (consistency, comeback, perfect day/week)
- Time tracker: start/stop timer, manual entry, daily totals, time goals
- Weekly planner
- Monthly planner + non-daily goals

**Phase 3 — Social layer (introduces backend)**
- Account creation/login
- Add friends, friend requests
- Sharing/privacy settings (default achievements-only)
- Friends list with shared achievements/streaks
- Leaderboard, cheer/react

**Phase 4 — Polish & scale**
- Cloud sync across devices
- Data export
- Category insights
- Escalating reminders
- Plan-vs-actual overlays

---

## 9. Open Questions to Resolve Before Building

- Should missed activities auto-reset the streak at midnight, or is there a grace period?
- Should "anytime" activities still send an end-of-day nudge if incomplete?
- Is multi-device sync a v1 requirement, or can it wait?
- iOS, Android, or both from day one?
- How many streak freezes per month feels fair without undermining the point of a streak?
- Should time-tracked activities require a goal duration, or is open-ended logging enough for v1?
- Should the weekly/monthly planner be mandatory (you must plan to use the app) or fully optional alongside the simpler recurring-activity model?
- For friends: is this invite-only (usernames/links) or discoverable (search by name)? Discoverable adds real privacy/safety design work.
- Should there be a limit on friends list size, or is it unbounded?
- Do you want the achievements list to be fixed/known in advance, or partially hidden ("mystery badges") to add surprise?

---

*This spec is intended as a working document — treat it as a starting checklist and adjust priorities (Must/Should/Could) as the build progresses.*
