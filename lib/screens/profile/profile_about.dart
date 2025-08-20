import 'package:flutter/material.dart';

enum ProfileTab { favorites, about, photos }

class ProfilePage extends StatefulWidget {
const ProfilePage({super.key});

@override
State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

ProfileTab _selectedTab = ProfileTab.about;

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFF23262A), 
appBar: AppBar(
backgroundColor: Colors.transparent,
elevation: 0,
leading: IconButton(
icon: const Icon(Icons.arrow_back, color: Colors.white),
onPressed: () {

Navigator.of(context).pop();
},
),
title: const Text(
'Profile',
style: TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
),
body: SafeArea(
child: SingleChildScrollView(
child: Column(
children: [

_buildProfileHeader(),
const SizedBox(height: 20),

_buildTabSelector(),
const SizedBox(height: 20),

_buildTabContent(),
const SizedBox(height: 20),
],
),
),
),

bottomNavigationBar: _buildBottomNavigationBar(),
);
}

Widget _buildProfileHeader() {
return Padding(
padding: const EdgeInsets.symmetric(horizontal: 16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
children: [
Container(
width: 70,
height: 70,
decoration: BoxDecoration(
color: Colors.grey.shade600,
shape: BoxShape.circle,
),
child: const Center(
child: Text(
'J',
style: TextStyle(
color: Colors.white,
fontSize: 32,
fontWeight: FontWeight.bold,
),
),
),
),
const SizedBox(width: 16),
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: const [
Text(
'Justin Chua',
style: TextStyle(
color: Colors.white,
fontSize: 22,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 4),
Text(
'30 followers • 10 following',
style: TextStyle(color: Colors.white70, fontSize: 14),
),
Text(
'CHWAA',
style: TextStyle(color: Colors.white70, fontSize: 14),
),
],
),
],
),
ElevatedButton(
onPressed: () {
},
style: ElevatedButton.styleFrom(
backgroundColor: const Color(
0xFF2E3137,
), 
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(20),
),
padding: const EdgeInsets.symmetric(
horizontal: 16,
vertical: 8,
),
),
child: const Text(
'Edit',
style: TextStyle(color: Colors.white, fontSize: 14),
),
),
],
),
],
),
);
}

Widget _buildTabSelector() {
return Padding(
padding: const EdgeInsets.symmetric(horizontal: 16.0),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
_buildTabButton('Favorites', ProfileTab.favorites),
_buildTabButton('About', ProfileTab.about),
_buildTabButton('Photos', ProfileTab.photos),
],
),
);
}

Widget _buildTabButton(String title, ProfileTab tab) {
bool isSelected = _selectedTab == tab;
return Expanded(
child: Padding(
padding: const EdgeInsets.symmetric(horizontal: 4.0),
child: ElevatedButton(
onPressed: () {
setState(() {
_selectedTab = tab;
});
},
style: ElevatedButton.styleFrom(
backgroundColor: isSelected ? Colors.blue : const Color(0xFF2E3137),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
padding: const EdgeInsets.symmetric(vertical: 12),
),
child: Text(
title,
style: const TextStyle(color: Colors.white, fontSize: 14),
),
),
),
);
}

Widget _buildTabContent() {
switch (_selectedTab) {
case ProfileTab.favorites:
return _buildEmptyState('No favorites to show.');
case ProfileTab.about:
return _buildAboutContent();
case ProfileTab.photos:
return _buildPhotosContent();
default:
return _buildEmptyState('No content available.');
}
}

Widget _buildAboutContent() {
return Padding(
padding: const EdgeInsets.symmetric(horizontal: 16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

_buildInfoContainer(
title: 'Categories',
content: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
children: const [
Icon(
Icons.assignment_ind_outlined,
color: Colors.white70,
size: 16,
),
SizedBox(width: 8),
Text(
'Organizer',
style: TextStyle(color: Colors.white70, fontSize: 14),
),
],
),
],
),
),
const SizedBox(height: 16),

_buildInfoContainer(
title: 'Contact info',
content: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
_buildContactRow(Icons.phone_outlined, '+639090142971'),
const SizedBox(height: 8),
_buildContactRow(Icons.email_outlined, 'justinchua@gmail.com'),
],
),
),
const SizedBox(height: 16),

_buildInfoContainer(
title: 'Websites and Social links',
content: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
_buildLinkRow('https://www.figma.com/organizer/gggame'),
],
),
),
],
),
);
}

Widget _buildPhotosContent() {
return Padding(
padding: const EdgeInsets.symmetric(horizontal: 16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Photos',
style: TextStyle(
color: Colors.white,
fontSize: 16,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 10),

GridView.builder(
shrinkWrap:
true, 
physics:
const NeverScrollableScrollPhysics(), 
gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 3,
crossAxisSpacing: 8.0,
mainAxisSpacing: 8.0,
),
itemCount: 9, 
itemBuilder: (context, index) {
return Container(
decoration: BoxDecoration(
color: Colors.grey.shade800, 
borderRadius: BorderRadius.circular(8),
),
child: const Center(
child: Icon(Icons.image, color: Colors.white54, size: 30),
),
);
},
),
],
),
);
}

Widget _buildInfoContainer({required String title, required Widget content}) {
return Container(
width: double.infinity,
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: const Color(0xFF2E3137),
borderRadius: BorderRadius.circular(10),
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
title,
style: const TextStyle(
color: Colors.white,
fontSize: 16,
fontWeight: FontWeight.bold,
),
),
const Divider(color: Colors.white12, height: 20),
content,
],
),
);
}

Widget _buildContactRow(IconData icon, String text) {
return Row(
children: [
Icon(icon, color: Colors.white70, size: 16),
const SizedBox(width: 8),
Text(text, style: const TextStyle(color: Colors.white70, fontSize: 14)),
],
);
}

Widget _buildLinkRow(String link) {
return Text(
link,
style: const TextStyle(
color: Colors.blueAccent,
fontSize: 14,
decoration: TextDecoration.underline,
),
);
}

Widget _buildEmptyState(String message) {
return Padding(
padding: const EdgeInsets.all(16.0),
child: Center(
child: Text(
message,
style: const TextStyle(color: Colors.white54, fontSize: 16),
),
),
);
}

Widget _buildBottomNavigationBar() {
return BottomNavigationBar(
backgroundColor: const Color(0xFF2E3137),
type: BottomNavigationBarType.fixed,
selectedItemColor: Colors.blue,
unselectedItemColor: Colors.white54,
items: const <BottomNavigationBarItem>[
BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
BottomNavigationBarItem(
icon: Icon(Icons.person), 
label: '',
),
],
currentIndex: 3,
onTap: (index) {
},
);
}
}
