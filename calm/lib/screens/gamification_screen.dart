import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';




class GamificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gamification')),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;
          final points = data['points'];
          final rewards = List<Map<String, dynamic>>.from(data['rewards']);
          return Column(
            children: [
              Text('Total Points: $points', style: TextStyle(fontSize: 20)),
              Expanded(
                child: ListView.builder(
                  itemCount: rewards.length,
                  itemBuilder: (context, index) {
                    final reward = rewards[index];
                    return ListTile(
                      title: Text(reward['name']),
                      trailing: Text('${reward['points']} points'),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
