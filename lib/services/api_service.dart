import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/song.dart';

class ApiService {
  static const String baseUrl = 'https://itunes.apple.com/search';
  static const int limit = 50;

  Future<List<Song>> searchSongs(String term, {int offset = 0}) async {
    final url = Uri.parse('$baseUrl?term=${Uri.encodeComponent(term)}&entity=song&limit=$limit&offset=$offset');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'] ?? [];
        return results.map((json) => Song.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load songs');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // FIXED: Return only new songs, not the merged list
  Future<List<Song>> loadMoreSongs(String term, List<Song> currentSongs) async {
    int newOffset = currentSongs.length;
    final newSongs = await searchSongs(term, offset: newOffset);
    
    // Remove duplicates by trackId
    final Set<int> existingIds = currentSongs.map((s) => s.trackId).toSet();
    final uniqueNewSongs = newSongs.where((s) => !existingIds.contains(s.trackId)).toList();
    
    return uniqueNewSongs; // Return only the new unique songs
  }
}