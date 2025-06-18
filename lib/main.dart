import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kuyupjelantah/pages/settings_page.dart';
import 'firebase_options.dart';
import 'pages/welcome_page.dart';
import 'pages/history_page.dart';
import 'pages/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuyup Jelantah',
      theme: ThemeData(primarySwatch: Colors.orange),
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
      routes: {
        '/history': (context) => const WeeklyIncomeSummaryPage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
