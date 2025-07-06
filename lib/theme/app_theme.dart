import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the application.
class AppTheme {
  AppTheme._();

  // Cinema-focused color palette
  static const Color primaryDark =
      Color(0xFF1A1A1A); // Deep charcoal background
  static const Color secondaryDark =
      Color(0xFF2D2D2D); // Elevated surface color
  static const Color accentColor =
      Color(0xFFFF6B35); // Warm orange for interactions
  static const Color surfaceDark = Color(0xFF121212); // True dark surface
  static const Color textPrimary = Color(0xFFFFFFFF); // Pure white text
  static const Color textSecondary = Color(0xFFB3B3B3); // Muted gray text
  static const Color successColor = Color(0xFF4CAF50); // Standard green
  static const Color warningColor = Color(0xFFFF9800); // Amber for warnings
  static const Color errorColor = Color(0xFFF44336); // Clear red for errors
  static const Color dividerColor = Color(0xFF333333); // Subtle separator

  // Card and dialog colors
  static const Color cardDark = Color(0xFF2D2D2D);
  static const Color dialogDark = Color(0xFF2D2D2D);

  // Shadow colors with 20% opacity
  static const Color shadowDark = Color(0x33000000);

  // Text emphasis colors
  static const Color textHighEmphasisDark = Color(0xDEFFFFFF); // 87% opacity
  static const Color textMediumEmphasisDark = Color(0x99FFFFFF); // 60% opacity
  static const Color textDisabledDark = Color(0x61FFFFFF); // 38% opacity

