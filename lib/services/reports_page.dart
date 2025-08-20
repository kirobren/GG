import 'package:flutter/material.dart';
import 'package:gg/screens/landingpage.dart';
import 'admin_page.dart';
import 'events_page.dart';
import 'org_request.dart';
import 'users_page.dart';


class ReportsPage extends StatefulWidget {
const ReportsPage({super.key});

@override
State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
int _selectedIndex = 2;

final List<IconData> _navIcons = [
  Icons.home_filled,
  Icons.description_outlined,
  Icons.warning_amber_outlined,
  Icons.people_outline,
  Icons.calendar_today_outlined,
];


void _navigateToPage(int index) {
if (index == _selectedIndex) return;

switch (index) {
case 0:
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => const AdminPage()),
);
break;
case 1:
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => const OrgRequest()),
);
break;
case 2:
break;
case 3:
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => const UsersPage()),
);
break;
case 4:
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => const EventPage()),
);
break;
}
}

void _onDrawerItemTapped(String routeName) {
Navigator.pop(context);
switch (routeName) {
case 'admin':
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => const AdminPage()),
);
break;
case 'org_request':
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => const OrgRequest()),
);
break;
case 'reports':
break;
case 'events':
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => const EventPage()),
);
break;
case 'users':
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => const UsersPage()),
);
break;
case 'logout':
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => const LandingPage()),
);
print('Logging out...');
break;
}
}


Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
return ListTile(
leading: Icon(icon, color: Colors.white),
title: Text(title, style: const TextStyle(color: Colors.white)),
onTap: onTap,
);
}

Widget _buildCustomBottomNavigationBar() {
return Padding(
padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
child: Center(
child: Container(
decoration: BoxDecoration(
color: const Color(0xFF2D2D2D),
border: Border.all(color: Colors.white, width: 2.0),
borderRadius: BorderRadius.circular(30.0),
),
padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
child: Row(
mainAxisSize: MainAxisSize.min,
children: [
_buildButton(
icon: Icons.home_filled,
index: 0,
isSelected: _selectedIndex == 0,
),
_buildButton(
icon: Icons.description_outlined,
index: 1,
isSelected: _selectedIndex == 1,
),
_buildButton(
icon: Icons.warning_amber_outlined,
index: 2,
isSelected: _selectedIndex == 2,
),
_buildButton(
icon: Icons.people_outline,
index: 3,
isSelected: _selectedIndex == 3,
),
_buildButton(
icon: Icons.calendar_today_outlined,
index: 4,
isSelected: _selectedIndex == 4,
),
],
),
),
),
);
}

Widget _buildButton({
required IconData icon,
required int index,
bool isSelected = false,
}) {
return Padding(
padding: const EdgeInsets.only(left: 4.0, top: 4.0, right: 4.0, bottom: 4.0),
child: GestureDetector(
onTap: () => _navigateToPage(index),
child: Container(
padding: const EdgeInsets.all(10.0),
decoration: isSelected
? const BoxDecoration(
color: Colors.white,
shape: BoxShape.circle,
)
: null,
child: Icon(
icon,
color: isSelected ? Colors.black : Colors.white,
size: 22.0,
),
),
),
);
}

