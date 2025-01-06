import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:calm/services/notification_helper.dart';

class ScheduleMeetingScreen extends StatefulWidget {
  final String therapistId;
  final String therapistName;
  final double consultationFee;

  ScheduleMeetingScreen({
    required this.therapistId,
    required this.therapistName,
    required this.consultationFee,
  });

  @override
  _ScheduleMeetingScreenState createState() => _ScheduleMeetingScreenState();
}

class _ScheduleMeetingScreenState extends State<ScheduleMeetingScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _scheduleMeeting() async {
    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a date and time')),
      );
      return;
    }

    try {
      final user = _auth.currentUser;

      if (user != null) {
        final DateTime meetingDateTime = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        );

        // Save appointment to Firestore
        final appointmentRef = await _firestore.collection('appointments').add({
          'userId': user.uid,
          'therapistId': widget.therapistId,
          'therapistName': widget.therapistName,
          'meetingTime': meetingDateTime,
          'status': 'Pending',
          'paymentStatus': 'Unpaid',
          'consultationFee': widget.consultationFee,
        });

        // Schedule a notification 30 minutes before the meeting
        final notificationTime = meetingDateTime.subtract(Duration(minutes: 30));
        NotificationHelper.scheduleNotification(
          appointmentRef.id.hashCode, // Unique notification ID
          'Upcoming Meeting',
          'Your meeting with ${widget.therapistName} is at ${meetingDateTime.toLocal()}',
          notificationTime,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Meeting scheduled successfully!')),
        );

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You must be logged in to book a meeting')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Schedule Meeting')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Select Date
            ListTile(
              title: Text(
                _selectedDate == null
                    ? 'Select a date'
                    : 'Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                }
              },
            ),

            // Select Time
            ListTile(
              title: Text(
                _selectedTime == null
                    ? 'Select a time'
                    : 'Time: ${_selectedTime!.format(context)}',
              ),
              trailing: Icon(Icons.access_time),
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  setState(() {
                    _selectedTime = pickedTime;
                  });
                }
              },
            ),

            SizedBox(height: 20),

            // Confirm Button
            ElevatedButton(
              onPressed: _scheduleMeeting,
              child: Text(
                'Confirm Appointment (\$${widget.consultationFee.toStringAsFixed(2)})',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
