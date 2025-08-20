  import 'package:flutter/material.dart';

  class AboutGGPage extends StatelessWidget {
  const AboutGGPage({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  backgroundColor: const Color(0xFF23262A),
  appBar: AppBar(
  title: const Text(
  'About Good Game',
  style: TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  ),
  ),
  backgroundColor: const Color(0xFF23262A),
  iconTheme: const IconThemeData(color: Colors.white),
  ),
  body: const SingleChildScrollView(
  padding: EdgeInsets.all(16.0),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  Image(
  image: AssetImage('assets/whistle.png'), 
  height: 100,
  ),
  SizedBox(height: 16),
  Text(
  'Good Game',
  style: TextStyle(
  color: Colors.white,
  fontSize: 28,
  fontWeight: FontWeight.bold,
  ),
  ),
  SizedBox(height: 8),
  Text(
  'Version 1.0.0',
  style: TextStyle(
  color: Colors.white70,
  fontSize: 16,
  ),
  ),
  SizedBox(height: 24),
  Text(
  'Good Game is a social platform for sports enthusiasts to discover, create, and join local sporting events. Our mission is to connect communities through the power of sports and friendly competition.',
  style: TextStyle(color: Colors.white70, fontSize: 14),
  textAlign: TextAlign.center,
  ),
  ],
  ),
  ),
  );
  }
  }