import 'package:flutter/material.dart';
import 'package:gg/screens/landingpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'reports_page.dart';
import 'users_page.dart';
import 'org_request.dart';
import 'events_page.dart';

class AdminPage extends StatefulWidget {
const AdminPage({super.key});

@override
State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
final SupabaseClient _supabase = Supabase.instance.client;
int _selectedIndex = 0;
bool _isLoading = true;

String _adminName = 'Admin';
String _lastLoginDate = 'N/A';
String _lastLoginTime = 'N/A';
int _totalUsers = 0;
int _totalOrganizers = 0;
int _activeEvents = 0;
int _reportedEvents = 0;
int _organizerRequests = 0;

@override
void initState() {
super.initState();
_fetchDashboardData();
}

Future<void> _fetchDashboardData() async {
try {
final user = _supabase.auth.currentUser;
if (user != null) {
final adminProfile = await _supabase
.from('users')
.select('full_name')
.eq('id', user.id)
.single();
setState(() {
_adminName = adminProfile['full_name'] ?? 'Admin';
if (user.lastSignInAt != null) {
final lastSignInDateTime = DateTime.tryParse(
user.lastSignInAt.toString(),
);
if (lastSignInDateTime != null) {
_lastLoginDate = DateFormat(
'MMMM d, y',
).format(lastSignInDateTime.toLocal());
_lastLoginTime = DateFormat(
'h:mm a',
).format(lastSignInDateTime.toLocal());
}
}
});
}

final results = await Future.wait([
_supabase.from('users').count(),
_supabase.from('organizers').count(),
_supabase.from('events').select().eq('status', 'active'),
_supabase.from('reports').count(), 
_supabase.from('organizer_requests').count(),
]);

setState(() {
_totalUsers = results[0] as int;
_totalOrganizers = results[1] as int;
_activeEvents = (results[2] as List).length;
_reportedEvents = results[3] as int; // FIX: This line has been changed.
_organizerRequests = results[4] as int;
_isLoading = false;
});
} catch (e) {
if (mounted) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('Failed to fetch data: ${e.toString()}')),
);
}
setState(() {
_isLoading = false;
});
}
}

void _onItemTapped(int index) {
setState(() {
_selectedIndex = index;
});
_navigateToPage(index);
}

