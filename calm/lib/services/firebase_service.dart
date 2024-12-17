import 'package:cloud_firestore/cloud_firestore.dart';



void createUserProfile(String uid, String name, String email) {
  FirebaseFirestore.instance.collection('users').doc(uid).set({
    'name': name,
    'email': email,
    'goals': [],
    'preferences': {},
    'progress': {},
  });
}


void logMood(String uid, String mood, String note) {
  FirebaseFirestore.instance
      .collection('mood_logs')
      .doc(uid)
      .collection('entries')
      .add({
    'mood': mood,
    'date': DateTime.now().toIso8601String(),
  });
}


void addResource(String type, String title, String url) {
  FirebaseFirestore.instance.collection('resources').add({
    'type': type,
    'title': title,
    'url': url,
  });
}


void createPost(String uid, String content, bool anonymous) {
  FirebaseFirestore.instance.collection('community_posts').add({
    'author_id': anonymous ? null : uid,
    'content': content,
    'timestamp': DateTime.now(),
    'anonymous': anonymous,
  });
}



void addTherapist(String name, String specialty, String contact, List<String> availability) {
  FirebaseFirestore.instance.collection('therapists').add({
    'name': name,
    'specialty': specialty,
    'contact': contact,
    'availability': availability,
  });
}



void addCrisisResource(String country, String phone, String description) {
  FirebaseFirestore.instance.collection('crisis_resources').add({
    'country': country,
    'phone': phone,
  });
}


void addReminder(String uid, String reminderText, String time) {
  FirebaseFirestore.instance.collection('reminders').doc(uid).set({
    'reminder_text': reminderText,
    'time': time,
    'is_active': true,
  });
}


void addPoints(String uid, int points) {
  FirebaseFirestore.instance.collection('users').doc(uid).update({
    'points': FieldValue.increment(points),
  });
}


void saveAssessmentResult(String uid, String type, int score, String recommendations) {
  FirebaseFirestore.instance
      .collection('assessments')
      .doc(uid)
      .collection('results')
      .add({
    'assessment_type': type,
    'score': score,
    'date': DateTime.now().toIso8601String(),
    'recommendations': recommendations,
  });
}







