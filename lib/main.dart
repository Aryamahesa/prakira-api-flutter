import 'package:flutter/material.dart';
import '/ui/get_started.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // Pastikan semua binding Flutter sudah siap sebelum menjalankan kode async
  WidgetsFlutterBinding.ensureInitialized();

  // Dapatkan instance SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Baca penanda 'seenGetStarted'. Jika tidak ada, anggap false.
  final bool seenGetStarted = prefs.getBool('seenGetStarted') ?? false;

  runApp(MyApp(seenGetStarted: seenGetStarted));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.seenGetStarted});

  final bool seenGetStarted;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: GetStarted(),
      debugShowCheckedModeBanner: false,
    );
  }
}
