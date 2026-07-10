import 'package:flutter/material.dart';

class ChunkyColors {
  static bool isLightMode = false;

  // Primary Flame Orange (same for both)
  static Color get primary => const Color(0xFFFF5A00);
  static Color get primaryContainer => isLightMode ? const Color(0xFFFFEDD5) : const Color(0xFF3A1A0B);
  static Color get primaryFixedDim => const Color(0xFFFF9A00);
  
  // Backgrounds & Surfaces
  static Color get background => isLightMode ? const Color(0xFFF8FAFC) : const Color(0xFF03050A);
  static Color get surface => isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF03050A);
  static Color get surfaceContainerLow => isLightMode ? const Color(0xFFF1F5F9) : const Color(0xFF0A0F1C);
  static Color get surfaceContainerHigh => isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF111726);
  static Color get surfaceContainerHighest => isLightMode ? const Color(0xFFE2E8F0) : const Color(0xFF1A2235);
  static Color get surfaceCard => isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF111726);
  
  // Borders & Outlines
  static Color get outline => isLightMode ? const Color(0xFF64748B) : const Color(0xFF64748B);
  static Color get outlineVariant => isLightMode ? const Color(0xFFE2E8F0) : const Color(0xFF333E54);
  static Color get darkBorder => isLightMode ? const Color(0xFFCBD5E1) : const Color(0xFF1A2235);
  
  // Text Colors
  static Color get onSurface => isLightMode ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9);
  static Color get onSurfaceVariant => isLightMode ? const Color(0xFF475569) : const Color(0xFF94A3B8);
  
  // Secondary (Blue)
  static Color get secondary => const Color(0xFF3B82F6);
  static Color get secondaryContainer => isLightMode ? const Color(0xFFDBEAFE) : const Color(0xFF101E36);
  static Color get secondaryFixed => const Color(0xFF60A5FA);
  
  // Tertiary (Green)
  static Color get tertiary => const Color(0xFF10B981);
  static Color get tertiaryContainer => isLightMode ? const Color(0xFFD1FAE5) : const Color(0xFF062A1D);
  static Color get tertiaryFixed => const Color(0xFF34D399);
  
  // Accents
  static Color get purple => const Color(0xFF6366F1);
  static Color get errorRed => const Color(0xFFEF4444);
}
