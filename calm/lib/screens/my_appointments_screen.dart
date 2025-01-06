import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'payment_screen.dart';

class MyAppointmentsScreen extends StatefulWidget {
  @override
  _MyAppointmentsScreenState createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: Text('My Appointments')),
      body: user == null
          ? Center(child: Text('You must be logged in to view your appointments'))
          : StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('appointments')
                  .where('userId', isEqualTo: user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final appointments = snapshot.data!.docs;

                if (appointments.isEmpty) {
                  return Center(child: Text('No appointments scheduled.'));
                }

                return ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = appointments[index];
                    final data = appointment.data() as Map<String, dynamic>;

                    final DateTime meetingTime = (data['meetingTime'] as Timestamp).toDate();
                    final String therapistName = data['therapistName'];
                    final String status = data['status'];
                    final String paymentStatus = data['paymentStatus'];
                    final double consultationFee = data['consultationFee'];

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(therapistName),
                        subtitle: Text(
                          'Date: ${meetingTime.toLocal()} \nStatus: $status',
                        ),
                        trailing: paymentStatus == 'Unpaid'
                            ? ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentScreen(
                                        appointmentId: appointment.id,
                                        consultationFee: consultationFee,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Pay (\$${consultationFee.toStringAsFixed(2)})'),
                              )
                            : Text('Paid', style: TextStyle(color: Colors.green)),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
