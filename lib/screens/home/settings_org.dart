import 'package:flutter/material.dart';
import 'package:gg/screens/landingpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gg/screens/home/become_org.dart'; // Import your BecomeOrgPage

class SettingsOrgPage extends StatelessWidget {
  const SettingsOrgPage({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return Scaffold(
      backgroundColor: const Color(0xFF090F16),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  // This widget checks the user's role to show the correct button
                  StreamBuilder<List<Map<String, dynamic>>>(
                    stream: supabase.from('profiles').select('role').eq('id', supabase.auth.currentUser!.id).asStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                        return const SizedBox();
                      }
                      
                      final userRole = snapshot.data![0]['role'];
                      
                      if (userRole == 'user') {
                        return _buildSettingsItem(
                          context: context,
                          title: 'Become an Organizer',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const BecomeOrgPage()),
                            );
                          },
                          icon: Icons.person_add,
                          showArrow: true,
                        );
                      } else {
                        return _buildSettingsItem(
                          context: context,
                          title: 'Switch to User',
                          onTap: () {
                            // Logic to switch back to user view (e.g., changing a local state or navigating)
                          },
                          icon: Icons.person,
                          showArrow: true,
                        );
                      }
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  _buildSettingsItem(
                    context: context,
                    title: 'App information',
                    onTap: () {},
                    icon: Icons.info_outline,
                    showArrow: true,
                  ),
                  _buildSettingsItem(
                    context: context,
                    title: 'Term & Privacy',
                    onTap: () {},
                    icon: Icons.lock_outline,
                    showArrow: true,
                  ),
                  _buildSettingsItem(
                    context: context,
                    title: 'About GG',
                    onTap: () {},
                    icon: Icons.help_outline,
                    showArrow: true,
                  ),
                  _buildSettingsItem(
                    context: context,
                    title: 'Log out',
                    onTap: () => _showLogoutDialog(context),
                    icon: Icons.logout,
                    showArrow: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ... (Your _buildSettingsItem and _showLogoutDialog methods remain the same)
  Widget _buildSettingsItem({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
    IconData? icon,
    bool showArrow = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            if (showArrow)
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text(
            'Log out',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to log out?',
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
              child: const Text('Log out', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LandingPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}