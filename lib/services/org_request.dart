import 'package:flutter/material.dart';
import 'package:gg/screens/landingpage.dart';
import 'admin_page.dart';
import 'events_page.dart';
import 'users_page.dart';
import 'reports_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

class OrgRequest extends StatefulWidget {
  const OrgRequest({super.key});

  @override
  State<OrgRequest> createState() => _OrgRequestState();
}

class _OrgRequestState extends State<OrgRequest> {
  final supabase = Supabase.instance.client;
  late Future<List<Map<String, dynamic>>> _requestsFuture;

  @override
  void initState() {
    super.initState();
    _requestsFuture = _fetchOrganizerRequests();
  }

  Future<List<Map<String, dynamic>>> _fetchOrganizerRequests() async {
    try {
      final response = await supabase
          .from('organizer_requests')
          .select('id, user_id, reason, full_name, email, birthday, address, profile_picture_url, proof_of_event_urls, event_link, created_at, status')
          .order('created_at', ascending: false);
      return response;
    } on PostgrestException catch (e) {
      debugPrint('Postgrest error fetching requests: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Error fetching requests: $e');
      rethrow;
    }
  }

  Future<void> _approveRequest(String userId, int requestId) async {
    try {
      await supabase.from('users').update({'role': 'organizer'}).eq('id', userId);
      await supabase.from('organizer_requests').delete().eq('id', requestId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Organizer approved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          _requestsFuture = _fetchOrganizerRequests();
        });
      }
    } on PostgrestException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to approve request: ${e.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to approve request: $e')),
        );
      }
    }
  }

  Future<void> _declineRequest(int requestId) async {
    try {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF2D2D2D),
            title: const Text('Decline Request?', style: TextStyle(color: Colors.white)),
            content: const Text('Are you sure you want to decline this request? This action cannot be undone.', style: TextStyle(color: Colors.white70)),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: const Text('Decline', style: TextStyle(color: Colors.redAccent)),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        },
      );
      if (confirmed == true) {
        await supabase.from('organizer_requests').delete().eq('id', requestId);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Organizer request declined.'),
              backgroundColor: Colors.red,
            ),
          );
          setState(() {
            _requestsFuture = _fetchOrganizerRequests();
          });
        }
      }
    } on PostgrestException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to decline request: ${e.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to decline request: $e')),
        );
      }
    }
  }

  int _selectedIndex = 1;

  final List<IconData> _navIcons = [
    Icons.home_filled,
    Icons.description_outlined,
    Icons.warning_amber_outlined,
    Icons.people_outline,
    Icons.calendar_today_outlined,
  ];

  void _navigateToPage(int index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminPage()),
        );
        break;
      case 1:
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ReportsPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UsersPage()),
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const EventPage()),
        );
        break;
    }
  }

  void _onDrawerItemTapped(String routeName) {
    Navigator.pop(context);
    switch (routeName) {
      case 'admin':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminPage()),
        );
        break;
      case 'org_request':
        break;
      case 'reports':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ReportsPage()),
        );
        break;
      case 'events':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const EventPage()),
        );
        break;
      case 'users':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UsersPage()),
        );
        break;
      case 'logout':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
        break;
    }
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  Widget _buildCustomBottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 43.0, top: 4.0, right: 43.0, bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_navIcons.length, (index) {
            return _buildButton(
              icon: _navIcons.elementAt(index),
              index: index,
              isSelected: _selectedIndex == index,
            );
          }),
        ),
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required int index,
    bool isSelected = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () => _navigateToPage(index),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: isSelected
              ? const BoxDecoration(color: Colors.white, shape: BoxShape.circle)
              : null,
          child: Icon(
            icon,
            color: isSelected ? Colors.black : Colors.white,
            size: 22.0,
          ),
        ),
      ),
    );
  }

  void _showRequestDetails(Map<String, dynamic> request) {
    final String fullName = request['full_name'] ?? 'N/A';
    final String email = request['email'] ?? 'N/A';
    final String birthday = request['birthday'] ?? 'N/A';
    final String address = request['address'] ?? 'N/A';
    final String eventLink = request['event_link'] ?? 'N/A';
    final String profilePictureUrl = request['profile_picture_url'] ?? '';
    
    // The fix for the proof of events urls is here
    final dynamic proofUrlsRaw = request['proof_of_event_urls'];
    final List<String> proofOfEventUrls = (proofUrlsRaw is List)
        ? proofUrlsRaw.map((e) => e.toString()).toList()
        : [];
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2D2D2D),
          title: const Text('Organizer Request Details', style: TextStyle(color: Colors.white)),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: profilePictureUrl.isNotEmpty
                          ? NetworkImage(profilePictureUrl)
                          : null,
                      child: profilePictureUrl.isEmpty ? const Icon(Icons.person, size: 40, color: Colors.white) : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailText('Full Name:', fullName),
                  _buildDetailText('Email:', email),
                  _buildDetailText('Birthday:', birthday),
                  _buildDetailText('Address:', address),
                  _buildDetailText('Event Link:', eventLink, isLink: true),
                  const SizedBox(height: 16),
                  const Text('Proof of Events:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  if (proofOfEventUrls.isNotEmpty)
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: proofOfEventUrls.map((url) {
                        return Image.network(
                          url,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const SizedBox(width: 80, height: 80, child: Center(child: CircularProgressIndicator(color: Colors.white)));
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey,
                              child: const Center(
                                child: Text('Image\nFailed', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 10)),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    )
                  else
                    const Text('No proof images provided.', style: TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailText(String label, String value, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          if (isLink && value != 'N/A')
            GestureDetector(
              onTap: () async {
                final Uri url = Uri.parse(value);
                try {
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to open link: $e')),
                  );
                }
              },
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.blueAccent,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          else
            Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRequestCard({
    required Map<String, dynamic> request,
    required VoidCallback onApproved,
    required VoidCallback onDeclined,
  }) {
    final String name = request['full_name'] ?? 'No name provided';
    final String email = request['email'] ?? 'No email provided';
    final String avatarUrl = request['profile_picture_url'] ?? '';
    final String createdAt = request['created_at'] != null
        ? timeago.format(DateTime.parse(request['created_at']))
        : 'N/A';

    return GestureDetector(
      onTap: () => _showRequestDetails(request),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,
              radius: 24,
              child: avatarUrl.isEmpty ? const Icon(Icons.person, color: Colors.white) : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.email, color: Colors.white70, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        email,
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Requested $createdAt',
                    style: const TextStyle(color: Colors.white54, fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildActionButton(
                  text: 'Approve',
                  backgroundColor: Colors.white.withOpacity(0.1),
                  textColor: Colors.white,
                  isOutlined: false,
                  onPressed: onApproved,
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  text: 'Decline',
                  backgroundColor: Colors.transparent,
                  textColor: Colors.white,
                  isOutlined: true,
                  onPressed: onDeclined,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required bool isOutlined,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        side: isOutlined ? const BorderSide(color: Colors.white) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        minimumSize: const Size(0, 28),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'Organizer Request Page',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF1A1A1A),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF1A1A1A)),
              child: Row(
                children: [
                  Image.asset('assets/whistle.png', height: 100),
                  const SizedBox(width: 8),
                  Text(
                    'Good Game',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.dashboard, 'Dashboard', () => _onDrawerItemTapped('admin')),
            _buildDrawerItem(Icons.description, 'Organizer request', () => _onDrawerItemTapped('org_request')),
            _buildDrawerItem(Icons.warning, 'Reports', () => _onDrawerItemTapped('reports')),
            _buildDrawerItem(Icons.event, 'Events', () => _onDrawerItemTapped('events')),
            _buildDrawerItem(Icons.people, 'Users', () => _onDrawerItemTapped('users')),
            const Divider(color: Colors.white),
            _buildDrawerItem(Icons.logout, 'Logout', () => _onDrawerItemTapped('logout')),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Organizer request',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _requestsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Failed to load requests. Please check your network and try again. Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.redAccent, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No new organizer requests.', style: TextStyle(color: Colors.white54)));
                } else {
                  final requests = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      final request = requests[index];
                      return _buildRequestCard(
                        request: request,
                        onApproved: () => _approveRequest(request['user_id'], request['id']),
                        onDeclined: () => _declineRequest(request['id']),
                      );
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
      bottomNavigationBar: _buildCustomBottomNavigationBar(),
    );
  }
}