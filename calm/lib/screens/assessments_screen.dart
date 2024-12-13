import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AssessmentScreen extends StatefulWidget {
  @override
  _AssessmentScreenState createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int totalScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mental Health Assessments')),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('assessments')
            .doc('stress_assessment')
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;
          final questions = List<Map<String, dynamic>>.from(data['questions']);
          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question['text'], style: TextStyle(fontSize: 18)),
                  ...question['options'].asMap().entries.map((entry) {
                    final option = entry.value;
                    final weight = question['weights'][entry.key];
                    return RadioListTile(
                      title: Text(option),
                      value: weight,
                      groupValue: null,
                      onChanged: (value) {
                        setState(() {
                          totalScore += (weight as int);
                        });
                      },
                    );
                  }),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
