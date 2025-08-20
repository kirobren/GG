import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'loginpage.dart';

class SignupPage extends StatefulWidget {
const SignupPage({super.key});
@override
State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
final fullNameController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();
final confirmPasswordController = TextEditingController();

final supabase = Supabase.instance.client;
bool _isLoading = false;

Future<void> register() async {
if (_isLoading) return;

setState(() {
_isLoading = true;
});

final fullName = fullNameController.text.trim();
final email = emailController.text.trim();
final password = passwordController.text.trim();
final confirmPassword = confirmPasswordController.text.trim();

if (fullName.isEmpty ||
email.isEmpty ||
password.isEmpty ||
confirmPassword.isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('Please fill in all fields')),
);
setState(() { _isLoading = false; });
return;
}

if (password != confirmPassword) {
ScaffoldMessenger.of(
context,
).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
setState(() { _isLoading = false; });
return;
}

try {
final response = await supabase.auth.signUp(
email: email,
password: password,
);

final userId = response.user?.id;
if (userId != null) {
await supabase.from('users').insert({
'id': userId,
'full_name': fullName,
'email': email,
'role': 'user',
});
}

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text('Registration successful! Please log in.'),
),
);

Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (_) => const LoginPage()),
);
} catch (e) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('Registration failed: ${e.toString()}')),
);
print(e.toString());
} finally {
setState(() {
_isLoading = false;
});
}
}

Widget _buildInputField({
required String label,
required TextEditingController controller,
bool obscure = false,
}) {
return Container(
width: 300,
height: 48,
padding: const EdgeInsets.symmetric(horizontal: 12),
decoration: BoxDecoration(
color: const Color(0xFF1E1E1E),
borderRadius: BorderRadius.circular(4),
border: Border.all(color: Color(0xFF49494B)),
),
child: Center(
child: TextField(
controller: controller,
obscureText: obscure,
style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
hintText: label,
hintStyle: const TextStyle(color: Colors.white54),
border: InputBorder.none,
),
),
),
);
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
Image.asset('assets/whistle.png', height: 120, width: 120),
],
),
),

const SizedBox(height: 2),
const Text(
'REGISTER TO GG',
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),
const SizedBox(height: 4),
_buildInputField(
label: 'Full Name',
controller: fullNameController,
),
const SizedBox(height: 16),
_buildInputField(label: 'Email', controller: emailController),
const SizedBox(height: 16),
_buildInputField(
label: 'Password',
controller: passwordController,
obscure: true,
),
const SizedBox(height: 16),
_buildInputField(
label: 'Confirm Password',
controller: confirmPasswordController,
obscure: true,
),
const SizedBox(height: 32),
SizedBox(
width: 300,
height: 48,
child: ElevatedButton(
onPressed: _isLoading ? null : register,
style: ElevatedButton.styleFrom(
backgroundColor:  Color(0xFF26EEEB),
foregroundColor: Color(0xFF0E0E0E),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(30),
),
),
child: _isLoading
? const CircularProgressIndicator(color: Color(0xFFFEFEFE))
: const Text('Register',
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
),
),
const SizedBox(height: 16),
GestureDetector(
onTap: () {
Navigator.push(
context,
MaterialPageRoute(builder: (_) => const LoginPage()),
);
},
child: const Text.rich(
TextSpan(
text: 'Already have an account? ',
style: TextStyle(color: Color(0xFFFEFEFE)),
children: [
TextSpan(
text: 'Login',
style: TextStyle(
color: Color(0xFF26EEEB),
fontWeight: FontWeight.bold,
),
),
],
),
),
),
],
),
),
),
);
}
}
