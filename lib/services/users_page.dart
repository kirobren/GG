import 'package:flutter/material.dart';
import 'package:gg/screens/landingpage.dart';
import 'admin_page.dart';
import 'events_page.dart';
import 'org_request.dart';
import 'reports_page.dart';


class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  int _selectedIndex = 3;

  void _navigateToPage(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });

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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ReportsPage()),
        );
        break;
      case 3:
        print('Already on Users Page');
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ReportsPage()),
        );
        break;
      case 'events':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const EventPage()),
        );
        break;
      case 'users':
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


  Widget _buildCustomBottomNavigationBar() {
    return Padding(
         padding: const EdgeInsets.only(left: 43.0, top: 4.0, right: 43.0, bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          border: Border.all(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 9.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    );
  }

  Widget _buildButton({
    required IconData icon,
    required int index,
    bool isSelected = false,
  }) {
    return GestureDetector(
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
    );
  }

  Widget _buildUserCard({
    required String name,
    required String email,
    required String avatarUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(avatarUrl),
            radius: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.email, color: Colors.white.withOpacity(0.7), size: 14),
                    const SizedBox(width: 4),
                    Text(
                      email,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildActionButton(text: 'Disable', backgroundColor: Colors.white.withOpacity(0.1), textColor: Colors.white, isOutlined: true),
              const SizedBox(width: 8),
              _buildActionButton(text: 'Warning', backgroundColor: Colors.transparent, textColor: Colors.white, isOutlined: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required bool isOutlined,
  }) {
    return ElevatedButton(
      onPressed: () {
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        side: isOutlined ? const BorderSide(color: Colors.white) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        minimumSize: const Size(0, 28),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
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
          'Users',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF1A1A1A),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF1A1A1A)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  Row(
                    children: [
                      Image.asset('assets/whistle.png', height: 100),
                      SizedBox(width: 8),
                      Text(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search, color: Colors.white70),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildUserCard(
              name: 'John Justin Chua',
              email: 'johnjustin@gmail.com',
              avatarUrl:
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=1974&auto=format&fit=crop',
            ),
            _buildUserCard(
              name: 'Vince Collin Panes',
              email: 'vincepanes@gmail.com',
              avatarUrl:
                  'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=1974&auto=format&fit-crop',
            ),
            _buildUserCard(
              name: 'Mark Arhiel Gloria',
              email: 'markgloria@gmail.com',
              avatarUrl:
                  'https://images.unsplash.com/photo-1539571696357-4335a90924e5?q=80&w=1974&auto=format&fit-crop',
            ),
            _buildUserCard(
              name: 'Ken Vincent Comoda',
              email: 'kencomoda@gmail.com',
              avatarUrl:
                  'https://images.unsplash.com/photo-1547425260-76bc494ad9b8?q=80&w=1974&auto=format&fit-crop',
            ),
            _buildUserCard(
              name: 'Ronimee Patsy Gascon',
              email: 'patsygascon@gmail.com',
              avatarUrl:
                  'https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=1974&auto=format&fit-crop',
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildCustomBottomNavigationBar(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Users Page',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
      home: const UsersPage(),
    );
  }
}

void main() {
  runApp(const MyApp());
}
