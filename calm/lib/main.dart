import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb

//
import 'package:calm/screens/home_screen.dart';


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
      home: HomePage(),
      
     //
      debugShowCheckedModeBanner: false,
    );
  }
}
