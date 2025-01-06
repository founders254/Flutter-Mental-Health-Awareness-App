import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// StreamBuilder<QuerySnapshot>(
//   stream: FirebaseFirestore.instance
//       .collection('appointments')
//       .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//       .snapshots(),
//   builder: (context, snapshot) {
//     if (!snapshot.hasData) {
//       return Center(child: CircularProgressIndicator());
//     }

//     final appointments = snapshot.data!.docs;

//     return ListView.builder(
//       itemCount: appointments.length,
//       itemBuilder: (context, index) {
//         final appointment = appointments[index];
//         return ListTile(
//           title: Text(appointment['therapistName']),
//           subtitle: Text(
//             'Date: ${appointment['meetingTime'].toDate()} \nStatus: ${appointment['status']}',
//           ),
//           trailing: Text('\$${widget.consultationFee.toStringAsFixed(2)}'),
//         );
//       },
//     );
//   },
// )


class ProfileScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data();
  }

  @override
  Widget build(BuildContext context) {
    final String uid = "user-id"; // Replace with the actual user ID
    return FutureBuilder<Map<String, dynamic>?>(
      future: getUserProfile(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('No user profile found');
        } else {
          final userData = snapshot.data!;
          return Column(
            children: [
              Text('Name: ${userData['name']}'),
              Text('Email: ${userData['email']}'),
            ],
          );
        }
      },
    );
  }
}

