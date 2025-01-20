import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb

import 'package:calm/screens/home_screen.dart';
import 'package:calm/screens/auth/login_screen.dart';
import 'package:calm/screens/auth/register_screen.dart';
import 'package:calm/screens/sound_list.dart';
import 'package:calm/screens/chat_screen.dart';
import 'package:calm/screens/community_screen.dart';
import 'package:calm/screens/crisis_screen.dart';
import 'package:calm/screens/gamification_screen.dart';
import 'package:calm/screens/moodtracking_screen.dart';
// import 'package:calm/screens/profile_screen.dart';
// import 'package:calm/screens/reminders_screen.dart';
import 'package:calm/screens/resources_screen.dart';
import 'package:calm/screens/therapist_screen.dart';
import 'package:calm/screens/affirmation_screen.dart';
import 'package:calm/screens/fitness_tracker_page.dart';
import 'package:calm/screens/post_screen.dart';
import 'package:calm/screens/therapist_registration_screen.dart';
import 'package:calm/screens/therapistDashboard.dart';






void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase for both web and mobile platforms
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDnEmJFMB-Jq1g3gNOh7Fq046-odfnR8o8",
        authDomain: "calm-b1f6a.firebaseapp.com",
        databaseURL: "https://calm-b1f6a-default-rtdb.firebaseio.com",
        projectId: "calm-b1f6a",
        storageBucket: "calm-b1f6a.appspot.com",
        messagingSenderId: "189837445252",
        appId: "1:189837445252:web:e2cb2f4f870cc1555adad1",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const Calm());
}

class Calm extends StatelessWidget {
  const Calm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calm',
      theme: ThemeData(
        primaryColor: Colors.yellow,
        primarySwatch: Colors.purple,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home_screen': (context) => HomePage(),
        '/therapist_registration_screen': (context) => TherapistRegistrationScreen(),
        '/login_screen': (context) => LoginScreen(),
        '/chat_screen': (context) => AIChatScreen(),
        '/community_screen': (context) => ChatCommunityScreen(),
        '/crisis_screen': (context) => WebViewPage(
                  url: 'https://findahelpline.com', 
                  title: 'Crisis Management',
                ),
        '/gamification_screen': (context) => MemoryCardGame(),
        '/moodtracking_screen': (context) => VideoList(),
        '/register_screen': (context) => RegisterScreen(),
        '/resources_screen': (context) => ResourcesScreen(),
        '/sound_list.dart': (context) => RelaxingSoundList(),
        '/therapist_screen': (context) => TherapistListScreen(),
        '/affirmation_screen': (context) => DailyAffirmationPage(),
        '/fitness_tracker_page': (context) => FitnessTrackerPage(),        
        '/post_screen': (context) => PostListScreen(),
        '/therapistDashboard': (context) => TherapistDashboard(therapistName: 'John Doe'),


        

      },
      debugShowCheckedModeBanner: false,
    );
  }
}

