import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';



class TherapistDirectoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Find a Therapist')),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('therapists').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final therapists = snapshot.data!.docs;
          return ListView.builder(
            itemCount: therapists.length,
            itemBuilder: (context, index) {
              final therapist = therapists[index];
              return ListTile(
                title: Text(therapist['name']),
                subtitle: Text(therapist['specialization']),
                trailing: IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {
                    launch('tel:${therapist['contact']}');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
