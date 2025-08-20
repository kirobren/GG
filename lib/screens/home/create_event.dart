import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gg/screens/home/organizer_page.dart';
import 'package:gg/screens/home/search_org.dart';
import 'package:gg/screens/home/profile_org.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// This is the main page
class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  // Text controllers for the input fields
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkController = TextEditingController();

  // New list of sports for the dropdown menu
  final List<String> _sportsOptions = [
    'Basketball',
    'Football',
    'Soccer',
    'Tennis',
    'Volleyball',
    'Running',
    'Cycling',
    'Swimming',
    'Gymnastics',
    'Baseball',
    'Badminton',
    'Boxing',
    'Golf',
    'Table Tennis',
  ];

  // New state variable to hold the selected sport from the dropdown
  String? _selectedSport;

  // State variables for navigation and page content
  int _selectedIndex = 1; // Default to CreateEventPage
  final List<IconData> _navIcons = [
    Icons.home,
    Icons.edit_note,
    Icons.search,
    Icons.person,
  ];
  File? _eventPicture;
  bool _isLoading = false;

  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    timeController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    linkController.dispose();
    super.dispose();
  }

  // Function to handle picking a single image
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _eventPicture = File(pickedFile.path);
      });
    }
  }

  // Function to show a date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color.fromARGB(255, 55, 186, 193),
              onPrimary: Colors.black,
              surface: Color(0xFF1E1E1E),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  // Function to show a time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color.fromARGB(255, 55, 186, 193),
              onPrimary: Colors.black,
              surface: Color(0xFF1E1E1E),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      setState(() {
        timeController.text = pickedTime.format(context);
      });
    }
  }

  // Function to handle the event submission logic
  Future<void> _submitEvent() async {
    if (_isLoading) return;

    // Updated validation check to use the new _selectedSport variable
    if (titleController.text.isEmpty ||
        dateController.text.isEmpty ||
        timeController.text.isEmpty ||
        locationController.text.isEmpty ||
        _selectedSport == null || // Check if a sport is selected
        descriptionController.text.isEmpty ||
        _eventPicture == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill out all required fields and upload an image.'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate sending data to a backend
      print('--- Event Submission Data ---');
      print('Title: ${titleController.text}');
      print('Date: ${dateController.text}');
      print('Time: ${timeController.text}');
      print('Location: ${locationController.text}');
      print('Sports: $_selectedSport'); // Use the new state variable
      print('Description: ${descriptionController.text}');
      print('Link: ${linkController.text}');
      print('Event Picture: ${_eventPicture!.path}');
      print('--- End of Submission ---');

      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Event submitted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Submission failed: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // A reusable widget for the input fields
  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    bool readOnly = false,
    VoidCallback? onTap,
    int maxLines = 1,
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
        readOnly: readOnly,
        onTap: onTap,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          border: InputBorder.none,
          suffixIcon: icon != null ? Icon(icon, color: Colors.white54) : null,
        ),
      ),
    );
  }

  // New method to handle navigation bar taps, updated to match your code.
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
        // Already on CreateEventPage, no need to navigate.
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
      backgroundColor: const Color(0xFF090F16),
      body: Stack(
        children: [
          // Wrap the SingleChildScrollView with SafeArea
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- UPDATED Title Input Field ---
                    _buildInputField(
                      controller: titleController,
                      hint: 'Title', // Now a placeholder inside the box
                    ),
                    const SizedBox(height: 16),
                    // --- END UPDATED Title Input Field ---
                    // --- UPDATED Upload Image Section ---
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white30),
                        ),
                        child: _eventPicture != null
                            ? Image.file(
                                _eventPicture!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  // Error handling for displaying the image
                                  return const Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.error_outline,
                                            size: 40, color: Colors.red),
                                        SizedBox(height: 8),
                                        Text(
                                          'Invalid image file',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.upload_file,
                                      size: 40, color: Colors.white54),
                                  SizedBox(height: 8),
                                  Text(
                                    '→ Upload your picture',
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // --- END UPDATED Upload Image Section ---
                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField(
                            controller: dateController,
                            hint: 'Date',
                            readOnly: true,
                            onTap: () => _selectDate(context),
                            icon: Icons.calendar_today,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildInputField(
                            controller: timeController,
                            hint: 'Time',
                            readOnly: true,
                            onTap: () => _selectTime(context),
                            icon: Icons.access_time,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      controller: locationController,
                      hint: 'Location',
                      icon: Icons.location_on,
                    ),
                    const SizedBox(height: 16),

                    // The new Dropdown for Sports
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: DropdownButtonFormField<String>(
                        dropdownColor: const Color(0xFF1E1E1E),
                        value: _selectedSport,
                        hint: const Text(
                          'Select a sport',
                          style: TextStyle(color: Colors.white54),
                        ),
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.sports, color: Colors.white54),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedSport = newValue;
                          });
                        },
                        items: _sportsOptions
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 16),
                    _buildInputField(
                      controller: descriptionController,
                      hint: 'Descriptions...',
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      controller: linkController,
                      hint: 'Link',
                      icon: Icons.link,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitEvent,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 55, 186, 193),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Submit event'),
                      ),
                    ),
                  ],
                ),
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
}
