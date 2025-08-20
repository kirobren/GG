
import 'package:flutter/material.dart';
import 'package:gg/screens/home/organizer_page.dart';
import 'package:gg/screens/home/create_event.dart';
import 'package:gg/screens/home/profile_org.dart';

class Event {
  final String title;
  final String date;
  final String location;

  Event({
    required this.title,
    required this.date,
    required this.location,
  });
}

// This is the new search page with a bottom navigation bar
class SearchOrgPage extends StatefulWidget {
  const SearchOrgPage({super.key});

  @override
  State<SearchOrgPage> createState() => _SearchEventsPageState();
}

class _SearchEventsPageState extends State<SearchOrgPage> {
  // Controller for the search text field
  final TextEditingController _searchController = TextEditingController();

  // State variables for managing the search and navigation
  bool _isLoading = false;
  List<Event> _searchResults = [];
  bool _hasSearched = false;

  // Navigation variables, matching the create_event.dart page
  int _selectedIndex = 2; // Default to SearchEventsPage
  final List<IconData> _navIcons = [
    Icons.home,
    Icons.edit_note,
    Icons.search,
    Icons.person,
  ];

  // A list of mock events for demonstration
  final List<Event> _mockEvents = [
    Event(
      title: 'City Marathon',
      date: '2025-08-25',
      location: 'Central Park',
    ),
    Event(
      title: 'Basketball Tournament',
      date: '2025-09-10',
      location: 'Sports Arena',
    ),
    Event(
      title: 'Weekly Yoga Session',
      date: '2025-08-18',
      location: 'Community Hall',
    ),
    Event(
      title: 'Soccer League Match',
      date: '2025-08-20',
      location: 'Soccer Field 5',
    ),
    Event(
      title: 'Outdoor Hiking Trip',
      date: '2025-09-02',
      location: 'Mountain Trails',
    ),
    Event(
      title: 'Table Tennis Tournament',
      date: '2025-08-28',
      location: 'Recreation Center',
    ),
    Event(
      title: 'Summer Volleyball League',
      date: '2025-09-05',
      location: 'Beach Courts',
    ),
  ];

  // Function to simulate a search for events
  void _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _hasSearched = true;
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _hasSearched = true;
      _searchResults = []; // Clear previous results
    });

    // Simulate a network request with a delay
    await Future.delayed(const Duration(seconds: 1));

    // Filter the mock events based on the query
    final results = _mockEvents
        .where((event) =>
            event.title.toLowerCase().contains(query.toLowerCase()) ||
            event.location.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _isLoading = false;
      _searchResults = results;
    });
  }

  // A reusable widget for the input fields, similar to your existing code
  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    VoidCallback? onSubmitted,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white30),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          border: InputBorder.none,
          suffixIcon: icon != null
              ? IconButton(
                  icon: Icon(icon, color: Colors.white54),
                  onPressed: () {
                    // Call the search function when the icon is pressed
                    _performSearch(controller.text);
                  },
                )
              : null,
        ),
        onSubmitted: (value) {
          _performSearch(value);
        },
      ),
    );
  }

  // A widget to display the search results
  Widget _buildSearchResults() {
    if (!_hasSearched) {
      return const Center(
        child: Text(
          'Search for an event by title or location.',
          style: TextStyle(color: Colors.white70, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
            color: Color.fromARGB(255, 55, 186, 193)),
      );
    }
    if (_searchResults.isEmpty) {
      return const Center(
        child: Text(
          'No events found. Try a different search.',
          style: TextStyle(color: Colors.white70, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }

    // Display the list of events
    return ListView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Prevent nested scrolling issues
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final event = _searchResults[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        color: Colors.white54, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      event.date,
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        color: Colors.white54, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      event.location,
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Applied button styling from profile_org.dart
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          // Handle Post button press
                        },
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
                          // Handle About button press
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
              ],
            ),
          ),
        );
      },
    );
  }

  // Method to handle navigation bar taps
  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      return;
    }

    // Check if the widget is mounted before updating the state
    if (mounted) {
      setState(() {
        _selectedIndex = index;
      });
    }

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
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileOrgPage()),
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
                    color:
                        isSelected ? const Color(0xFFFFFFFF) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _navIcons[index],
                    color:
                        isSelected ? const Color(0xFF23262A) : Colors.white,
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
      backgroundColor: const Color(0xFF090F16),
      body: Stack(
        children: [
          // The main content of the page is a scrollable view.
          // It has a bottom padding to ensure the content doesn't get hidden
          // by the floating navigation bar.
          SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16.0,
              top: 52.0,
              right: 16.0,
              // Add padding equal to the height of the bottom nav bar + its margin
              bottom: isKeyboardVisible ? bottomInset + 100 : 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Search for Events',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _searchController,
                  hint: 'Search by event title or location',
                  icon: Icons.search,
                ),
                const SizedBox(height: 16),
                // Display search results
                _buildSearchResults(),
              ],
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
