import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/chunky_colors.dart';
import '../widgets/chunky_button.dart';
import '../main.dart'; // To navigate to AppShell

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChunkyColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo (Flame)
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: const Icon(
                      Icons.local_fire_department,
                      color: ChunkyColors.primary,
                      size: 70.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  
                  // App Title
                  Text(
                    'Quest Log',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w900,
                      fontSize: 32.0,
                      color: ChunkyColors.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'HABIT TRACKER',
                    style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: ChunkyColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            
            // Bottom Sheet Area
            Container(
              decoration: const BoxDecoration(
                color: ChunkyColors.surfaceContainerHigh, // Dark grey instead of yellow for dark mode
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(32.0, 48.0, 32.0, 64.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                      color: ChunkyColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Forge your habits and conquer your day. Join us to track your daily quests and level up your life.',
                    style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      fontSize: 14.0,
                      color: ChunkyColors.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  
                  // Buttons side by side
                  Row(
                    children: [
                      Expanded(
                        child: ChunkyButton(
                          backgroundColor: Colors.black,
                          shadowColor: Colors.transparent, // Flat design like the image
                          borderColor: Colors.black,
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const AppShell()),
                            );
                          },
                          child: const Center(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: ChunkyButton(
                          backgroundColor: Colors.white,
                          shadowColor: Colors.transparent, // Flat design like the image
                          borderColor: Colors.white,
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const AppShell()),
                            );
                          },
                          child: const Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
