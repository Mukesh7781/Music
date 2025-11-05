import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/song.dart';

class LocalStorage {
  static const String _favoritesKey = 'favorites';

  static Future<void> addFavorite(Song song) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];
    final songJson = json.encode(song.toJson());
    if (!favorites.contains(songJson)) {
      favorites.add(songJson);
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  static Future<void> removeFavorite(Song song) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];
    final songJson = json.encode(song.toJson());
    favorites.remove(songJson);
    await prefs.setStringList(_favoritesKey, favorites);
  }

  static Future<List<Song>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoritesJson = prefs.getStringList(_favoritesKey) ?? [];
    return favoritesJson.map((jsonStr) {
      final jsonMap = json.decode(jsonStr);
      return Song.fromJson(jsonMap);
    }).toList();
  }

  static Future<bool> isFavorite(Song song) async {
    final favorites = await getFavorites();
    return favorites.any((f) => f.trackId == song.trackId);
  }
}
