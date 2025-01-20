import 'package:flutter/material.dart';

class TherapistDashboard extends StatelessWidget {
  final String therapistName;

  TherapistDashboard({required this.therapistName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, Dr. $therapistName!'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Overview
              Card(
                elevation: 4.0,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, size: 30, color: Colors.black),
                  ),
                  title: Text(
                    'Dr. $therapistName',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text('Therapist | Mental Health Specialist'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Navigate to Profile Edit Screen
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Appointments Section
              Text(
                'Upcoming Appointments',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 4.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3, // Replace with actual data count
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Client Name'),
                      subtitle: Text('Date: ${DateTime.now()}'),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () {
                        // Navigate to Appointment Details Screen
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20),

              // Clients Section
              Text(
                'Your Clients',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 4.0,
                child: ListTile(
                  leading: Icon(Icons.group, size: 30),
                  title: Text('View and Manage Clients'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigate to Clients Screen
                  },
                ),
              ),
              SizedBox(height: 20),

              // Resources Section
              Text(
                'Therapy Resources',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 4.0,
                child: ListTile(
                  leading: Icon(Icons.library_books, size: 30),
                  title: Text('Access Therapy Materials'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigate to Resources Screen
                  },
                ),
              ),
              SizedBox(height: 20),

              // Logout Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    // Handle Logout Logic
                    Navigator.pushReplacementNamed(context, '/login_screen');
                  },
                  child: Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
