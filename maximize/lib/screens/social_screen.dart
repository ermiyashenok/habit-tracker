import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/chunky_colors.dart';
import '../providers/app_state.dart';
import 'friends_screen.dart';
import 'badges_screen.dart';

class SocialScreen extends StatelessWidget {
  final AppState state;

  const SocialScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: ChunkyColors.background,
            child: TabBar(
              indicatorColor: ChunkyColors.primary,
              indicatorWeight: 4,
              labelColor: ChunkyColors.onSurface,
              unselectedLabelColor: ChunkyColors.outline,
              labelStyle: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
              tabs: const [
                Tab(text: 'Friends'),
                Tab(text: 'Badges'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                FriendsScreen(state: state),
                BadgesScreen(state: state),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
