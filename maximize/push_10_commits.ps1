$ErrorActionPreference = "Stop"

$commits = @(
    @{ msg = "feat: implement dynamic light mode color engine"; files = "lib/widgets/chunky_colors.dart" },
    @{ msg = "feat: add theme toggle state management"; files = "lib/providers/app_state.dart" },
    @{ msg = "update: dynamic theme support for bottom nav"; files = "lib/widgets/bottom_nav_bar.dart" },
    @{ msg = "feat: create dummy sign up screen"; files = "lib/screens/signup_screen.dart" },
    @{ msg = "update: wire sign up routing and light mode"; files = "lib/screens/login_screen.dart" },
    @{ msg = "update: wire log out and theme toggle buttons"; files = "lib/screens/profile_screen.dart" },
    @{ msg = "fix: text visibility for light mode on social"; files = "lib/screens/friends_screen.dart" },
    @{ msg = "fix: widget default constructor constraints"; files = "lib/widgets/chunky_card.dart lib/widgets/chunky_button.dart" },
    @{ msg = "fix: remove strict const expressions for dynamic theme part 1"; files = "lib/screens/planner_screen.dart lib/screens/stats_screen.dart lib/screens/new_quest_screen.dart lib/screens/quest_detail_screen.dart lib/screens/badges_screen.dart" },
    @{ msg = "fix: remove strict const expressions for dynamic theme part 2"; files = "lib/main.dart lib/screens/today_screen.dart lib/widgets/heatmap_grid.dart lib/widgets/weekly_progress_chart.dart" }
)

$count = 1
foreach ($c in $commits) {
    Write-Host "Executing commit $count of 10..."
    $addCmd = "git add " + $c.files
    Invoke-Expression $addCmd
    git commit -m $c.msg
    git push
    $count++
}

# Just in case any other modified files were missed
git add .
git commit -m "chore: catch all remaining uncommitted changes"
git push

Write-Host "All pushes completed successfully!"
