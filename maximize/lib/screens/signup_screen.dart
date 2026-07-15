import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import '../main.dart'; // To navigate to AppShell
import 'login_screen.dart';
import '../widgets/auth_layout.dart';
import '../widgets/auth_components.dart';
import '../widgets/chunky_colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _agreeToTerms = false;

  Future<void> _signUpWithEmail() async {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields.')),
      );
      return;
    }
    
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the Terms & Conditions.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      await userCredential.user?.updateDisplayName('$firstName $lastName');

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AppShell()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Sign Up failed')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signUpWithGoogle() async {
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

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Create an account',
      subtitle: 'Already have an account?',
      subtitleAction: 'Log in',
      onSubtitleActionTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
      overlayTitle: 'Gamifying Habits,\nCreating Results',
      overlaySubtitle: 'Level up your daily life with epic quests.',
      formContent: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AuthTextField(
                  hintText: 'First name',
                  isPassword: false,
                  controller: _firstNameController,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AuthTextField(
                  hintText: 'Last name',
                  isPassword: false,
                  controller: _lastNameController,
                ),
              ),
            ],
          ),
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
          const SizedBox(height: 8),
          Row(
            children: [
              Checkbox(
                value: _agreeToTerms,
                onChanged: (val) {
                  setState(() {
                    _agreeToTerms = val ?? false;
                  });
                },
                activeColor: ChunkyColors.primary,
                checkColor: Colors.white,
                side: BorderSide(color: ChunkyColors.outline),
              ),
              Text(
                'I agree to the ',
                style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
              ),
              Text(
                'Terms & Conditions',
                style: GoogleFonts.outfit(
                  color: ChunkyColors.primaryFixedDim,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AuthButton(
            text: 'Create account',
            isLoading: _isLoading,
            onPressed: _signUpWithEmail,
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(child: Divider(color: ChunkyColors.outlineVariant)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Or register with',
                  style: GoogleFonts.outfit(
                    color: ChunkyColors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(child: Divider(color: ChunkyColors.outlineVariant)),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              SocialButton(
                text: 'Google',
                iconPath: 'assets/google.png',
                iconData: Icons.g_mobiledata, // Fallback if asset isn't found
                onPressed: _signUpWithGoogle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
