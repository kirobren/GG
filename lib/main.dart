import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

import 'screens/auth/loginpage.dart';
import 'screens/auth/signup_page.dart';
import 'screens/home/homepage.dart';
import 'screens/profile/profile_favorite.dart';
import 'screens/home/favorite.dart';
import 'screens/home/explore.dart';
import 'screens/landingpage.dart';
import 'package:gg/providers/favorites_provider.dart';
import 'package:gg/screens/profile/settings.dart';
import 'package:gg/screens/home/organizer_home.dart';
import 'package:gg/services/auth_service.dart';

import 'package:gg/services/admin_page.dart';
import 'package:gg/services/org_request.dart';
import 'package:gg/services/reports_page.dart';
import 'package:gg/services/users_page.dart';
import 'package:gg/services/events_page.dart';
import 'package:gg/screens/home/become_org.dart';
import 'package:gg/screens/home/organizer_page.dart';
import 'package:gg/screens/home/create_event.dart';
import 'package:gg/screens/home/search_org.dart';
import 'package:gg/screens/home/profile_org.dart';
import 'package:gg/screens/home/profile_about_org.dart';
import 'package:gg/screens/home/settings_org.dart';
import 'package:gg/screens/home/notif_org.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://lbdqvvgmgfhtgxtiuazh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxiZHF2dmdtZ2ZodGd4dGl1YXpoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIyOTg3MTksImV4cCI6MjA2Nzg3NDcxOX0.4PYDKhBKQIw6I4smvfMRbLF7xR5RN8O5ql47mi8__W8',
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/landing',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/profile_favorite': (context) => const ProfileFavoritePage(),
        '/favorite': (context) => const FavoritePage(),
        '/explore': (context) => const ExplorePage(),
        '/landing': (context) => const LandingPage(),
        '/settings': (context) => const SettingsPage(),
        '/organizer': (context) => const OrganizerHome(),
        '/admin': (context) => const AdminPage(),
        '/org_request': (context) => OrgRequest(),
        '/reports': (context) => ReportsPage(),
        '/users': (context) => UsersPage(),
        '/events': (context) => EventPage(),
        '/become_org': (context) => const BecomeOrgPage(),
        '/organizer_page': (context) => const OrganizerPage(),
        '/create_event': (context) => const CreateEventPage(),
        '/search_org': (context) => const SearchOrgPage(),
        '/profile_org': (context) => const ProfileOrgPage(),
        '/profile_about_org': (context) => const ProfileAboutOrgPage(),
        '/settings_org': (context) => const SettingsOrgPage(),
        '/notif_org': (context) => const NotifOrgScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
