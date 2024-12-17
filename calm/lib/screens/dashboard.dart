import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardScreen extends StatelessWidget {
  final String userId; // Pass user ID to fetch user-specific data

  DashboardScreen({required this.userId});

  // Fetch user data from Firestore
  Future<Map<String, dynamic>?> fetchUserData(String userId) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return doc.data();
  }

  // Get motivational quote (static for now, can integrate Firestore later)
  String getMotivationalQuote() {
    return "Your mental health is a priority. You matter!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchUserData(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No user data found'));
          }

          final userData = snapshot.data!;
          final String name = userData['name'] ?? 'User';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                // Greeting Section
                Text(
                  'Hello, $name!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'How are you feeling today?',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),

                // Quick Actions Section
                Text(
                  'Quick Actions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildActionCard(
                      context,
                      title: 'Mood Tracking',
                      icon: Icons.emoji_emotions,
                      color: Colors.orange,
                      onTap: () {
                        Navigator.pushNamed(context, '/mood-tracking');
                      },
                    ),
                    _buildActionCard(
                      context,
                      title: 'Self-Help Resources',
                      icon: Icons.book,
                      color: Colors.blue,
                      onTap: () {
                        Navigator.pushNamed(context, '/resources');
                      },
                    ),
                    _buildActionCard(
                      context,
                      title: 'Community Support',
                      icon: Icons.group,
                      color: Colors.green,
                      onTap: () {
                        Navigator.pushNamed(context, '/community');
                      },
                    ),
                    _buildActionCard(
                      context,
                      title: 'Professional Help',
                      icon: Icons.local_hospital,
                      color: Colors.red,
                      onTap: () {
                        Navigator.pushNamed(context, '/professional-help');
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Motivational Quote Section
                Text(
                  'Motivational Quote',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    getMotivationalQuote(),
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                ),
                SizedBox(height: 16),

                // User Stats Section
                Text(
                  'Your Progress',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatCard('Mood Logs', userData['mood_logs']?.length ?? 0),
                    _buildStatCard('Completed Goals', userData['goals']?.length ?? 0),
                  ],
                ),
                SizedBox(height: 16),

                // Reminders Section
                Text(
                  'Reminders',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Remember to log your mood today and complete a self-care activity!',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Quick Action Card Widget
  Widget _buildActionCard(BuildContext context,
      {required String title,
      required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: color),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // User Stats Card Widget
  Widget _buildStatCard(String title, int value) {
    return Column(
      children: [
        Text(
          '$value',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(title, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
