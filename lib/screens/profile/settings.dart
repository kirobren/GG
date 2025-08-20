import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gg/screens/home/become_org.dart';

enum _CurrentView { main, appInfo, termPrivacy, aboutGG }

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isOrganizer = false;
  bool _isLoading = true;
  _CurrentView _currentView = _CurrentView.main;

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
  }

  Future<void> _fetchUserRole() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return;

      final response = await Supabase.instance.client
          .from('profiles')
          .select('is_organizer')
          .eq('id', user.id)
          .single();

      if (mounted) {
        setState(() {
          _isOrganizer = response['is_organizer'] ?? false;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        print('Error fetching user role: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load user information.')),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleSwitchToUser() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await Supabase.instance.client
          .from('profiles')
          .update({'is_organizer': false})
          .eq('id', user.id);

      if (mounted) {
        setState(() {
          _isOrganizer = false;
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Switched to User mode successfully!'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        print('Error switching role: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to switch roles. Please try again.')),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2E3137),
          title: const Text('Confirm Logout', style: TextStyle(color: Colors.white)),
          content: const Text('Are you sure you want to log out?', style: TextStyle(color: Colors.white70)),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text('Logout', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _handleLogout();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleLogout() async {
    try {
      await Supabase.instance.client.auth.signOut();
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/landing');
      }
    } catch (e) {
      if (mounted) {
        print('Logout Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to log out. Please try again.')),
        );
      }
    }
  }

  Widget _buildMainSettingsView() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2E3137),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Text(
              _isOrganizer ? 'Switch to User' : 'Switch to Organizer',
              style: const TextStyle(color: Colors.white),
            ),
            trailing: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.chevron_right, color: Colors.white),
            onTap: _isLoading
                ? null
                : () {
                    if (_isOrganizer) {
                      _handleSwitchToUser();
                    } else {
                      // Navigate to the organizer signup page instead of showing a dialog
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BecomeOrgPage()),
                      );
                    }
                  },
          ),
        ),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2E3137),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.info_outline, color: Colors.white70),
                title: const Text('App information', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.chevron_right, color: Colors.white),
                onTap: () => setState(() => _currentView = _CurrentView.appInfo),
              ),
              const Divider(color: Colors.white12, height: 1),
              ListTile(
                leading: const Icon(Icons.lock_outline, color: Colors.white70),
                title: const Text('Term & Privacy', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.chevron_right, color: Colors.white),
                onTap: () => setState(() => _currentView = _CurrentView.termPrivacy),
              ),
              const Divider(color: Colors.white12, height: 1),
              ListTile(
                leading: const Icon(Icons.help_outline, color: Colors.white70),
                title: const Text('About GG', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.chevron_right, color: Colors.white),
                onTap: () => setState(() => _currentView = _CurrentView.aboutGG),
              ),
              const Divider(color: Colors.white12, height: 1),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white70),
                title: const Text('Log out', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.chevron_right, color: Colors.white),
                onTap: _showLogoutConfirmationDialog,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppInfoView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/whistle.png', height: 100),
        const SizedBox(height: 16),
        const Text('Good Game', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Version 1.0.0', style: TextStyle(color: Colors.white70, fontSize: 16)),
        const SizedBox(height: 32),
        const Divider(color: Colors.white24, thickness: 1),
        const SizedBox(height: 32),
        _buildInfoContainer(
          title: 'About the App',
          content: const Text(
            'Good Game is your ultimate companion for discovering and organizing local sporting events. Connect with other sports enthusiasts, stay updated on upcoming games, and never miss a moment of the action.',
            style: TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildTermPrivacyView() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Terms of Service', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('This is where your detailed Terms of Service will go. You can add your content here.', style: TextStyle(color: Colors.white70, fontSize: 14)),
        SizedBox(height: 24),
        Text('Privacy Policy', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('This is where your detailed Privacy Policy will go. You can add your content here.', style: TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    );
  }

  Widget _buildAboutGGView() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(image: AssetImage('assets/whistle.png'), height: 100),
        SizedBox(height: 16),
        Text('Good Game', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Version 1.0.0', style: TextStyle(color: Colors.white70, fontSize: 16)),
        SizedBox(height: 24),
        Text(
          'Good Game is a social platform for sports enthusiasts to discover, create, and join local sporting events. Our mission is to connect communities through the power of sports and friendly competition.',
          style: TextStyle(color: Colors.white70, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildInfoContainer({required String title, required Widget content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2E3137),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(color: Colors.white12, height: 20),
          content,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle = 'Settings';
    Widget currentBody;
    bool showBackButton = false;

    switch (_currentView) {
      case _CurrentView.main:
        appBarTitle = 'Settings';
        currentBody = _buildMainSettingsView();
        showBackButton = false;
        break;
      case _CurrentView.appInfo:
        appBarTitle = 'App Information';
        currentBody = _buildAppInfoView();
        showBackButton = true;
        break;
      case _CurrentView.termPrivacy:
        appBarTitle = 'Terms & Privacy';
        currentBody = _buildTermPrivacyView();
        showBackButton = true;
        break;
      case _CurrentView.aboutGG:
        appBarTitle = 'About GG';
        currentBody = _buildAboutGGView();
        showBackButton = true;
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF23262A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF23262A),
        elevation: 0,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => setState(() => _currentView = _CurrentView.main),
              )
            : null,
        title: Text(
          appBarTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: currentBody,
        ),
      ),
    );
  }
}
