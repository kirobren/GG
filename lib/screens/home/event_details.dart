import 'package:flutter/material.dart';
import 'package:gg/models/event.dart'; 


class EventDetailsPage extends StatelessWidget {
final Event event;

const EventDetailsPage({
super.key,
required this.event,
});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFF23262A),
body: SafeArea(
child: SingleChildScrollView(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Padding(
padding: const EdgeInsets.all(16.0),
child: Row(
children: [
GestureDetector(
onTap: () {
Navigator.pop(context);
},
child: Container(
padding: const EdgeInsets.all(8),
decoration: BoxDecoration(
color: const Color(0xFF35383F),
borderRadius: BorderRadius.circular(10),
border: Border.all(color: Colors.white, width: 1),
),
child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
),
),
const SizedBox(width: 16),
const Text(
'Event Details',
style: TextStyle(
color: Colors.white,
fontSize: 24,
fontWeight: FontWeight.bold,
),
),
],
),
),
const SizedBox(height: 16),

Padding(
padding: const EdgeInsets.symmetric(horizontal: 16.0),
child: ClipRRect(
borderRadius: BorderRadius.circular(16.0),
child: Image.asset(
event.imageUrl,
height: 250,
width: double.infinity,
fit: BoxFit.cover,
errorBuilder: (context, error, stackTrace) {
return Container(
height: 250,
width: double.infinity,
color: Colors.grey.shade700,
child: const Center(
child: Text(
'Image not found',
style: TextStyle(color: Colors.white54),
),
),
);
},
),
),
),

Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Overview',
style: TextStyle(
color: Colors.white,
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 8),
Text(
event.description,
style: const TextStyle(
color: Colors.white70,
fontSize: 14,
),
),
const SizedBox(height: 16),

const Text(
'Details',
style: TextStyle(
color: Colors.white,
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 8),
Text(
event.title, 
style: const TextStyle(
color: Colors.white,
fontSize: 16,
),
),
const SizedBox(height: 4),

Row(
children: [
const Icon(Icons.location_on, color: Colors.white70, size: 16),
const SizedBox(width: 8),
Text(
event.location,
style: const TextStyle(color: Colors.white70, fontSize: 14),
),
],
),
const SizedBox(height: 4),

Row(
children: [
const Icon(Icons.calendar_today, color: Colors.white70, size: 16),
const SizedBox(width: 8),
Text(
event.date,
style: const TextStyle(color: Colors.white70, fontSize: 14),
),
],
),
],
),
),

const SizedBox(height: 16),

Padding(
padding: const EdgeInsets.symmetric(horizontal: 16.0),
child: Column(
children: [
SizedBox(
width: double.infinity,
child: OutlinedButton(
style: OutlinedButton.styleFrom(
backgroundColor: Colors.transparent,
side: const BorderSide(color: Colors.white),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
padding: const EdgeInsets.symmetric(vertical: 16),
),
onPressed: () {
print('Add to Favorites button tapped for ${event.title}');
},
child: const Text(
'Add to Favorites',
style: TextStyle(
color: Colors.white,
fontSize: 16,
fontWeight: FontWeight.bold,
),
),
),
),
const SizedBox(height: 16),
SizedBox(
width: double.infinity,
child: OutlinedButton(
style: OutlinedButton.styleFrom(
backgroundColor: Colors.transparent,
side: const BorderSide(color: Colors.white),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
padding: const EdgeInsets.symmetric(vertical: 16),
),
onPressed: () {
print('Report Event button tapped for ${event.title}');
},
child: const Text(
'Report Event',
style: TextStyle(
color: Colors.white,
fontSize: 16,
fontWeight: FontWeight.bold,
),
),
),
),
],
),
),
],
),
),
),
);
}
}
