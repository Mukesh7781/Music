import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;
  ThemeProvider() {
    _loadThemePreference();
  }

  ThemeData get currentTheme => _isDarkMode ? _spotifyDarkTheme : _spotifyLightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
        _saveThemePreference();

    notifyListeners();
  }
   Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? true;
    notifyListeners();
  }

  Future<void> _saveThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  // Spotify Colors
  static const _spotifyGreen = Color(0xFF1DB954);
  static const _spotifyBlack = Color(0xFF191414);
  static const _spotifyDarkGray = Color(0xFF282828);
  static const _spotifyMediumGray = Color(0xFF535353);
  static const _spotifyLightGray = Color(0xFFB3B3B3);
  static const _spotifyWhite = Color(0xFFFFFFFF);

  static final _borderRadius = BorderRadius.circular(8);

  // Spotify Gradients
  static final _spotifyDarkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xFF404040), // Top gray gradient
      _spotifyBlack, // Bottom black
    ],
  );

  static final _spotifyLightGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xFFFAFAFA), // Almost white
    const Color(0xFFF5F5F5), // Light gray
    const Color(0xFFEEEEEE), // Medium gray
    const Color(0xFFE0E0E0), // Dark gray
    ],
  );

  // Gradient getter
  Gradient get backgroundGradient => _isDarkMode ? _spotifyDarkGradient : _spotifyLightGradient;

  // Spotify Dark Theme
  static final ThemeData _spotifyDarkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: _spotifyGreen,
    cardColor: _spotifyDarkGray,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: _spotifyWhite,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.poppins(
        color: _spotifyWhite,
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
    ),
    iconTheme: const IconThemeData(color: _spotifyLightGray),
    dividerColor: _spotifyMediumGray,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _spotifyDarkGray,
      hintStyle: GoogleFonts.poppins(color: _spotifyLightGray),
      border: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineSmall: GoogleFonts.poppins(
        color: _spotifyWhite,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: _spotifyWhite,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: _spotifyLightGray,
        fontSize: 13,
      ),
      titleMedium: GoogleFonts.poppins(
        color: _spotifyWhite,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: _spotifyLightGray,
      textColor: _spotifyWhite,
      tileColor: _spotifyDarkGray,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _spotifyGreen,
        foregroundColor: _spotifyBlack,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _spotifyGreen,
      foregroundColor: _spotifyBlack,
    ),
  );

  // Spotify Light Theme - Updated with white shades
  static final ThemeData _spotifyLightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: _spotifyGreen,
    cardColor: Colors.white.withOpacity(0.95), // Semi-transparent white
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: const Color(0xFF212529), // Dark gray for better contrast
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.poppins(
        color: const Color(0xFF212529),
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF6C757D)),
    dividerColor: const Color(0xFFE9ECEF),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.8), // Blended white
      hintStyle: GoogleFonts.poppins(color: const Color(0xFF6C757D)),
      border: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      labelStyle: GoogleFonts.poppins(color: const Color(0xFF495057)),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineSmall: GoogleFonts.poppins(
        color: const Color(0xFF212529),
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: const Color(0xFF212529),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: const Color(0xFF6C757D),
        fontSize: 13,
      ),
      titleMedium: GoogleFonts.poppins(
        color: const Color(0xFF212529),
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: const Color(0xFF6C757D),
      textColor: const Color(0xFF212529),
      tileColor: Colors.white.withOpacity(0.8), // Blended white
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _spotifyGreen,
        foregroundColor: Colors.white, // White text for better contrast
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _spotifyGreen,
      foregroundColor: Colors.white,
    ),
  );
}