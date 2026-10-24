import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color bg = Color(0xFFF5F6FA);
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFE8EAF0);
  static const Color primary = Color(0xFF2F5BEA);
  static const Color primarySoft = Color(0xFFE7EEFD);
  static const Color text = Color(0xFF111827);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color skeleton = Color(0xFFEDEFF5);
  static const Color error = Color(0xFFDC2626);
  static const Color errorSoft = Color(0xFFFEE2E2);
  static const Color imageBg = Color(0xFFF1F2F7);
  static const Color success = Color(0xFF16A34A);
  static const Color star = Color(0xFFF5B301);
}

ThemeData buildAppTheme() {
  TextStyle font(double size, FontWeight weight, Color color) {
    return GoogleFonts.ibmPlexSansThai(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      primaryContainer: AppColors.primarySoft,
      surface: AppColors.surface,
      onSurface: AppColors.text,
      onSurfaceVariant: AppColors.textMuted,
      outlineVariant: AppColors.border,
      surfaceContainerHighest: AppColors.skeleton,
      error: AppColors.error,
      errorContainer: AppColors.errorSoft,
      surfaceContainer: AppColors.imageBg,
    ),
    textTheme: ThemeData().textTheme.copyWith(
      titleLarge: font(20, FontWeight.w700, AppColors.text), // ชื่อแอปบน AppBar
      titleMedium: font(16, FontWeight.w700, AppColors.primary), // ราคา
      titleSmall: font(14, FontWeight.w600, AppColors.text), // ชื่อสินค้า
      labelLarge: font(14, FontWeight.w500, AppColors.primary), // ข้อความบนปุ่ม
      bodySmall: font(12, FontWeight.w400, AppColors.textMuted),
      headlineSmall: font(18, FontWeight.w700, AppColors.text),
    ),
  );
}
