import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class YouTubeService {
  final String apiKey = 'AIzaSyDw7F4oaYf-I-wblze0d2NxfscoC6LS4g0';
  final String baseUrl = 'https://www.googleapis.com/youtube/v3/search';
  final cacheManager = DefaultCacheManager();

  // Check for internet connectivity
  Future<bool> _isConnected() async {
    var result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Future<List<Map<String, String>>> fetchMeditationVideos() async {
    final url = Uri.parse(
        '$baseUrl?part=snippet&q=guided+meditation&type=video&maxResults=100&key=$apiKey');

    // Check network connectivity
    if (!(await _isConnected())) {
      throw Exception('No internet connection. Please check your network.');
    }

    // Attempt to retrieve data from cache
    try {
      final file = await cacheManager.getSingleFile(url.toString());
      final response = await file.readAsString();

      return _parseResponse(response);
    } catch (e) {
      // If cache fetch fails, get data from the network
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Store the response in cache
        await cacheManager.putFile(url.toString(), response.bodyBytes);
        return _parseResponse(response.body);
      } else {
        throw Exception('Failed to load videos');
      }
    }
  }

  // Helper method to parse response
  List<Map<String, String>> _parseResponse(String responseBody) {
  final data = json.decode(responseBody);
  final videos = data['items'] as List;

  return videos.map((video) {
    final videoId = video['id']['videoId'] as String;
    final snippet = video['snippet'] as Map<String, dynamic>;

    return {
      'videoId': videoId,
      'title': snippet['title'] as String,
      'thumbnail': snippet['thumbnails']['high']['url'] as String, // Use 'high' quality thumbnail
    };
  }).toList();
}

}
