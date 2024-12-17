import 'package:flutter/material.dart';

// Import your screens here
import 'package:calm/screens/assessments_screen.dart';
import 'package:calm/screens/chat_screen.dart';
import 'package:calm/screens/community_screen.dart';
import 'package:calm/screens/crisis_screen.dart';
import 'package:calm/screens/gamification_screen.dart';
import 'package:calm/screens/moodtracking_screen.dart';
import 'package:calm/screens/resources_screen.dart';
import 'package:calm/screens/therapist_screen.dart';

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
        '/chat_screen': (context) =>  ChatScreen(),
        '/community_screen': (context) =>  CommunityScreen(),
        '/crisis_screen': (context) => CrisisScreen(),
        '/gamification_screen': (context) => GamificationScreen(),
        '/moodtracking_screen': (context) => VideoList(),
        '/resources_screen': (context) => ResourcesScreen(),
        '/assessment_screen': (context) => AssessmentScreen(),
        '/therapist_screen': (context) => TherapistDirectoryScreen(),
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
      'route': '/userProfile',
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
      'name': 'Assessments',
      'icon': Icons.assignment,
      'route': '/assessments_screen',
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
