import 'package:flutter/material.dart';
import 'package:gg/screens/home/create_event.dart';
import 'package:gg/screens/home/profile_org.dart';
import 'package:gg/screens/home/search_org.dart';
import 'package:gg/screens/home/notif_org.dart';

// Mock models to make this file runnable on its own.
// In a real app, this would be in a separate file.
class Event {
  final String id;
  final String title;
  final String date;
  final String description;
  final String imageUrl;
  final String location;
  final String sportCategory;

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.sportCategory,
  });
}



class OrganizerPage extends StatefulWidget {
  const OrganizerPage({super.key});

  @override
  State<OrganizerPage> createState() => _OrganizerPageState();
}

class _OrganizerPageState extends State<OrganizerPage> {
  int _selectedIndex = 0;
  int _selectedChip = 0;

  final List<IconData> _navIcons = [
    Icons.home,
    Icons.edit_note,
    Icons.search,
    Icons.person,
  ];

  final List<String> _chipLabels = ['All', 'Basketball', 'Badminton', 'Boxing'];

  final List<Event> _events = [
    Event(
      id: 'a0e1b2c3-d4e5-f678-9012-3456789abcdef0',
      title: 'Magnolia Hotshots vs. Meralco Bolts in Iloilo',
      date: 'July 20 2025',
      description:
          'SHONN Miller dominated in his Meralco debut, finishing with 33 points and 22 rebounds to lift the Bolts to an 85-80 win over Magnolia Chicken Timplados in the PBA 49th season Commissioners Cup at the University of San Agustin gym in Iloilo City.',
      imageUrl: 'assets/sports_sample.jpg',
      location: 'Iloilo City',
      sportCategory: 'Basketball',
    ),
    Event(
      id: 'b1f2c3d4-e5f6-7890-1234-567890abcdef11',
      title: 'Badminton Doubles Championship',
      date: 'August 5 2025',
      description:
          'Witness intense badminton action as top players compete for the championship title. Don\'t miss out!',
      imageUrl: 'assets/event_sample.jpg',
      location: 'Quezon City Sports Complex',
      sportCategory: 'Badminton',
    ),
    Event(
      id: 'c2g3d4e5-f678-9012-3456-7890abcdef22',
      title: 'Boxing Extravaganza: The Grand Showdown',
      date: 'September 1 2025',
      description:
          'A night of thrilling boxing matches featuring local and international fighters. Get ready for an unforgettable experience!',
      imageUrl: 'assets/event_sample2.jpg',
      location: 'Cebu City Arena',
      sportCategory: 'Boxing',
    ),
  ];

  List<Event> get _filteredEvents {
    if (_selectedChip == 0) {
      return _events;
    }
    final selectedSport = _chipLabels[_selectedChip];
    return _events.where((event) => event.sportCategory == selectedSport).toList();
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Already on this page, do nothing or navigate to a fresh instance
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileOrgPage()),
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
          // Main content with padding for the floating nav bar
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top App Bar
                  Padding(
                      padding: const EdgeInsets.only(
                    left: 12.0, top: 8.0, right: 2, bottom: 8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/whistle.png',
                          height: 32,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.sports_soccer, color: Colors.white, size: 32);
                          },
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Good Game',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        // The IconButton for navigation
                        IconButton(
                          icon: const Icon(Icons.notifications_none, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NotifOrgScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Recent events',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 120,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFF35383F),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/developmental_league.jpg',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade700,
                                  child: const Center(
                                    child: Text(
                                      'Image Error',
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/dinasug_chess_tournament.jpg',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade700,
                                  child: const Center(
                                    child: Text(
                                      'Image Error',
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: List.generate(_chipLabels.length, (i) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedChip = i;
                            });
                          },
                          child: SizedBox(
                            width: _chipLabels[i] == 'All' ? null : 120,
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: Chip(
                                label: Center(
                                  child: Text(
                                    _chipLabels[i],
                                    style: TextStyle(
                                      color: _selectedChip == i ? Colors.black : Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                backgroundColor: _selectedChip == i ? Colors.white : Colors.black,
                                shape: const StadiumBorder(
                                  side: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Recommend sports',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    physics: const NeverScrollableScrollPhysics(), 
                    shrinkWrap: true,
                    itemCount: _filteredEvents.length,
                    itemBuilder: (context, index) {
                      return _buildSportCard(
                        _filteredEvents[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Floating navigation bar positioned at the bottom
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

  Widget _buildSportCard(Event event) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tapped on ${event.title}')),
        );
      },
      child: Card(
        color: const Color(0xFF35383F),
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/whistle.png', height: 24, width: 24,
                      errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.sports_soccer, color: Colors.white, size: 24);
                  }),
                  const SizedBox(width: 8),
                  Text(
                    event.date,
                    style: const TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsets.only(
                    left: 56.0, top: 8.0, right: 0, bottom: 8.0),
                    icon: const Icon(
                      Icons.report_gmailerrorred,
                      color: Color(0xFFBDBDBD),
                      size: 20,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Reported ${event.title}')),
                      );
                    },
                    tooltip: 'Report',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                event.title,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  event.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      width: double.infinity,
                      color: Colors.grey.shade700,
                      child: const Center(
                        child: Text(
                          'Image Not Found',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Text(
                event.description,
                style: const TextStyle(color: Color(0xFFBDBDBD), fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}