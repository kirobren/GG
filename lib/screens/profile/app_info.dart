    import 'package:flutter/material.dart';

    class AppInfoPage extends StatelessWidget {
    const AppInfoPage({super.key});

    @override
    Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: const Color(0xFF23262A),
    appBar: AppBar(
    title: const Text(
    'App Info',
    style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    ),
    ),
    backgroundColor: const Color(0xFF2E3137), 
    iconTheme: const IconThemeData(color: Colors.white),
    ),
    body: SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Image.asset(
    'assets/whistle.png', 
    height: 100,
    ),
    const SizedBox(height: 16),

    const Text(
    'Good Game',
    style: TextStyle(
    color: Colors.white,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    ),
    ),
    const SizedBox(height: 8),

    const Text(
    'Version 1.0.0', 
    style: TextStyle(
    color: Colors.white70,
    fontSize: 16,
    ),
    ),
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
    const SizedBox(height: 24),

    _buildInfoContainer(
    title: 'Legal & Contact',
    content: Column(
    children: [
    _buildListTile(
    icon: Icons.policy_outlined,
    text: 'Privacy Policy',
    onTap: () {
    },
    ),
    _buildListTile(
    icon: Icons.description_outlined,
    text: 'Terms of Service',
    onTap: () {
    },
    ),
    _buildListTile(
    icon: Icons.email_outlined,
    text: 'Contact Us',
    onTap: () {
    },
    ),
    ],
    ),
    ),
    ],
    ),
    ),
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
    Text(
    title,
    style: const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    ),
    ),
    const Divider(color: Colors.white12, height: 20),
    content,
    ],
    ),
    );
    }

    Widget _buildListTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    }) {
    return InkWell(
    onTap: onTap,
    child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
    children: [
    Icon(icon, color: Colors.white70, size: 20),
    const SizedBox(width: 12),
    Text(
    text,
    style: const TextStyle(
    color: Colors.white,
    fontSize: 16,
    ),
    ),
    const Spacer(),
    const Icon(
    Icons.chevron_right,
    color: Colors.white70,
    ),
    ],
    ),
    ),
    );
    }
    }