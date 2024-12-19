import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class RelaxingSoundList extends StatefulWidget {
  @override
  _RelaxingSoundListState createState() => _RelaxingSoundListState();
}

class _RelaxingSoundListState extends State<RelaxingSoundList> {
  late Future<Map<String, List<Map<String, String>>>> _soundsByCategory;
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentAudioTitle;

  @override
  void initState() {
    super.initState();
    _soundsByCategory = fetchAllSounds(); // Fetch all categories of sounds
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudio(String audioUrl, String title) async {
    try {
      await _audioPlayer.setUrl(audioUrl);
      _audioPlayer.play();
      setState(() {
        _currentAudioTitle = title;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error playing audio: $e')),
      );
    }
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _currentAudioTitle = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nature Sounds'),
      ),
      body: Column(
        children: [
          if (_currentAudioTitle != null)
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.blue.shade100,
              child: Column(
                children: [
                  Text(
                    'Now Playing: $_currentAudioTitle',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.pause),
                        onPressed: () => _audioPlayer.pause(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.play_arrow),
                        onPressed: () => _audioPlayer.play(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.stop),
                        onPressed: _stopAudio,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          Expanded(
            child: FutureBuilder<Map<String, List<Map<String, String>>>>(
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
                              leading: const Icon(Icons.music_note, color: Colors.blue),
                              title: Text(
                                sound['title']!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: const Icon(Icons.play_arrow, color: Colors.blue),
                              onTap: () {
                                _playAudio(sound['videoId']!, sound['title']!);
                              },
                            )),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Replace with the updated YouTubeService function
  Future<Map<String, List<Map<String, String>>>> fetchAllSounds() async {
    // Dummy data for testing
    await Future.delayed(const Duration(seconds: 2)); // Simulate delay
    return {
      'Nature Sounds': [
        {'title': 'Relaxing Forest', 'videoId': 'https://example.com/audio1.mp3'},
        {'title': 'Gentle River', 'videoId': 'https://example.com/audio2.mp3'},
      ],
      'Rain Sounds': [
        {'title': 'Rain on Window', 'videoId': 'https://example.com/audio3.mp3'},
      ],
      'Thunderstorms': [
        {'title': 'Distant Thunder', 'videoId': 'https://example.com/audio4.mp3'},
      ],
      'Ocean Waves': [
        {'title': 'Beach Waves', 'videoId': 'https://example.com/audio5.mp3'},
      ],
      'Tin Roof Sounds': [
        {'title': 'Rain on Tin Roof', 'videoId': 'https://example.com/audio6.mp3'},
      ],
    };
  }
}