  /// Dark theme optimized for cinema content
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: accentColor,
          onPrimary: textPrimary,
          primaryContainer: accentColor.withValues(alpha: 0.2),
          onPrimaryContainer: textPrimary,
          secondary: secondaryDark,
          onSecondary: textPrimary,
          secondaryContainer: secondaryDark,
          onSecondaryContainer: textPrimary,
          tertiary: warningColor,
          onTertiary: primaryDark,
          tertiaryContainer: warningColor.withValues(alpha: 0.2),
          onTertiaryContainer: textPrimary,
          error: errorColor,
          onError: textPrimary,
          surface: surfaceDark,
          onSurface: textPrimary,
          onSurfaceVariant: textSecondary,
          outline: dividerColor,
          outlineVariant: dividerColor.withValues(alpha: 0.5),
          shadow: shadowDark,
          scrim: primaryDark.withValues(alpha: 0.8),
          inverseSurface: textPrimary,
          onInverseSurface: primaryDark,
          inversePrimary: primaryDark),
      scaffoldBackgroundColor: primaryDark,
      cardColor: cardDark,
      dividerColor: dividerColor,

      // Contextual App Bar with adaptive opacity
      appBarTheme: AppBarTheme(
          backgroundColor: primaryDark.withValues(alpha: 0.95),
          foregroundColor: textPrimary,
          elevation: 0,
          scrolledUnderElevation: 2,
          shadowColor: shadowDark,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: GoogleFonts.inter(
              fontSize: 20, fontWeight: FontWeight.w600, color: textPrimary)),

      // Enhanced card theme for movie content
      cardTheme: CardTheme(
          color: cardDark,
          elevation: 2.0,
          shadowColor: shadowDark,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),

      // Bottom navigation optimized for one-handed use
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: secondaryDark,
          selectedItemColor: accentColor,
          unselectedItemColor: textSecondary,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          selectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400)),

      // Floating action patterns for primary actions
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: accentColor,
          foregroundColor: textPrimary,
          elevation: 6,
          focusElevation: 8,
          hoverElevation: 8,
          highlightElevation: 12,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0))),

      // Button themes with micro-interaction feedback
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: textPrimary,
              backgroundColor: accentColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              elevation: 2,
              shadowColor: shadowDark,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: accentColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              side: BorderSide(color: accentColor, width: 1.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: accentColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),

      // Typography using Inter font family
      textTheme: _buildTextTheme(),

      // Form elements with focused states
      inputDecorationTheme: InputDecorationTheme(
          fillColor: secondaryDark,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: dividerColor, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: dividerColor, width: 1)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: accentColor, width: 2)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: errorColor, width: 1)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: errorColor, width: 2)),
          labelStyle: GoogleFonts.inter(color: textSecondary, fontSize: 16, fontWeight: FontWeight.w400),
          hintStyle: GoogleFonts.inter(color: textDisabledDark, fontSize: 16, fontWeight: FontWeight.w400),
          prefixIconColor: textSecondary,
          suffixIconColor: textSecondary),

      // Interactive elements with cinema-appropriate colors
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentColor;
        }
        return textSecondary;
      }), trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentColor.withValues(alpha: 0.5);
        }
        return dividerColor;
      })),
      checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return accentColor;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(textPrimary),
          side: BorderSide(color: dividerColor, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentColor;
        }
        return dividerColor;
      })),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: accentColor, linearTrackColor: dividerColor, circularTrackColor: dividerColor),
      sliderTheme: SliderThemeData(activeTrackColor: accentColor, thumbColor: accentColor, overlayColor: accentColor.withValues(alpha: 0.2), inactiveTrackColor: dividerColor, valueIndicatorColor: accentColor, valueIndicatorTextStyle: GoogleFonts.jetBrainsMono(color: textPrimary, fontSize: 14, fontWeight: FontWeight.w500)),

      // Tab bar for content navigation
      tabBarTheme: TabBarTheme(labelColor: accentColor, unselectedLabelColor: textSecondary, indicatorColor: accentColor, indicatorSize: TabBarIndicatorSize.label, labelStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600), unselectedLabelStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400)),

      // Tooltip theme for additional information
      tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(color: secondaryDark.withValues(alpha: 0.95), borderRadius: BorderRadius.circular(8), boxShadow: [
            BoxShadow(
                color: shadowDark, blurRadius: 8, offset: const Offset(0, 2)),
          ]),
          textStyle: GoogleFonts.inter(color: textPrimary, fontSize: 14, fontWeight: FontWeight.w400),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),

      // Snack bar for feedback
      snackBarTheme: SnackBarThemeData(backgroundColor: secondaryDark, contentTextStyle: GoogleFonts.inter(color: textPrimary, fontSize: 16, fontWeight: FontWeight.w400), actionTextColor: accentColor, behavior: SnackBarBehavior.floating, elevation: 6, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),

      // Bottom sheet theme for adaptive modal content
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: dialogDark, elevation: 8, modalElevation: 16, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))), clipBehavior: Clip.antiAliasWithSaveLayer),

      // Dialog theme
      dialogTheme: DialogTheme(backgroundColor: dialogDark, elevation: 8, shadowColor: shadowDark, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), titleTextStyle: GoogleFonts.inter(color: textPrimary, fontSize: 20, fontWeight: FontWeight.w600), contentTextStyle: GoogleFonts.inter(color: textPrimary, fontSize: 16, fontWeight: FontWeight.w400)),

      // List tile theme for content lists
      listTileTheme: ListTileThemeData(tileColor: Colors.transparent, selectedTileColor: accentColor.withValues(alpha: 0.1), iconColor: textSecondary, textColor: textPrimary, selectedColor: accentColor, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))));

  /// Light theme (minimal implementation for fallback)
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryDark,
          onPrimary: textPrimary,
          primaryContainer: primaryDark.withValues(alpha: 0.1),
          onPrimaryContainer: primaryDark,
          secondary: secondaryDark,
          onSecondary: textPrimary,
          secondaryContainer: secondaryDark.withValues(alpha: 0.1),
          onSecondaryContainer: primaryDark,
          tertiary: accentColor,
          onTertiary: textPrimary,
          tertiaryContainer: accentColor.withValues(alpha: 0.1),
          onTertiaryContainer: primaryDark,
          error: errorColor,
          onError: textPrimary,
          surface: textPrimary,
          onSurface: primaryDark,
          onSurfaceVariant: textSecondary,
          outline: dividerColor,
          outlineVariant: dividerColor.withValues(alpha: 0.5),
          shadow: shadowDark,
          scrim: primaryDark.withValues(alpha: 0.8),
          inverseSurface: primaryDark,
          onInverseSurface: textPrimary,
          inversePrimary: accentColor),
      textTheme: _buildTextTheme(isLight: true));

  /// Build text theme using Inter and JetBrains Mono fonts
  static TextTheme _buildTextTheme({bool isLight = false}) {
    final Color textColor = isLight ? primaryDark : textPrimary;
    final Color textColorSecondary =
        isLight ? primaryDark.withValues(alpha: 0.7) : textSecondary;
    final Color textColorDisabled =
        isLight ? primaryDark.withValues(alpha: 0.38) : textDisabledDark;

    return TextTheme(
        // Display styles for large headings
        displayLarge: GoogleFonts.inter(
            fontSize: 57,
            fontWeight: FontWeight.w400,
            color: textColor,
            letterSpacing: -0.25),
        displayMedium: GoogleFonts.inter(
            fontSize: 45, fontWeight: FontWeight.w400, color: textColor),
        displaySmall: GoogleFonts.inter(
            fontSize: 36, fontWeight: FontWeight.w400, color: textColor),

        // Headline styles for section headers
        headlineLarge: GoogleFonts.inter(
            fontSize: 32, fontWeight: FontWeight.w600, color: textColor),
        headlineMedium: GoogleFonts.inter(
            fontSize: 28, fontWeight: FontWeight.w600, color: textColor),
        headlineSmall: GoogleFonts.inter(
            fontSize: 24, fontWeight: FontWeight.w600, color: textColor),

        // Title styles for cards and dialogs
        titleLarge: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textColor,
            letterSpacing: 0),
        titleMedium: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
            letterSpacing: 0.15),
        titleSmall: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
            letterSpacing: 0.1),

        // Body text for content
        bodyLarge: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textColor,
            letterSpacing: 0.5),
        bodyMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textColor,
            letterSpacing: 0.25),
        bodySmall: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textColorSecondary,
            letterSpacing: 0.4),

        // Label styles for buttons and form elements
        labelLarge: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
            letterSpacing: 0.1),
        labelMedium: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textColor,
            letterSpacing: 0.5),
        labelSmall: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: textColorDisabled,
            letterSpacing: 0.5));
  }

  /// Data text style using JetBrains Mono for ratings and numerical data
  static TextStyle dataTextStyle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    bool isLight = false,
  }) {
    return GoogleFonts.jetBrainsMono(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? (isLight ? primaryDark : textPrimary),
        letterSpacing: 0.25);
  }

  /// Custom box decoration for glassmorphism effects
  static BoxDecoration glassmorphismDecoration({
    Color? backgroundColor,
    double borderRadius = 12,
    double blurRadius = 10,
  }) {
    return BoxDecoration(
        color: backgroundColor ?? secondaryDark.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(borderRadius),
        border:
            Border.all(color: dividerColor.withValues(alpha: 0.2), width: 1),
        boxShadow: [
          BoxShadow(
              color: shadowDark,
              blurRadius: blurRadius,
              offset: const Offset(0, 4)),
        ]);
  }

  /// Custom box decoration for elevated cards
  static BoxDecoration elevatedCardDecoration({
    Color? backgroundColor,
    double borderRadius = 12,
    double elevation = 2,
  }) {
    return BoxDecoration(
        color: backgroundColor ?? cardDark,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
              color: shadowDark,
              blurRadius: elevation * 2,
              offset: Offset(0, elevation)),
        ]);
  }
}
