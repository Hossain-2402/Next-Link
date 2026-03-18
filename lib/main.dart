import 'package:flutter/material.dart';
import 'feed_screen.dart';
import 'log_in_screen.dart';
import 'post.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'splashscreen.dart';
import 'profile.dart';

const String supabaseUrl = 'https://rvcociafgfxvkgehunam.supabase.co';
const String supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ2Y29jaWFmZ2Z4dmtnZWh1bmFtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njc1NDU1NzQsImV4cCI6MjA4MzEyMTU3NH0.DdqmIppf2OQCGyF8npRvc-7deX3qowal26dLrqdnF5o';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NextLink',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: SplashScreen(),
    );
  }
}

/*
ProfilePage(userName: "Hossain", profilePic: "https://imgs.search.brave.com/MR0VAZeSKSYTs6ZxfrFGIr4Z_ZgMDln0Ug-ECpeVqyk/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMudmVjdGVlenku/Y29tL3N5c3RlbS9y/ZXNvdXJjZXMvdGh1/bWJuYWlscy8wMzAv/NzQ3LzY0OC9zbWFs/bC9hLW1vdW50YWlu/LWxha2Utd2l0aC1h/LW1vdW50YWluLWlu/LXRoZS1iYWNrZ3Jv/dW5kLWFuZC1sYW5k/c2NhcGUtd2FsbHBh/cGVyLWZyZWUtcGhv/dG8uanBn"),
    );


*/



