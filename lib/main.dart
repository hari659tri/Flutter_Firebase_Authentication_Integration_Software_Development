import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Login%20Signup/Screen/login.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
       options:const FirebaseOptions(
          apiKey: "AIzaSyCcCqr8KSehQQhDTUMbj2-x3wqqkEZ4py4",
          projectId: "emailauth-d8120",
          appId: "1:406594082653:android:6a9bb2a5456ef458bd3ab4",
         messagingSenderId:"emailauth-d8120"
       )
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}