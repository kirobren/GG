  import 'package:supabase_flutter/supabase_flutter.dart';

  class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Map<String, dynamic>> signInWithEmailAndPassword({
  required String email,
  required String password,
  }) async {
  try {
  final AuthResponse response = await _supabase.auth.signInWithPassword(
  email: email,
  password: password,
  );

  final user = response.user;
  if (user == null) {
  throw 'User is null after sign-in.';
  }

  final String userId = user.id;

  final List<Map<String, dynamic>> userProfile = await _supabase
  .from('users')
  .select('role')
  .eq('id', userId)
  .limit(1);

  late String role;

  if (userProfile.isEmpty) {
  print('User profile not found. Creating a new one with a default role.');
  await _supabase.from('users').insert({
  'id': userId,
  'email': email,
  'full_name': 'Default Name',
  'role': 'user', 
  });
  role = 'user';
  } else {
  role = userProfile.first['role'] ?? 'user';
  }

  return {
  'user': user,
  'role': role,
  };

  } on AuthException catch (e) {
  print('Auth Error: ${e.message}');
  rethrow;  
  } catch (e) {
  print('Sign-in Error: $e');
  rethrow;
  }
  }

  Future<void> signOut() async {
  try {
  await _supabase.auth.signOut();
  } on AuthException catch (e) {
  print('Sign-out Error: ${e.message}');
  rethrow;
  }
  }
  }
