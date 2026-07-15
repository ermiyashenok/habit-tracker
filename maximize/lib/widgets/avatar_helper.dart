import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chunky_colors.dart';

Widget buildAvatarWidget(String? url, {double size = 48, String? fallbackLetter}) {
  final letter = (fallbackLetter != null && fallbackLetter.isNotEmpty) 
      ? fallbackLetter[0].toUpperCase() 
      : 'A';

  Widget fallbackWidget = Center(
    child: Text(
      letter,
      style: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.bold,
        fontSize: size * 0.42,
        color: ChunkyColors.outline,
      ),
    ),
  );

  if (url == null || url.isEmpty) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ChunkyColors.surfaceContainerHigh,
      ),
      child: fallbackWidget,
    );
  }

  if (url.startsWith('data:image')) {
    try {
      final base64Str = url.split(',').last;
      final bytes = base64Decode(base64Str);
      return ClipOval(
        child: Image.memory(
          bytes,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: ChunkyColors.surfaceContainerHigh,
            child: fallbackWidget,
          ),
        ),
      );
    } catch (_) {
      return Container(
        width: size,
        height: size,
        color: ChunkyColors.surfaceContainerHigh,
        child: fallbackWidget,
      );
    }
  }

  return ClipOval(
    child: Image.network(
      url,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: ChunkyColors.surfaceContainerHigh,
        child: fallbackWidget,
      ),
    ),
  );
}

DecorationImage? getAvatarDecorationImage(String? url) {
  if (url == null || url.isEmpty || url.startsWith('data:image')) {
    return null;
  }
  return DecorationImage(
    image: NetworkImage(url),
    fit: BoxFit.cover,
  );
}
