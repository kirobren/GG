  import 'package:flutter/material.dart';
  import 'package:gg/screens/profile/profile_favorite.dart';
  import 'package:supabase_flutter/supabase_flutter.dart';
  import 'package:gg/screens/home/explore.dart';
  import 'package:gg/screens/home/favorite.dart';
  import 'package:provider/provider.dart';
  import 'package:gg/providers/favorites_provider.dart';
  import 'package:gg/models/event.dart';
  import 'package:gg/screens/notification.dart';
  import 'package:gg/screens/home/event_details.dart';

  class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _selectedChip = 0;

  final List<IconData> _navIcons = [
  Icons.home,
  Icons.favorite,
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

  void _onItemTapped(int index) {
  if (index == _selectedIndex) {
  return;
  }

  setState(() {
  _selectedIndex = index;
  });

  switch (index) {
  case 0:
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
  Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const ProfileFavoritePage()),
  );
  break;
  }
  }

  final TextEditingController _reportController = TextEditingController();

  void _showReportDialog(BuildContext context, Event event) {
  showDialog(
  context: context,
  builder: (BuildContext context) {
  return AlertDialog(
  backgroundColor: const Color(0xFF222222),
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(15),
  side: const BorderSide(color: Colors.white, width: 1),
  ),
  title: const Text(
  'Report Post',
  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
  content: SingleChildScrollView(
  child: ListBody(
  children: <Widget>[
  const Text(
  'Please tell us why you are reporting this post:',
  style: TextStyle(color: Colors.white70),
  ),
  const SizedBox(height: 15),
  TextField(
  controller: _reportController,
  maxLines: 4,
  decoration: InputDecoration(
  hintText: 'Enter your reason here...',
  hintStyle: const TextStyle(color: Colors.white54),
  filled: true,
  fillColor: const Color(0xFF23262A),
  border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(color: Colors.white30),
  ),
  enabledBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(color: Colors.white30),
  ),
  focusedBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(color: Colors.white),
  ),
  ),
  style: const TextStyle(color: Colors.white),
  ),
  ],
  ),
  ),
  actions: <Widget>[
  TextButton(
  child: const Text(
  'Cancel',
  style: TextStyle(color: Colors.white70),
  ),
  onPressed: () {
  _reportController.clear();
  Navigator.of(context).pop();
  },
  ),
  ElevatedButton(
  style: ElevatedButton.styleFrom(
  backgroundColor: Colors.red,
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(8),
  ),
  ),
  child: const Text(
  'Report',
  style: TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  ),
  ),
  onPressed: () {
  _submitReport(event, _reportController.text);
  _reportController.clear();
  Navigator.of(context).pop();
  },
  ),
  ],
  );
  },
  );
  }

  Future<void> _submitReport(Event event, String reason) async {
  try {
  print('DEBUG: Attempting to submit report for event ID: ${event.id}');

  await Supabase.instance.client.from('reports').insert({
  'event_id': event.id,
  'reason': reason,
  'user_id': Supabase.instance.client.auth.currentUser?.id,
  });

  if (context.mounted) {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
  content: Text('Report submitted for "${event.title}"!'),
  backgroundColor: Colors.green,
  ),
  );
  }
  print('Report successfully submitted for event: ${event.id}');
  } catch (e) {
  if (context.mounted) {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
  content: Text('Failed to submit report. Error: $e'),
  backgroundColor: Colors.red,
  ),
  );
  }
  print('Error submitting report: $e');
  }
  }

  List<Event> get _filteredEvents {
  if (_selectedChip == 0) {
  return _events;
  }
  final selectedSport = _chipLabels[_selectedChip];
  return _events.where((event) => event.sportCategory == selectedSport).toList();
  }

  void _navigateToNotifications() {
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const NotificationsScreen()),
  );
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  backgroundColor: const Color(0xFF23262A),
  body: Stack(
  children: [
  // Scrollable Content
  SafeArea(
  child: SingleChildScrollView(
  padding: const EdgeInsets.only(bottom: 100), // Space for nav bar
  child: Column(
  children: [
  Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: Row(
  children: [
  GestureDetector(
  onTap: () {

  },
  child: Image.asset('assets/whistle.png', height: 32),
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
  GestureDetector(
  onTap: _navigateToNotifications,
  child: const Icon(Icons.notifications_none, color: Colors.white),
  ),
  ],
  ),
  ),
  const SizedBox(height: 16),
  const Padding(
  padding: EdgeInsets.symmetric(horizontal: 16),
  child: Align(
  alignment: Alignment.centerLeft,
  child: Text(
  'Upcoming events',
  style: TextStyle(
  color: Color(0xFFFFFFFF),
  fontSize: 16,
  fontWeight: FontWeight.bold,
  ),
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
  'assets/event_sample.jpg',
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
  'assets/event_sample2.jpg',
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
  color: _selectedChip == i ? Colors.white : Colors.black,
  fontWeight: FontWeight.normal,
  ),
  ),
  ),
  backgroundColor: _selectedChip == i ? Colors.black : Colors.white,
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
  child: Align(
  alignment: Alignment.centerLeft,
  child: Text(
  'Recommend sports',
  style: TextStyle(
  color: Color(0xFFFFFFFF),
  fontSize: 16,
  fontWeight: FontWeight.bold,
  ),
  ),
  ),
  ),
  ListView.builder(
  physics: const NeverScrollableScrollPhysics(), // Important to prevent nested scrolling issues
  shrinkWrap: true,
  padding: const EdgeInsets.symmetric(horizontal: 16),
  itemCount: _filteredEvents.length,
  itemBuilder: (context, index) {
  return _buildSportCard(_filteredEvents[index]);
  },
  ),
  ],
  ),
  ),
  ),

  // Floating Navigation Bar
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
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => EventDetailsPage(event: event)),
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
  Image.asset('assets/whistle.png', height: 24, width: 24),
  const SizedBox(width: 8),
  Text(
  event.date,
  style: const TextStyle(
  color: Color(0xFFBDBDBD),
  fontSize: 12,
  ),
  ),
  const Spacer(),
  Consumer<FavoritesProvider>(
  builder: (context, favoritesProvider, child) {
  final isFavorite = favoritesProvider.isFavorite(event);
  return IconButton(
  icon: Icon(
  isFavorite ? Icons.favorite : Icons.favorite_border,
  color: isFavorite ? Colors.red : const Color(0xFFBDBDBD),
  size: 24,
  ),
  onPressed: () {
  favoritesProvider.toggleFavorite(event);
  },
  );
  },
  ),
  const SizedBox(width: 8),
  IconButton(
  icon: const Icon(
  Icons.report_gmailerrorred,
  color: Color(0xFFBDBDBD),
  size: 20,
  ),
  onPressed: () {
  _showReportDialog(context, event);
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
  'Image Error',
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