void _navigateToPage(int index) {
switch (index) {
case 0:
// Already on AdminPage, do nothing.
break;
case 1:
Navigator.push(
context,
MaterialPageRoute(builder: (context) => const OrgRequest()),
);
break;
case 2:
Navigator.push(
context,
MaterialPageRoute(builder: (context) => const ReportsPage()),
);
break;
case 3:
Navigator.push(
context,
MaterialPageRoute(builder: (context) => const UsersPage()),
);
break;
case 4:
Navigator.push(
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
// Already on AdminPage, do nothing.
break;
case 'org_request':
Navigator.push(
context,
MaterialPageRoute(builder: (context) => const OrgRequest()),
);
break;
case 'reports':
Navigator.push(
context,
MaterialPageRoute(builder: (context) => const ReportsPage()),
);
break;
case 'events':
Navigator.push(
context,
MaterialPageRoute(builder: (context) => const EventPage()),
);
break;
case 'users':
Navigator.push(
context,
MaterialPageRoute(builder: (context) => const UsersPage()),
);
break;
case 'Logout':
Navigator.push(
context,
MaterialPageRoute(builder: (context) => LandingPage()),
);
break;
}
}

Widget _buildCustomBottomNavigationBar() {
return Positioned(
bottom: 20,
left: 20,
right: 20,
child: Center(
child: Container(
decoration: BoxDecoration(
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
onTap: () => _onItemTapped(index),
child: Container(
padding: const EdgeInsets.all(10.0),
decoration: isSelected
? const BoxDecoration(color: Colors.white, shape: BoxShape.circle)
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

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFF090F16),
appBar: AppBar(
backgroundColor: const Color(0xFF090F16),
elevation: 0,
leading: Builder(
builder: (context) => IconButton(
icon: const Icon(Icons.menu, color: Colors.white),
onPressed: () {
Scaffold.of(context).openDrawer();
},
),
),
title: const Text(
'Admin Panel',
style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
fontSize: 20,
),
),
centerTitle: true,
actions: const [],
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
Text(
'Good Game',
style: TextStyle(
color: Colors.white.withOpacity(0.8),
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
'admin',
() => _onDrawerItemTapped('admin'),
),
_buildDrawerItem(
Icons.description,
'org_request',
() => _onDrawerItemTapped('org_request'),
),
_buildDrawerItem(
Icons.warning,
'reports',
() => _onDrawerItemTapped('reports'),
),
_buildDrawerItem(
Icons.event,
'events',
() => _onDrawerItemTapped('events'),
),
_buildDrawerItem(
Icons.people,
'users',
() => _onDrawerItemTapped('users'),
),
const Divider(color: Colors.white),
_buildDrawerItem(
Icons.logout,
'Logout',
() => _onDrawerItemTapped('Logout'),
),
],
),
),
body: _isLoading
? const Center(
child: CircularProgressIndicator(
color: Color.fromARGB(255, 55, 186, 193),
),
)
: SingleChildScrollView(
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Dashboard',
style: TextStyle(
color: Colors.white,
fontSize: 24,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 16),
Card(
color: const Color(0xFF1A1A1A),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(12),
),
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Row(
children: [
CircleAvatar(
radius: 30,
backgroundColor: const Color.fromARGB(
255,
55,
186,
193,
),
child: Text(
_adminName.isNotEmpty
? _adminName[0].toUpperCase()
: 'A',
style: const TextStyle(
color: Colors.white,
fontSize: 24,
fontWeight: FontWeight.bold,
),
),
),
const SizedBox(width: 16),
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Welcome back,',
style: TextStyle(
color: Colors.white70,
fontSize: 14,
),
),
Text(
_adminName,
style: const TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 4),
Text(
'Last login: $_lastLoginDate, $_lastLoginTime',
style: const TextStyle(
color: Colors.white54,
fontSize: 12,
),
),
],
),
],
),
),
),
const SizedBox(height: 16),
GridView.count(
shrinkWrap: true,
physics: const NeverScrollableScrollPhysics(),
crossAxisCount: 2,
crossAxisSpacing: 16.0,
mainAxisSpacing: 16.0,
childAspectRatio: 1.2,
children: [
_buildMetricCard(
title: 'Total Users',
value: _totalUsers.toString(),
subtitle: '12 more in the last 10 days',
icon: Icons.trending_up,
),
_buildMetricCard(
title: 'Organizers',
value: _totalOrganizers.toString(),
subtitle: '5 new organizers',
),
_buildMetricCard(
title: 'Active Events',
value: _activeEvents.toString(),
subtitle: '2 new in the last 10 days',
icon: Icons.trending_up,
),
_buildMetricCard(
title: 'Reported Events',
value: _reportedEvents.toString(),
subtitle: '1 new in the last 10 days',
icon: Icons.trending_up,
),
],
),
const SizedBox(height: 16),
Card(
color: const Color(0xFF1A1A1A),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(12),
),
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Organizer Request',
style: TextStyle(
color: Colors.white,
fontSize: 16,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 8),
Text(
'$_organizerRequests new requested today',
style: const TextStyle(
color: Color.fromARGB(255, 55, 186, 193),
fontSize: 24,
fontWeight: FontWeight.bold,
),
),
],
),
),
),
],
),
),
),
bottomNavigationBar: Stack(
alignment: Alignment.center,
children: [Container(height: 100), _buildCustomBottomNavigationBar()],
),
);
}

Widget _buildMetricCard({
required String title,
required String value,
String? subtitle,
IconData? icon,
}) {
return Card(
color: const Color(0xFF1A1A1A),
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
child: Padding(
padding: const EdgeInsets.all(12.0),
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
const SizedBox(height: 8),
Row(
crossAxisAlignment: CrossAxisAlignment.baseline,
textBaseline: TextBaseline.alphabetic,
children: [
Text(
value,
style: const TextStyle(
color: Color.fromARGB(255, 55, 186, 193),
fontSize: 32,
fontWeight: FontWeight.bold,
),
),
if (icon != null) ...[
const SizedBox(width: 8),
Icon(
icon,
color: const Color.fromARGB(255, 55, 186, 193),
size: 16,
),
],
],
),
if (subtitle != null) ...[
const SizedBox(height: 4),
Text(
subtitle,
style: const TextStyle(color: Colors.white54, fontSize: 12),
),
],
],
),
),
);
}

Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
return ListTile(
leading: Icon(icon, color: Colors.white),
title: Text(title, style: const TextStyle(color: Colors.white)),
onTap: onTap,
);
}
}