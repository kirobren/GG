import 'package:flutter/material.dart';

class TermPrivacyPage extends StatelessWidget {
const TermPrivacyPage({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFF23262A),
appBar: AppBar(
title: const Text(
'Terms & Privacy',
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
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'Terms of Service',
style: TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 8),
Text(
'This is where your detailed Terms of Service will go. You can add your content here.',
style: TextStyle(color: Colors.white70, fontSize: 14),
),
SizedBox(height: 24),
Text(
'Privacy Policy',
style: TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 8),
Text(
'This is where your detailed Privacy Policy will go. You can add your content here.',
style: TextStyle(color: Colors.white70, fontSize: 14),
),
],
),
),
);
}
}