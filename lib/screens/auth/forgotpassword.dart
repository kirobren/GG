import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class ForgotPasswordPage extends StatefulWidget {
const ForgotPasswordPage({super.key});

@override
State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
final emailController = TextEditingController();
final supabase = Supabase.instance.client;

Future<void> resetPassword() async {
final email = emailController.text.trim();
if (email.isEmpty) {
ScaffoldMessenger.of(
context,
).showSnackBar(const SnackBar(content: Text('Please enter your email')));
return;
}

try {
await supabase.auth.resetPasswordForEmail(email);
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('Password reset email sent')),
);
} catch (e) {
ScaffoldMessenger.of(
context,
).showSnackBar(SnackBar(content: Text('Failed: ${e.toString()}')));
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFF222222),
body: Center(
child: SingleChildScrollView(
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.center,
children: [
SizedBox(
height: 100,
width: 150,
child: Stack(
alignment: Alignment.center,
children: [
Image.asset('assets/whistle.png', height: 120, width: 120,),
],
),
),
const SizedBox(height: 2),
const Text(
'Forgot Password',
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),

const SizedBox(height: 4),
SizedBox(
width: 300,
height: 48,
child: TextField(
controller: emailController,
style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
hintText: 'Enter your email',
hintStyle: const TextStyle(color: Colors.white54),
filled: true,
fillColor: const Color (0xFF1E1E1E),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(4),
borderSide: const BorderSide(color: Color(0xFF49494B)),
),
enabledBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(4),
borderSide: const BorderSide(color: Color(0xFF49494B)),
),
),
),
),
const SizedBox(height: 24),
SizedBox(
width: 300,
height: 48,
child: ElevatedButton(
onPressed: resetPassword,
style: ElevatedButton.styleFrom(
backgroundColor: Color(0xFF26EEEB),
foregroundColor: Color(0xFF0E0E0E),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(30),
),
),
child: const Text('Reset Password',
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
),
),
const SizedBox(height: 2),
TextButton(
onPressed: () {
Navigator.pop(context);
},
child: const Text(
'Back to Login',
style: TextStyle(color: Color(0xFFFEFEFE)),
),
),
],
),
),
),
);
}
}
