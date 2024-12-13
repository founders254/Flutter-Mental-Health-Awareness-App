import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MoodTrackerScreen extends StatefulWidget {
  @override
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  final List<String> moods = ['😊', '😐', '😔', '😡'];
  String? selectedMood;


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Mindful Moments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('How are you feeling today?',
            style: TextStyle(fontSize:18 ),
            ),

            SizedBox(height: 20),


            Wrap(
              spacing: 10,
              children: moods.map((mood) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMood = mood ;
                    });
                  },

                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: selectedMood == mood ? Colors.blue : Colors.grey[200],
                    child: Text(mood, style: TextStyle(fontSize: 24)),
                  ),
                );
              }).toList()
            ),


            SizedBox(height: 20),


            ElevatedButton(
              onPressed: () {
                if(selectedMood != null) {
                  FirebaseFirestore.instance.collection('moods').add({
                    'userId' : FirebaseAuth.instance.currentUser!.uid,
                    'date': DateTime.now().toIso8601String(),
                    'mood': selectedMood,
                  });
                }
              },
              child: Text('Save Mood'),
            ),
          ],
        ),
      ),
    );
  }
}