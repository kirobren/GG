import 'package:flutter/material.dart';
import 'package:gg/screens/landingpage.dart';
import 'org_request.dart';
import 'reports_page.dart';
import 'users_page.dart';
import 'admin_page.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int _selectedIndex = 4;

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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ReportsPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UsersPage()),
        );
        break;
      case 4:
        // Already on this page, do nothing.
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
        // Already on this page, do nothing.
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

  // Updated _buildButton widget to match the style of AdminPage and ReportsPage
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
            size: 22.0, // Reduced size for consistency
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
          'Events',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(),
                    const SizedBox(height: 16),
                    _buildSportsFilter(),
                    const SizedBox(height: 16),
                    const Text(
                      'Recommend sports',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildEventCard(),
                    const SizedBox(height: 16),
                    _buildEventCard(),
                    const SizedBox(height: 100),
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

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSportsFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('All', isSelected: true),
          const SizedBox(width: 8),
          _buildFilterChip('Basketball'),
          const SizedBox(width: 8),
          _buildFilterChip('Badminton'),
          const SizedBox(width: 8),
          _buildFilterChip('Boxing'),
          const SizedBox(width: 8),
          _buildFilterChip('Tennis'),
          const SizedBox(width: 8),
          _buildFilterChip('Volleyball'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Chip(
      label: Text(label),
      backgroundColor: isSelected ? Colors.purple : const Color(0xFF2D2D2D),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.white.withOpacity(0.8),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
    );
  }

  Widget _buildEventCard() {
    return Container(
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.sports_basketball, color: Colors.white, size: 24),
                const SizedBox(width: 8),
                Text(
                  'July 20 2025',
                  style: TextStyle(color: Colors.white.withOpacity(0.8)),
                ),
                const Spacer(),
                Icon(Icons.favorite_border, color: Colors.white.withOpacity(0.8)),
                const SizedBox(width: 8),
                Icon(Icons.more_vert, color: Colors.white.withOpacity(0.8)),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Magnolia Hotshots vs. Meralco Bolts in Iloilo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
            child: Image.network(
              'https://images.unsplash.com/photo-1546519638-68e109498ffc?q=80&w=1974&auto=format&fit=crop',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'SHONN Miller dominated in his Meralco debut, finishing with 33 points and 22 rebounds to lift the Bolts to an 85-80 win over Magnolia Chicken Timplados in the PBA 46th Season Commissioner\'s Cup at the University of San Agustin gym in Iloilo City.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}