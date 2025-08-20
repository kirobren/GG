import 'package:flutter/material.dart';
import 'package:gg/screens/home/homepage.dart';
import 'package:gg/screens/home/explore.dart';
import 'package:gg/screens/home/favorite.dart';
import 'package:gg/models/event.dart';
import 'package:gg/screens/profile/settings.dart';

enum ProfileTab { posts, about }

class ProfileFavoritePage extends StatefulWidget {
  const ProfileFavoritePage({super.key});

  @override
  State<ProfileFavoritePage> createState() => _ProfileFavoritePageState();
}

class _ProfileFavoritePageState extends State<ProfileFavoritePage> {
  int _selectedIndex = 3;

  final List<IconData> _navIcons = [
    Icons.home,
    Icons.favorite,
    Icons.search,
    Icons.person,
  ];

  ProfileTab _currentTab = ProfileTab.posts;

  String? _coverPhotoUrl = 'https://placehold.co/800x200/404040/FFFFFF.png?text=Banner';
  String? _profilePhotoUrl = 'https://placehold.co/100x100/404040/FFFFFF.png?text=Profile';

  final List<Event> _favoriteEvents = [
    Event(
      id: 'a0e1b2c3-d4e5-f678-9012-3456789abcdef0',
      title: 'Magnolia Hotshots vs. Meralco Bolts',
      date: 'July 20, 2023',
      description: 'Sample description.',
      imageUrl: 'assets/sports_sample.jpg',
      location: 'Iloilo City',
      sportCategory: 'Basketball',
    ),
    Event(
      id: 'a0e1b2c3-d4e5-f678-9012-3456789abcdef1',
      title: 'Magnolia Hotshots vs. Meralco Bolts',
      date: 'July 15, 2025',
      description: 'Sample description.',
      imageUrl: 'assets/sports_sample.jpg',
      location: 'Passi Iloilo City',
      sportCategory: 'Basketball',
    ),
    Event(
      id: 'a0e1b2c3-d4e5-f678-9012-3456789abcdef2',
      title: 'Magnolia Hotshots vs. Meralco Bolts',
      date: 'July 10, 2025',
      description: 'Sample description.',
      imageUrl: 'assets/sports_sample.jpg',
      location: 'Passi Iloilo City',
      sportCategory: 'Basketball',
    ),
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
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FavoritePage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ExplorePage()),
        );
        break;
      case 3:
        break;
    }
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
                  _buildProfileHeader(),
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
                          'CHWMA',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 16),

                        // Tab Selector
                        _buildTabSelector(),
                        const SizedBox(height: 16),

                        // Tab Content
                        _buildTabContent(),
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

  Widget _buildProfileHeader() {
    return Stack(
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
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
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: NetworkImage(
                      _coverPhotoUrl!),
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
                  image: DecorationImage(
                    image: NetworkImage(_profilePhotoUrl!),
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
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.camera_alt,
                      color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white54, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                setState(() {
                  _currentTab = ProfileTab.posts;
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: _currentTab == ProfileTab.posts
                    ? Colors.blue
                    : Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Posts',
                style: TextStyle(
                    color: _currentTab == ProfileTab.posts
                        ? Colors.white
                        : Colors.white54),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                setState(() {
                  _currentTab = ProfileTab.about;
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: _currentTab == ProfileTab.about
                    ? Colors.blue
                    : Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'About',
                style: TextStyle(
                    color: _currentTab == ProfileTab.about
                        ? Colors.white
                        : Colors.white54),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_currentTab) {
      case ProfileTab.posts:
        return ListView.builder(
          shrinkWrap: true, // Key change for a ListView inside a SingleChildScrollView
          physics: const NeverScrollableScrollPhysics(), // Key change
          padding: EdgeInsets.zero,
          itemCount: _favoriteEvents.length,
          itemBuilder: (context, index) =>
              _buildFavoriteCard(_favoriteEvents[index]),
        );
      case ProfileTab.about:
        return _buildAboutContent();
      default:
        return const Center(
          child: Text('No content', style: TextStyle(color: Colors.white)),
        );
    }
  }

  Widget _buildFavoriteCard(Event event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF35383F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white30),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              event.imageUrl,
              width: 100,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 70,
                  color: Colors.grey.shade700,
                  child: const Icon(Icons.broken_image, color: Colors.white54),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  event.location,
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
                Text(
                  event.date,
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 24,
            ),
            onPressed: () {
              // This is a placeholder as the profile page doesn't manage favorites directly
              // You would likely handle this logic in a provider or state management solution.
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutContent() {
    return Column(
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
            children: [_buildLinkRow('https://www.figma.com/organizer/gggame')],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoContainer({required String title, required Widget content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
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
}