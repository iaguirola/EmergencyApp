import 'package:flutter/material.dart';
import 'package:emergencyapp/screens/microfono/speech_screen.dart';

class Speech extends StatelessWidget {
  const Speech({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SpeechScreen(),
      debugShowCheckedModeBanner: false,
      title: 'Emergency',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}