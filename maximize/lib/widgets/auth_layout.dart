import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chunky_colors.dart';

class AuthLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final String subtitleAction;
  final VoidCallback onSubtitleActionTap;
  final Widget formContent;
  final String overlayTitle;
  final String overlaySubtitle;

  const AuthLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.subtitleAction,
    required this.onSubtitleActionTap,
    required this.formContent,
    required this.overlayTitle,
    required this.overlaySubtitle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Scaffold(
      backgroundColor: ChunkyColors.background,
      body: isDesktop
          ? Row(
              children: [
                // Left Column: Logo & Branding Writings
                Expanded(
                  flex: 5,
                  child: Container(
                    color: ChunkyColors.surfaceContainerLow,
                    padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 64.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.local_fire_department, color: ChunkyColors.primary, size: 48),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Maximize',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 32,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                Text(
                                  'LEVEL UP LIFE',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: ChunkyColors.primaryFixedDim,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 80),
                        Text(
                          overlayTitle,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          overlaySubtitle,
                          style: GoogleFonts.plusJakartaSans(
                            color: ChunkyColors.onSurfaceVariant,
                            fontSize: 18,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Right Column: Form
                Expanded(
                  flex: 6,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 96.0, vertical: 48.0),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 480),
                        child: _buildRightSideContent(context, isDesktop),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: _buildRightSideContent(context, isDesktop),
              ),
            ),
    );
  }

  Widget _buildRightSideContent(BuildContext context, bool isDesktop) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isDesktop) ...[
          Row(
            children: [
              Icon(Icons.local_fire_department, color: ChunkyColors.primary, size: 36),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Maximize',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    'LEVEL UP LIFE',
                    style: GoogleFonts.plusJakartaSans(
                      color: ChunkyColors.primaryFixedDim,
                      fontWeight: FontWeight.bold,
                      fontSize: 9,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
        Text(
          title,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              subtitle,
              style: GoogleFonts.outfit(
                color: ChunkyColors.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: onSubtitleActionTap,
                child: Text(
                  subtitleAction,
                  style: GoogleFonts.outfit(
                    color: ChunkyColors.primaryFixedDim,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        formContent,
      ],
    );
  }
}
