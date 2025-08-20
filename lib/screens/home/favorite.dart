import 'package:flutter/material.dart';
import 'package:gg/screens/home/homepage.dart';
import 'package:gg/screens/profile/profile_favorite.dart';
import 'package:gg/screens/home/explore.dart';
import 'package:provider/provider.dart';
import 'package:gg/providers/favorites_provider.dart';
import 'package:gg/models/event.dart';
import 'package:gg/screens/notification.dart'; // Import the NotificationPage

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int _selectedIndex = 1;

  final List<IconData> _navIcons = [
    Icons.home,
    Icons.favorite,
    Icons.search,
    Icons.person,
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ExplorePage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileFavoritePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF23262A),
      body: Stack(
        children: [
          // Scrollable Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 100), // Add padding for the nav bar
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Favorites',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Wrap the Icon with a GestureDetector to add onTap functionality
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationsScreen()),
                            );
                          },
                          child:
                              const Icon(Icons.notifications_none, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Consumer<FavoritesProvider>(
                    builder: (context, favoritesProvider, child) {
                      if (favoritesProvider.favoriteEvents.isEmpty) {
                        return const Expanded(
                          child: Center(
                            child: Text(
                              'No favorite events yet!',
                              style:
                                  TextStyle(color: Colors.white70, fontSize: 16),
                            ),
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: favoritesProvider.favoriteEvents.length,
                          itemBuilder: (context, index) {
                            final event = favoritesProvider.favoriteEvents[index];
                            return _buildFavoriteCard(event, favoritesProvider);
                          },
                        ),
                      );
                    },
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

  Widget _buildFavoriteCard(Event event, FavoritesProvider favoritesProvider) {
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
              favoritesProvider.toggleFavorite(event);
            },
          ),
        ],
      ),
    );
  }
}