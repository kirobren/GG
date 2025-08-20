import 'package:flutter/material.dart';
import 'package:gg/screens/home/homepage.dart';
import 'package:gg/screens/home/favorite.dart';
import 'package:gg/screens/profile/profile_favorite.dart';
import 'package:gg/screens/notification.dart'; // Import the NotificationPage

class SportsEvent {
  final String title;
  final String location;
  final String date;
  final String imageUrl;
  final String description;

  SportsEvent({
    required this.title,
    required this.location,
    required this.date,
    required this.imageUrl,
    required this.description,
  });

  factory SportsEvent.fromMap(Map<String, dynamic> map) {
    return SportsEvent(
      title: map['title'],
      location: map['location'],
      date: map['date'],
      imageUrl: map['image_url'],
      description: map['description'],
    );
  }
}

final List<SportsEvent> allSportsEvents = [
  SportsEvent(
    title: 'Magnolia Hotshots vs. Meralco Bolts',
    location: 'Passi Iloilo City',
    date: 'July 15 20, 2025',
    imageUrl: 'assets/sports_sample.jpg',
    description:
        'SHONN Miller dominated in his Meralco debut, finishing with 33 points and 22 rebounds to lift the Bolts to an 85-80 win over Magnolia Chicken Timplados in the PBA 49th season Commissioners Cup at the University of San Agustin gym in Iloilo City.',
  ),
  SportsEvent(
    title: 'San Miguel Beermen vs. Ginebra Gin Kings',
    location: 'Araneta Coliseum',
    date: 'August 10, 2025',
    imageUrl: 'assets/event_sample2.jpg',
    description: 'A classic Manila Clasico match featuring two rival teams.',
  ),
  SportsEvent(
    title: 'Iloilo Chess Tournament',
    location: 'Iloilo Convention Center',
    date: 'September 5-7, 2025',
    imageUrl: 'assets/chess_sample.jpg',
    description: 'Annual chess tournament open to all skill levels.',
  ),
  SportsEvent(
    title: 'Badminton Doubles Championship',
    location: 'La Paz Gym, Iloilo',
    date: 'October 2, 2025',
    imageUrl: 'assets/badminton_sample.jpg',
    description: 'Exciting badminton action with top local players.',
  ),
];

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int _selectedIndex = 2;

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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FavoritePage()),
        );
        break;
      case 2:
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileFavoritePage()),
        );
        break;
    }
  }

  // Extracted the navigation bar into its own method for reusability.
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
                    color: isSelected ? const Color(0xFFFFFFFF) : Colors.transparent,
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
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardVisible = bottomInset > 0;

    return Scaffold(
      backgroundColor: const Color(0xFF23262A),
      body: Stack(
        children: [
          // Main content area
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  // Add padding to ensure content is not hidden by the nav bar,
                  // accounting for the keyboard height if it's visible.
                  bottom: isKeyboardVisible ? bottomInset + 100 : 100,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Explore Events',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          // Wrap the notification icon with a GestureDetector
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const NotificationsScreen ()),
                              );
                            },
                            child:
                                const Icon(Icons.notifications_none, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Autocomplete<SportsEvent>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<SportsEvent>.empty();
                          }
                          return allSportsEvents.where((SportsEvent event) {
                            return event.title.toLowerCase().contains(
                                  textEditingValue.text.toLowerCase(),
                                );
                          });
                        },
                        displayStringForOption: (SportsEvent option) =>
                            option.title,
                        fieldViewBuilder: (
                          BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted,
                        ) {
                          return TextField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            onSubmitted: (value) {
                              onFieldSubmitted();
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Search for sports events...',
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: const Color(0xFF35383F),
                              prefixIcon:
                                  const Icon(Icons.search, color: Colors.white54),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          );
                        },
                        optionsViewBuilder: (
                          BuildContext context,
                          AutocompleteOnSelected<SportsEvent> onSelected,
                          Iterable<SportsEvent> options,
                        ) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              elevation: 4.0,
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF35383F),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width - 32,
                                ),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final SportsEvent option =
                                        options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Selected: ${option.title}'),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(4),
                                              child: Image.asset(
                                                option.imageUrl,
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    width: 50,
                                                    height: 50,
                                                    color: Colors.grey.shade700,
                                                    child: const Icon(
                                                      Icons.broken_image,
                                                      size: 20,
                                                      color: Colors.white54,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    option.title,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    option.location,
                                                    style: const TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 12,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'Explore upcoming and recommended events!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // The floating navigation bar, only when the keyboard is visible.
          if (isKeyboardVisible)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildNavigationBar(),
            ),
        ],
      ),
      // Standard bottom navigation bar when the keyboard is not visible.
      bottomNavigationBar: isKeyboardVisible ? null : _buildNavigationBar(),
    );
  }
}