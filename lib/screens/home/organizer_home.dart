import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrganizerHome extends StatefulWidget {
const OrganizerHome({super.key});

@override
State<OrganizerHome> createState() => _OrganizerHomeState();
}

class _OrganizerHomeState extends State<OrganizerHome> {
String _userRole = 'organizer'; 
bool _isLoading = true;

@override
void initState() {
super.initState();
_fetchUserRole();
}

Future<void> _fetchUserRole() async {
try {
final user = Supabase.instance.client.auth.currentUser;
if (user == null) {
if (mounted) {
setState(() {
_isLoading = false;
});
}
return;
}

final response = await Supabase.instance.client
.from('profiles')
.select('role')
.eq('id', user.id)
.single();

if (mounted) {
setState(() {
_userRole = response['role'] ?? 'organizer'; 
_isLoading = false;
});
}
} catch (e) {
if (mounted) {
print('Error fetching user role: $e');
setState(() {
_isLoading = false;
});
}
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFF23262A),
appBar: AppBar(
title: Text(
_userRole == 'super_admin' ? 'Super Admin Dashboard' : 'Organizer Dashboard',
style: const TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
),
),
backgroundColor: const Color(0xFF2E3137),
iconTheme: const IconThemeData(color: Colors.white),
),
body: _isLoading
? const Center(child: CircularProgressIndicator(color: Colors.white))
: SingleChildScrollView(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
if (_userRole == 'super_admin') ...[
_buildAdminSection(context),
] else ...[
_buildOrganizerSection(context),
],
],
),
),
);
}

Widget _buildOrganizerSection(BuildContext context) {
return Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Welcome to your dashboard!',
style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
),
const SizedBox(height: 16),
_buildInfoCard(
title: 'Manage Your Events',
icon: Icons.event,
onTap: () {

print('Manage Events tapped');
},
),
const SizedBox(height: 16),
_buildInfoCard(
title: 'View Analytics',
icon: Icons.analytics_outlined,
onTap: () {

print('View Analytics tapped');
},
),
],
);
}

Widget _buildAdminSection(BuildContext context) {
return Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Super Admin Panel',
style: TextStyle(color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold),
),
const SizedBox(height: 16),
_buildInfoCard(
title: 'Manage All Events (Admin)',
icon: Icons.calendar_today_outlined,
onTap: () {

print('Admin Event Management tapped');
},
),
const SizedBox(height: 16),
_buildInfoCard(
title: 'Manage Users & Roles',
icon: Icons.people_outline,
onTap: () {

print('Manage Users & Roles tapped');
},
),
],
);
}

Widget _buildInfoCard({
required String title,
required IconData icon,
required VoidCallback onTap,
}) {
return Container(
decoration: BoxDecoration(
color: const Color(0xFF2E3137),
borderRadius: BorderRadius.circular(10),
),
child: ListTile(
leading: Icon(icon, color: Colors.white70),
title: Text(title, style: const TextStyle(color: Colors.white)),
trailing: const Icon(Icons.chevron_right, color: Colors.white),
onTap: onTap,
),
);
}
}