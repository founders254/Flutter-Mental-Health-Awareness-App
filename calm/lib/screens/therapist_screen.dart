import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:calm/screens/schedule_meeting_screen.dart';

class TherapistListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Available Therapists')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('therapists').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final therapists = snapshot.data!.docs;
          return ListView.builder(
            itemCount: therapists.length,
            itemBuilder: (context, index) {
              final therapist = therapists[index];
              return ListTile(
                title: Text(therapist['name']),
                subtitle: Text(
                  '${therapist['specialization']} - \$${therapist['consultationFee']}',
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleMeetingScreen(
                          therapistId: therapist.id,
                          therapistName: therapist['name'],
                          consultationFee: (therapist['consultationFee'] as num).toDouble(),
                        ),
                      ),
                    );
                  },
                  child: Text('Book'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
