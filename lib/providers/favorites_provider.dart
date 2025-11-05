import 'package:flutter/material.dart';
import '../models/song.dart';
import '../services/local_storage.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Song> _favorites = [];

  List<Song> get favorites => _favorites;

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    _favorites = await LocalStorage.getFavorites();
    notifyListeners();
  }

  bool isFavorite(Song song) {
    return _favorites.any((fav) => fav.trackName == song.trackName);
  }

  Future<void> toggleFavorite(Song song) async {
    final isFav = isFavorite(song);
    if (isFav) {
      await LocalStorage.removeFavorite(song);
      _favorites.removeWhere((fav) => fav.trackName == song.trackName);
    } else {
      await LocalStorage.addFavorite(song);
      _favorites.add(song);
    }
    notifyListeners();
  }

  Future<void> removeFavorite(Song song) async {
    await LocalStorage.removeFavorite(song);
    _favorites.removeWhere((fav) => fav.trackName == song.trackName);
    notifyListeners();
  }
}
