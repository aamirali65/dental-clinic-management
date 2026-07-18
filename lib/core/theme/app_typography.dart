import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static TextTheme get _textTheme => GoogleFonts.plusJakartaSansTextTheme();

  static TextStyle get displayLarge => _textTheme.displayLarge!.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 57,
        height: 1.12,
        letterSpacing: -0.25,
      );

  static TextStyle get displayMedium => _textTheme.displayMedium!.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 45,
        height: 1.16,
      );

  static TextStyle get displaySmall => _textTheme.displaySmall!.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 36,
        height: 1.22,
      );

  static TextStyle get headlineLarge => _textTheme.headlineLarge!.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 32,
        height: 1.25,
      );

  static TextStyle get headlineMedium => _textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 28,
        height: 1.29,
      );

  static TextStyle get headlineSmall => _textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        height: 1.33,
      );

  static TextStyle get titleLarge => _textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 22,
        height: 1.27,
      );

  static TextStyle get titleMedium => _textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 1.50,
        letterSpacing: 0.15,
      );

  static TextStyle get titleSmall => _textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.1,
      );

  static TextStyle get labelLarge => _textTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.1,
      );

  static TextStyle get labelMedium => _textTheme.labelMedium!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.5,
      );

  static TextStyle get labelSmall => _textTheme.labelSmall!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 11,
        height: 1.45,
        letterSpacing: 0.5,
      );

  static TextStyle get bodyLarge => _textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1.50,
        letterSpacing: 0.5,
      );

  static TextStyle get bodyMedium => _textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.25,
      );

  static TextStyle get bodySmall => _textTheme.bodySmall!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.4,
      );

  static TextStyle get buttonLarge => GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 1.50,
        letterSpacing: 0.5,
      );

  static TextStyle get buttonMedium => GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.5,
      );

  static TextStyle get buttonSmall => GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.5,
      );

  static TextStyle get caption => GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.4,
      );

  static TextStyle get overline => GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w500,
        fontSize: 10,
        height: 1.60,
        letterSpacing: 1.5,
      );
}
