import 'package:flutter/material.dart';
import 'log_in_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// TODO: Replace these with your actual Supabase credentials
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
      home: const LogInScreen(),
    );
  }
}
