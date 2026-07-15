import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import '../main.dart'; // To navigate to AppShell
import 'signup_screen.dart';
import '../widgets/auth_layout.dart';
import '../widgets/auth_components.dart';
import '../widgets/chunky_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _loginWithEmail() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AppShell()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Login failed')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      if (kIsWeb) {
        final authProvider = GoogleAuthProvider();
        await FirebaseAuth.instance.signInWithPopup(authProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          if (mounted) setState(() => _isLoading = false);
          return;
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
      }

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AppShell()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loginAsGuest() async {
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signInAnonymously();
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AppShell()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Guest login failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Log in to account',
      subtitle: 'Don\'t have an account?',
      subtitleAction: 'Sign up',
      onSubtitleActionTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SignupScreen()),
        );
      },
      overlayTitle: 'Gamifying Habits,\nCreating Results',
      overlaySubtitle: 'Level up your daily life with epic quests.',
      formContent: Column(
        children: [
          AuthTextField(
            hintText: 'Email',
            isPassword: false,
            controller: _emailController,
          ),
          AuthTextField(
            hintText: 'Enter your password',
            isPassword: true,
            controller: _passwordController,
          ),
          const SizedBox(height: 16),
          AuthButton(
            text: 'Log in',
            isLoading: _isLoading,
            onPressed: _loginWithEmail,
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: _isLoading ? null : _loginAsGuest,
            child: Text(
              'Continue as Guest',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: ChunkyColors.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: Divider(color: ChunkyColors.outlineVariant)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Or log in with',
                  style: GoogleFonts.outfit(
                    color: ChunkyColors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(child: Divider(color: ChunkyColors.outlineVariant)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              SocialButton(
                text: 'Google',
                iconPath: 'assets/google.png',
                iconData: Icons.g_mobiledata, // Fallback if asset isn't found
                onPressed: _loginWithGoogle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