Widget _buildReportCard({
required String imageUrl,
required String eventName,
required String location,
required String date,
required String reportedCount,
required String reason,
}) {
return Container(
margin: const EdgeInsets.only(bottom: 16),
decoration: BoxDecoration(
color: const Color(0xFF2D2D2D),
borderRadius: BorderRadius.circular(16),
boxShadow: [
BoxShadow(
color: Colors.black.withOpacity(0.2),
spreadRadius: 2,
blurRadius: 5,
offset: const Offset(0, 3),
),
],
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Stack(
children: [
ClipRRect(
borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
child: Image.network(
imageUrl,
height: 200,
width: double.infinity,
fit: BoxFit.cover,
),
),
Positioned(
bottom: 0,
left: 0,
right: 0,
child: Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
gradient: LinearGradient(
colors: [Colors.black.withOpacity(0.8), Colors.transparent],
begin: Alignment.bottomCenter,
end: Alignment.topCenter,
),
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
eventName,
style: const TextStyle(
color: Colors.white,
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 4),
Row(
children: [
const Icon(Icons.location_on, color: Colors.white, size: 16),
const SizedBox(width: 4),
Text(
location,
style: const TextStyle(color: Colors.white),
),
],
),
const SizedBox(height: 4),
Row(
children: [
const Icon(Icons.calendar_today, color: Colors.white, size: 16),
const SizedBox(width: 4),
Text(
date,
style: const TextStyle(color: Colors.white),
),
],
),
],
),
),
),
],
),
Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'Event: $eventName',
style: const TextStyle(color: Colors.white70),
),
Text(
'Reported: $reportedCount',
style: const TextStyle(color: Colors.white70),
),
Text(
'Reason: $reason',
style: const TextStyle(color: Colors.white70),
),
const SizedBox(height: 16),
Row(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [
Expanded(
child: OutlinedButton.icon(
onPressed: () {},
icon: const Icon(Icons.check, color: Colors.white),
label: const Text('Review'),
style: OutlinedButton.styleFrom(
foregroundColor: Colors.white,
side: const BorderSide(color: Colors.white),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(8),
),
),
),
),
const SizedBox(width: 16),
Expanded(
child: OutlinedButton.icon(
onPressed: () {},
icon: const Icon(Icons.delete_outline, color: Colors.white),
label: const Text('Remove'),
style: OutlinedButton.styleFrom(
foregroundColor: Colors.white,
side: const BorderSide(color: Colors.white),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(8),
),
),
),
),
],
),
],
),
),
],
),
);
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFF090F16),
appBar: AppBar(
backgroundColor: const Color(0xFF090F16),
iconTheme: const IconThemeData(color: Colors.white),
leading: Builder(
builder: (context) => IconButton(
icon: const Icon(Icons.menu, color: Colors.white),
onPressed: () {
Scaffold.of(context).openDrawer();
},
),
),
title: const Text(
'Reports',
style: TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
centerTitle: false,
actions: [],
),
drawer: Drawer(
backgroundColor: const Color(0xFF1A1A1A),
child: ListView(
padding: EdgeInsets.zero,
children: <Widget>[
DrawerHeader(
decoration: const BoxDecoration(color: Color(0xFF1A1A1A)),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
children: [
Image.asset('assets/whistle.png', height: 100),
const SizedBox(width: 8),
const Text(
'Good Game',
style: TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
],
),
],
),
),
_buildDrawerItem(
Icons.dashboard,
'Dashboard',
() => _onDrawerItemTapped('admin'),
),
_buildDrawerItem(
Icons.description,
'Organizer request',
() => _onDrawerItemTapped('org_request'),
),
_buildDrawerItem(
Icons.warning,
'Reports',
() => _onDrawerItemTapped('reports'),
),
_buildDrawerItem(
Icons.event,
'Events',
() => _onDrawerItemTapped('events'),
),
_buildDrawerItem(
Icons.people,
'Users',
() => _onDrawerItemTapped('users'),
),
const Divider(color: Colors.white),
_buildDrawerItem(
Icons.logout,
'Logout',
() => _onDrawerItemTapped('logout'),
),
],
),
),
body: Column(
children: [
Expanded(
child: SingleChildScrollView(
child: Padding(
padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 20.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Report events',
style: TextStyle(
color: Colors.white,
fontSize: 24,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 16),
_buildReportCard(
imageUrl: 'https://images.unsplash.com/photo-1579952564245-c89b27521e86?q=80&w=1974&auto=format&fit=crop',
eventName: 'Iloilo Men\'s Volleyball',
location: 'Passi Iloilo City',
date: 'July 15, 2025',
reportedCount: '3 times',
reason: 'Organizer Inactive',
),
_buildReportCard(
imageUrl: 'https://images.unsplash.com/photo-1579952564245-c89b27521e86?q=80&w=1974&auto=format&fit=crop',
eventName: 'Iloilo Men\'s Volleyball',
location: 'Passi Iloilo City',
date: 'July 15, 2025',
reportedCount: '3 times',
reason: 'Organizer Inactive',
),
],
),
),
),
),
_buildCustomBottomNavigationBar(),
],
),
);
}
}