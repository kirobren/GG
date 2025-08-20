import 'package:flutter/material.dart';
import 'package:gg/screens/home/organizer_page.dart';
import 'package:gg/screens/home/create_event.dart';
import 'package:gg/screens/home/search_org.dart';
import 'package:gg/screens/home/profile_about_org.dart';
import 'package:gg/screens/home/settings_org.dart';

class ProfileOrgPage extends StatefulWidget {
  const ProfileOrgPage({super.key});

  @override
  State<ProfileOrgPage> createState() => _ProfileOrgPageState();
}

class _ProfileOrgPageState extends State<ProfileOrgPage> {
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
        break;
    }
  }

  // New function to show the report dialog
  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text(
            'Report Post',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to report this post?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Report', style: TextStyle(color: Colors.red)),
              onPressed: () {
                // Add your reporting logic here
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090F16),
      body: Stack(
        children: [
          // Scrollable content
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
                              children: [
                                const Text(
                                  'Profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Wrap the Icon in a GestureDetector to make it clickable
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SettingsOrgPage(),
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.settings, color: Colors.white),
                                ),
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
                                border:
                                    Border.all(color: Colors.white, width: 4),
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
                            const Text('•',
                                style: TextStyle(color: Colors.grey)),
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
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue,
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
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileAboutOrgPage()),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  side: const BorderSide(color: Colors.white54),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('About',
                                    style: TextStyle(color: Colors.white54)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Create post section with navigation
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CreateEventPage()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Create your post',
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                                const Icon(Icons.arrow_forward_ios,
                                    color: Colors.white54, size: 16),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Sample Post 1
                        _buildPost(
                          context: context,
                          date: 'July 20 2025',
                          title:
                              'Magnolia Hotshots vs. Meralco Bolts in Iloilo',
                          imageUrl:
                              'https://placehold.co/600x400/404040/FFFFFF.png?text=Post+Image',
                          description:
                              'SHONN Miller dominated in his Meralco debut, finishing with 33 points and 13 rebounds. Magnolia cup of love.',
                        ),
                        const SizedBox(height: 16),

                        // Sample Post 2
                        _buildPost(
                          context: context,
                          date: 'July 21 2025',
                          title: 'Another event in Iloilo',
                          imageUrl:
                              'https://placehold.co/600x400/404040/FFFFFF.png?text=Another+Post+Image',
                          description:
                              'This is another placeholder post to demonstrate the scrolling fix.',
                        ),
                        const SizedBox(height: 16),
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
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 56.0, top: 8.0, right: 56.0, bottom: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF23262A),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.white, width: 2),
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
                            color: isSelected
                                ? const Color(0xFF23262A)
                                : Colors.white,
                            size: 22,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Updated _buildPost to accept BuildContext and handle the report dialog
  Widget _buildPost({
    required BuildContext context,
    required String date,
    required String title,
    required String imageUrl,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  Text(date, style: TextStyle(color: Colors.grey[400])),
                  const SizedBox(width: 8),
                  const Icon(Icons.favorite, color: Colors.red, size: 16),
                ],
              ),
              // Wrap the report icon in a GestureDetector
              GestureDetector(
                onTap: () => _showReportDialog(context),
                child: const Icon(Icons.report_outlined, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(description, style: TextStyle(color: Colors.grey[400])),
        ],
      ),
    );
  }
}