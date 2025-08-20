import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class BecomeOrgPage extends StatefulWidget {
  const BecomeOrgPage({super.key});

  @override
  State<BecomeOrgPage> createState() => _BecomeOrgPageState();
}

class _BecomeOrgPageState extends State<BecomeOrgPage> {
  final supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final birthdayController = TextEditingController();
  final addressController = TextEditingController();
  final linkController = TextEditingController();

  File? _profilePicture;
  List<File> _proofOfEventImages = [];
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    fullNameController.dispose();
    birthdayController.dispose();
    addressController.dispose();
    linkController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profilePicture = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickProofOfEventImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _proofOfEventImages.addAll(pickedFiles.map((xfile) => File(xfile.path)).toList());
      });
    }
  }

  void _removeProofOfEventImage(int index) {
    setState(() {
      _proofOfEventImages.removeAt(index);
    });
  }

  Future<void> registerOrganizer() async {
    if (_isLoading) return;

    if (!_formKey.currentState!.validate()) {
      _showSnackBar('Please fill in all required fields.', Colors.red);
      return;
    }

    if (_profilePicture == null || _proofOfEventImages.isEmpty) {
      _showSnackBar('Please upload all required images.', Colors.red);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        throw 'User not authenticated. Please log in again.';
      }

      final uuid = const Uuid();
      final String userId = user.id;

      // Upload profile picture
      final profilePicExtension = _profilePicture!.path.split('.').last;
      final uniqueProfilePicPath = '$userId/profile_pictures/${uuid.v4()}.$profilePicExtension';
      await supabase.storage
          .from('profile-pictures')
          .upload(uniqueProfilePicPath, _profilePicture!,
              fileOptions: const FileOptions(cacheControl: '3600', upsert: false));
      final profilePicUrl = supabase.storage.from('profile-pictures').getPublicUrl(uniqueProfilePicPath);

      // Upload proof of event images
      List<String> proofUrls = [];
      for (var file in _proofOfEventImages) {
        final proofExtension = file.path.split('.').last;
        final uniqueProofPath = '$userId/proof_of_events/${uuid.v4()}.$proofExtension';
        await supabase.storage
            .from('event-photos')
            .upload(uniqueProofPath, file,
                fileOptions: const FileOptions(cacheControl: '3600', upsert: false));
        proofUrls.add(supabase.storage.from('event-photos').getPublicUrl(uniqueProofPath));
      }

      // Check if a request already exists to prevent duplicates
      final existingRequests = await supabase.from('organizer_requests').select().eq('user_id', userId).limit(1);
      if (existingRequests.isNotEmpty) {
        await supabase.from('organizer_requests').update({
          'full_name': fullNameController.text,
          'email': user.email,
          'birthday': birthdayController.text,
          'address': addressController.text,
          'profile_picture_url': profilePicUrl,
          'proof_of_event_urls': proofUrls,
          'event_link': linkController.text,
          'status': 'pending',
          'created_at': DateTime.now().toIso8601String(),
        }).eq('user_id', userId);
        _showSnackBar('Your previous request has been updated and resubmitted for review.', Colors.blue);
      } else {
        // Insert a new organizer request
        await supabase.from('organizer_requests').insert({
          'user_id': userId,
          'full_name': fullNameController.text,
          'email': user.email,
          'birthday': birthdayController.text,
          'address': addressController.text,
          'profile_picture_url': profilePicUrl,
          'proof_of_event_urls': proofUrls,
          'event_link': linkController.text,
          'status': 'pending',
        });
        _showSnackBar('Your organizer request has been submitted successfully!', Colors.green);
      }
      _clearFormFields();
    } on PostgrestException catch (e) {
      _showSnackBar('Registration failed (Database): ${e.message}', Colors.red);
    } on StorageException catch (e) {
      _showSnackBar('Registration failed (File Upload): ${e.message}', Colors.red);
    } catch (e) {
      _showSnackBar('An unexpected error occurred: ${e.toString()}', Colors.red);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  
  void _showSnackBar(String message, Color color) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
        ),
      );
    }
  }

  void _clearFormFields() {
    fullNameController.clear();
    birthdayController.clear();
    addressController.clear();
    linkController.clear();
    setState(() {
      _profilePicture = null;
      _proofOfEventImages = [];
    });
  }

  Widget _buildUploadField({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    File? file,
  }) {
    return GestureDetector(
      onTap: _isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white30),
        ),
        child: file != null
            ? Image.file(file, height: 100, fit: BoxFit.cover)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 40, color: Colors.white54),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white60),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white30),
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        readOnly: readOnly || _isLoading,
        onTap: _isLoading ? null : onTap,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          border: InputBorder.none,
          suffixIcon: icon != null ? Icon(icon, color: Colors.white54) : null,
        ),
      ),
    );
  }

  Widget _buildProofImage(File file, int index) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.file(
            file,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: _isLoading ? null : () => _removeProofOfEventImage(index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090F16),
      appBar: AppBar(
        title: const Text(
          'Become an organizer',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUploadField(
                    title: 'Upload your profile picture',
                    subtitle: '',
                    icon: Icons.image,
                    onTap: () => _pickImage(ImageSource.gallery),
                    file: _profilePicture,
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    controller: fullNameController,
                    hint: 'Full Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                          controller: birthdayController,
                          hint: 'Birthday',
                          icon: Icons.calendar_today,
                          readOnly: true,
                          onTap: () async {
                            final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              setState(() {
                                birthdayController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select your birthday';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildInputField(
                          controller: addressController,
                          hint: 'Address',
                          icon: Icons.location_on,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Proof or picture of a past event that you organized',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  _buildUploadField(
                    title: 'Upload proof of event',
                    subtitle: '(Image)',
                    icon: Icons.upload_file,
                    onTap: _pickProofOfEventImages,
                  ),
                  const SizedBox(height: 16),
                  // Display selected images
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(_proofOfEventImages.length, (index) {
                      return _buildProofImage(_proofOfEventImages[index], index);
                    }),
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    controller: linkController,
                    hint: 'Link to a past event ',
                    icon: Icons.link,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final urlRegex = RegExp(r"^(https?|ftp)://[^\s/$.?#].[^\s]*$");
                        if (!urlRegex.hasMatch(value)) {
                          return 'Please enter a valid URL';
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : registerOrganizer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 55, 186, 193),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}