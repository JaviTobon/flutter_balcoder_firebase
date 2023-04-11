import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balcoder_fb/ui/auth/login_page.dart';
import 'package:flutter_balcoder_fb/ui/home/home_page.dart';

void main() {
  Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: "AIzaSyAxo-40Hgeym6PmYxOv4lFbTrG5hDASdQ0",
              authDomain: "fb-balcoder.firebaseapp.com",
              projectId: "fb-balcoder",
              storageBucket: "fb-balcoder.appspot.com",
              messagingSenderId: "616580053805",
              appId: "1:616580053805:web:4e046a94f25c979a9c31a4",
              measurementId: "G-M6J5DVX5N8"))
      .then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
