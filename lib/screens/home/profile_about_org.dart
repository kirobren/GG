import 'package:flutter/material.dart';
import 'package:gg/screens/home/organizer_page.dart';
import 'package:gg/screens/home/create_event.dart';
import 'package:gg/screens/home/search_org.dart';
import 'package:gg/screens/home/profile_org.dart';

class ProfileAboutOrgPage extends StatefulWidget {
  const ProfileAboutOrgPage({super.key});

  @override
  State<ProfileAboutOrgPage> createState() => _ProfileAboutOrgPageState();
}

class _ProfileAboutOrgPageState extends State<ProfileAboutOrgPage> {
  // Index for the bottom navigation bar, with 'profile' selected
  int _selectedIndex = 3;
  final List<IconData> _navIcons = [
    Icons.home,
    Icons.edit_note,
    Icons.search,
    Icons.person,
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OrganizerPage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CreateEventPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SearchOrgPage()),
        );
        break;
      case 3:
        // Already on the profile page, no navigation needed
        break;
    }
  }

  // A helper method to build the common navigation bar widget
  Widget _buildNavigationBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Container(
        margin: const EdgeInsets.only(
            left: 56.0, top: 8.0, right: 56.0, bottom: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(40),
          color: Colors.transparent,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF23262A),
            borderRadius: BorderRadius.circular(40),
          ),
          padding: const EdgeInsets.only(
              left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_navIcons.length, (index) {
              final isSelected = _selectedIndex == index;
              return GestureDetector(
                onTap: () => _onItemTapped(index),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFFFFFFF)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _navIcons[index],
                    color: isSelected ? const Color(0xFF23262A) : Colors.white,
                    size: 22,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090F16),
      body: Stack(
        children: [
          // Scrollable content of the profile page with About section
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120), // space for nav bar
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header Section
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.settings, color: Colors.white),
                              ],
                            ),
                          ),
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://placehold.co/600x200/404040/FFFFFF.png?text=Banner'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: -50,
                        left: 16,
                        child: Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 4),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://placehold.co/100x100/404040/FFFFFF.png?text=Profile'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 2),
                                ),
                                child: const Icon(Icons.camera_alt,
                                    color: Colors.white, size: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),

                  // User Information Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Justin Chua',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '30 followers',
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                            const SizedBox(width: 8),
                            const Text('•', style: TextStyle(color: Colors.grey)),
                            const SizedBox(width: 8),
                            Text(
                              '10 following',
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'CHWAA',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileOrgPage()),
                                  );                               

                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  side: const BorderSide(color: Colors.white54),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Post',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                               context,
                                 MaterialPageRoute(builder: (context) => const ProfileOrgPage()), );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue, // Active button
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('About',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // About Section Content
                        const Text(
                          'Categories',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.badge, color: Colors.white54, size: 16),
                            const SizedBox(width: 8),
                            Text('Organizer',
                                style: TextStyle(color: Colors.grey[400])),
                          ],
                        ),
                        const SizedBox(height: 16),

                        const Text(
                          'Contact info',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.phone, color: Colors.white54, size: 16),
                            const SizedBox(width: 8),
                            Text('+639090142971',
                                style: TextStyle(color: Colors.grey[400])),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.email, color: Colors.white54, size: 16),
                            const SizedBox(width: 8),
                            Text('justinchua@gmail.com',
                                style: TextStyle(color: Colors.grey[400])),
                          ],
                        ),
                        const SizedBox(height: 16),

                        const Text(
                          'Websites and Social links',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.link, color: Colors.white54, size: 16),
                            const SizedBox(width: 8),
                            Text('https://www.figma.com/organizer/gggame',
                                style: TextStyle(color: Colors.grey[400])),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating navigation bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: _buildNavigationBar(),
            ),
          ),
        ],
      ),
    );
  }
}