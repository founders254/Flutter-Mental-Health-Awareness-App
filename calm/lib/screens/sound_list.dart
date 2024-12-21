import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:calm/services/freesound_service.dart'; // Import the YouTubeService class

class RelaxingSoundList extends StatefulWidget {
  @override
  _RelaxingSoundListState createState() => _RelaxingSoundListState();
}

class _RelaxingSoundListState extends State<RelaxingSoundList> {
  late Future<Map<String, List<Map<String, String>>>> _soundsByCategory;

  @override
  void initState() {
    super.initState();
    _soundsByCategory = YouTubeService().fetchAllSounds(); // Fetch sounds from YouTubeService
  }

  void _playYouTubeVideo(String videoId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => YouTubePlayerScreen(videoId: videoId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relaxing Sounds'),
      ),
      body: FutureBuilder<Map<String, List<Map<String, String>>>>(
        future: _soundsByCategory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No sounds available.'));
          }

          final soundsByCategory = snapshot.data!;
          return ListView(
            children: soundsByCategory.entries.map((entry) {
              final category = entry.key;
              final sounds = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      category,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ...sounds.map((sound) => ListTile(
                        leading: Image.network(
                          sound['thumbnail']!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          sound['title']!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: const Icon(Icons.play_arrow, color: Colors.blue),
                        onTap: () {
                          _playYouTubeVideo(sound['videoId']!);
                        },
                      )),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class YouTubePlayerScreen extends StatefulWidget {
  final String videoId;

  const YouTubePlayerScreen({Key? key, required this.videoId}) : super(key: key);

  @override
  _YouTubePlayerScreenState createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        hideControls: false, // Show player controls
        disableDragSeek: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing'),
      ),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
    );
  }
}
