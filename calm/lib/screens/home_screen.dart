import 'package:flutter/material.dart';

// Import your screens here
import 'package:calm/screens/fitness_tracker_page.dart';
import 'package:calm/screens/sound_list.dart';
import 'package:calm/screens/chat_screen.dart';
import 'package:calm/screens/community_screen.dart';
import 'package:calm/screens/crisis_screen.dart';
import 'package:calm/screens/gamification_screen.dart';
import 'package:calm/screens/moodtracking_screen.dart';
import 'package:calm/screens/resources_screen.dart';
import 'package:calm/screens/therapist_screen.dart';
import 'package:calm/screens/affirmation_screen.dart';
import 'package:calm/screens/post_screen.dart';




void main() {
  runApp(const MentalHealthApp());
}

class MentalHealthApp extends StatelessWidget {
  const MentalHealthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mental Health App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
      routes: {
        '/fitness_tracker_page': (context) => FitnessTrackerPage(),        
        '/affirmation_screen': (context) => DailyAffirmationPage(),        
        '/chat_screen': (context) =>  AIChatScreen(),
        '/community_screen': (context) =>  ChatCommunityScreen(),
        '/crisis_screen': (context) => WebViewPage(
                  url: 'https://findahelpline.com', 
                  title: 'Crisis Management',
                ),
        '/gamification_screen': (context) => MemoryCardGame(),
        '/moodtracking_screen': (context) => VideoList(),
        '/resources_screen': (context) => ResourcesScreen(),
        '/sound_list.dart': (context) => RelaxingSoundList(),
        '/therapist_screen': (context) => TherapistListScreen(),
        '/post_screen': (context) => PostListScreen(),

      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // Feature list with icons and routes
  final List<Map<String, dynamic>> features = const [
    {
      'name': 'User Profiles',
      'icon': Icons.person,
      'route': '/post_screen',
    },
    {
      'name': 'Daily Affirmations',
      'icon': Icons.auto_fix_high,
      'route': '/affirmation_screen',
    },
    {
      'name': 'Mood Tracking',
      'icon': Icons.emoji_emotions,
      'route': '/moodtracking_screen',
    },
    {
      'name': 'Self-Help Resources',
      'icon': Icons.library_books,
      'route': '/chat_screen',
    },
    {
      'name': 'Community Support',
      'icon': Icons.forum,
      'route': '/community_screen',
    },
    {
      'name': 'Professional Help',
      'icon': Icons.health_and_safety,
      'route': '/therapist_screen',
    },
    {
      'name': 'Crisis Management',
      'icon': Icons.phone_in_talk,
      'route': '/crisis_screen',
    },
    {
      'name': 'Gamification',
      'icon': Icons.star,
      'route': '/gamification_screen',
    },
    {
      'name': 'Relaxing Sounds',
      'icon': Icons.assignment,
      'route': '/sound_list',
    },
    {
      'name': 'Fitness Tracker',
      'icon': Icons.directions_walk,
      'route': '/fitness_tracker_page',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mental Health App'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, 
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: features.length,
          itemBuilder: (context, index) {
            final feature = features[index];
            return InkWell(
              onTap: () {
                debugPrint('Tapped on ${feature['name']}');
                if (feature['route'] != null) {
                  Navigator.pushNamed(context, feature['route']);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Feature not yet implemented!'),
                    ),
                  );
                }
              },
              borderRadius: BorderRadius.circular(16.0),
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      feature['icon'],
                      size: 50.0,
                      color: Colors.teal,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      feature['name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
