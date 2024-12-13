import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // Feature list with icons and routes
  final List<Map<String, dynamic>> features = [
    {
      'name': 'User Profiles',
      'icon': Icons.person,
      'route': '/userProfile',
    },
    {
      'name': 'Mood Tracking',
      'icon': Icons.emoji_emotions,
      'route': '/moodTracking',
    },
    {
      'name': 'Self-Help Resources',
      'icon': Icons.library_books,
      'route': '/selfHelp',
    },
    {
      'name': 'Community Support',
      'icon': Icons.forum,
      'route': '/communitySupport',
    },
    {
      'name': 'Professional Help',
      'icon': Icons.health_and_safety,
      'route': '/professionalHelp',
    },
    {
      'name': 'Crisis Management',
      'icon': Icons.phone_in_talk,
      'route': '/crisisManagement',
    },
    {
      'name': 'Gamification',
      'icon': Icons.star,
      'route': '/gamification',
    },
    {
      'name': 'Assessments',
      'icon': Icons.assignment,
      'route': '/assessments',
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
            crossAxisCount: 3, // Two items per row
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: features.length,
          itemBuilder: (context, index) {
            final feature = features[index];
            return GestureDetector(
              onTap: () {
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
