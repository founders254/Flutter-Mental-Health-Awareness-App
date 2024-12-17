import 'package:flutter/material.dart';
import 'package:calm/services/youtube_service.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late Future<List<Map<String, String>>> _videos;
  YoutubePlayerController? _controller; // Nullable controller

  @override
  void initState() {
    super.initState();
    _videos = YouTubeService().fetchMeditationVideos();
  }

  // Function to initialize the video player
  void _initializePlayer(String videoId) {
    // Dispose of the current player if it exists
    if (_controller != null) {
      _controller!.close(); // Properly close the existing controller
    }

    // Initialize a new controller for the selected video
    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,        
      ),
    );

    setState(() {}); // Refresh the UI to reflect the new player
  }

  @override
  void dispose() {
    _controller?.close(); // Dispose of the controller to free up resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guided Meditation Videos'),
      ),
      body: Column(
        children: [
          // Display the YouTube Player if the controller is not null
          if (_controller != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: YoutubePlayer(
                controller: _controller!,
                aspectRatio: 16 / 9, // Standard YouTube aspect ratio
              ),
            ),

          // Display the list of videos fetched from the service
          Expanded(
            child: FutureBuilder<List<Map<String, String>>>( 
              future: _videos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No videos available.'));
                }

                final videos = snapshot.data!;
                return ListView.builder(
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    final video = videos[index];
                    return ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          // Initialize the video player when the image is clicked
                          _initializePlayer(video['videoId']!);
                        },
                        child: Image.network(
                          'https://img.youtube.com/vi/${video['videoId']}/0.jpg', // Get thumbnail directly from YouTube
                          width: 120, // Fixed thumbnail width
                          height: 70, // Fixed thumbnail height
                          fit: BoxFit.cover, // Fit the image properly
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 120,
                              height: 70,
                              color: Colors.grey.shade300,
                              child: Icon(
                                Icons.play_arrow,
                                size: 50,
                                color: Colors.white,
                              ),
                            );
                          }, // Replace broken image icon with Play Video icon
                        ),
                      ),
                      title: Text(
                        video['title']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(Icons.play_arrow, color: Colors.blue),
                      onTap: () {
                        // Initialize a new video player with the selected video
                        _initializePlayer(video['videoId']!);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
