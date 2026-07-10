import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/chunky_colors.dart';
import '../widgets/chunky_button.dart';
import '../main.dart'; // To navigate to AppShell
import 'login_screen.dart'; // To navigate back

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChunkyColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ChunkyColors.onSurface),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Create Account',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w900,
                  fontSize: 32.0,
                  color: ChunkyColors.onSurface,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Join Quest Log and start your journey.',
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontSize: 14.0,
                  color: ChunkyColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 48.0),
              
              // Username
              _buildTextField('Username', Icons.person),
              const SizedBox(height: 16.0),
              
              // Email
              _buildTextField('Email Address', Icons.email),
              const SizedBox(height: 16.0),
              
              // Password
              _buildTextField('Password', Icons.lock, obscureText: true),
              const SizedBox(height: 32.0),
              
              // Sign Up Button
              ChunkyButton(
                backgroundColor: ChunkyColors.primary,
                shadowColor: ChunkyColors.primaryContainer,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const AppShell()),
                  );
                },
                child: const Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon, {bool obscureText = false}) {
    return Container(
      decoration: BoxDecoration(
        color: ChunkyColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: ChunkyColors.surfaceContainerHighest, width: 2.0),
      ),
      child: TextField(
        obscureText: obscureText,
        style: TextStyle(color: ChunkyColors.onSurface),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: ChunkyColors.outline),
          prefixIcon: Icon(icon, color: ChunkyColors.outline),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
      ),
    );
  }
}
