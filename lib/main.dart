import 'package:flutter/material.dart';
import 'package:music_app/screens/splashscreen.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/favorites_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Music Explorer',
      theme: themeProvider.currentTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
