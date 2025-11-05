import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../models/song.dart';
import '../providers/favorites_provider.dart';
import 'song_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Song> _filteredFavorites = [];
  final TextEditingController _searchController = TextEditingController();

  void _filterFavorites(List<Song> allFavorites, String query) {
    final lowerQuery = query.toLowerCase();
    setState(() {
      _filteredFavorites = allFavorites.where((song) {
        return song.trackName.toLowerCase().contains(lowerQuery) ||
            song.artistName.toLowerCase().contains(lowerQuery);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      final provider = Provider.of<FavoritesProvider>(context, listen: false);
      _filterFavorites(provider.favorites, _searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favorites = favoritesProvider.favorites;
 final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDark = themeProvider.isDarkMode;
    // Apply filtering
    final displayedList = _searchController.text.isEmpty
        ? favorites
        : _filteredFavorites;

    return Container(
       decoration: BoxDecoration(
        gradient: themeProvider.backgroundGradient
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Favorites'),
         backgroundColor: Colors.transparent.withOpacity(0.2),
          elevation: 0,
          flexibleSpace: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ),
        ),
        
        body: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search your favourite songs...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor:
                      isDark ? const Color(0xFF444654) : Colors.grey[100],
                ),
              ),
            ),
      
            Expanded(
              child: displayedList.isEmpty
                  ? const Center(
                      child: Text('No favourites found.'),
                    )
                  : ListView.builder(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: displayedList.length,
                      itemBuilder: (context, index) {
                        final song = displayedList[index];
                        return InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SongDetailScreen(song: song),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Artwork
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    song.artworkUrl100,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? Colors.grey[800]
                                            : Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                      child: const Icon(Icons.music_note,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
      
                                // Song info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        song.trackName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        song.artistName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: Colors.grey),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
      
                                // Heart button to remove
                                IconButton(
                                  icon: const Icon(Icons.favorite,
                                      color: Color(0xFF1DB954)),
                                  onPressed: () =>
                                      favoritesProvider.removeFavorite(song),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
