import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'forgotpassword.dart';
import 'package:gg/screens/home/homepage.dart';
import 'package:gg/services/auth_service.dart';
import 'package:gg/services/admin_page.dart';

class LoginPage extends StatefulWidget {
const LoginPage({super.key});

@override
State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final emailController = TextEditingController();
final passwordController = TextEditingController();
bool obscurePassword = true;
bool _isLoading = false;
final AuthService _authService = AuthService();

Future<void> signIn() async {
if (_isLoading) return;

setState(() {
_isLoading = true;
});

try {
final result = await _authService.signInWithEmailAndPassword(
email: emailController.text.trim(),
password: passwordController.text.trim(),
);

final String role = result['role'];

if (role == 'super_admin') {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (_) => const AdminPage()),
);
} else {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (_) => const HomePage()),
);
}
} catch (e) {
print('Login Error: $e');
ScaffoldMessenger.of(
context,
).showSnackBar(SnackBar(content: Text('Login failed: ${e.toString()}')));
} finally {
if (mounted) {
setState(() {
_isLoading = false;
});
}
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
Image.asset('assets/whistle.png', height: 120, width: 120),
],
),
),
const SizedBox(height: 2),
const Text(
'LOGIN TO GG',
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),
const SizedBox(height: 4),
_buildInputField(
controller: emailController,
hint: 'Email',
padding: const EdgeInsets.symmetric(horizontal: 24),
),
const SizedBox(height: 16),
_buildInputField(
controller: passwordController,
hint: 'Password',
obscure: obscurePassword,
padding: const EdgeInsets.symmetric(horizontal: 24),
suffixIcon: IconButton(
icon: Icon(
obscurePassword ? Icons.visibility_off : Icons.visibility,
color: Colors.white54,
),
onPressed: () {
setState(() {
obscurePassword = !obscurePassword;
});
},
),
),
const SizedBox(height: 1),
Container(
width: 300,
alignment: Alignment.centerRight,
child: TextButton(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => const ForgotPasswordPage(),
),
);
},
child: const Text(
'Forgot Password?',
style: TextStyle(color: Color(0xFFFEFEFE), fontSize: 14),
),
),
),
const SizedBox(height: 1),
SizedBox(
width: 300,
height: 48,
child: ElevatedButton(
onPressed: _isLoading ? null : signIn,
style: ElevatedButton.styleFrom(
backgroundColor: Color(0xFF26EEEB),
foregroundColor: Color(0xFF0E0E0E),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(30),
),
),
child: _isLoading
? const CircularProgressIndicator(color: Color(0XFFFEFEFE))
: const Text('Login',
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
),
),
const SizedBox(height: 16),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Text(
"Don't have an account? ",
style: TextStyle(color: Color(0xFFFEFEFE)),
),
GestureDetector(
onTap: () {
Navigator.push(
context,
MaterialPageRoute(builder: (_) => const SignupPage()),
);
},
child: const Text(
"Register",
style: TextStyle(
color: Color(0xFF26EEEB),
fontWeight: FontWeight.bold,
),
),
),
],
),
],
),
),
),
);
}

Widget _buildInputField({
required TextEditingController controller,
required String hint,
EdgeInsets? padding,
bool obscure = false,
Widget? suffixIcon,
}) {
return Padding(
padding: padding ?? EdgeInsets.zero,
child: Container(
width: 300,
height: 48,
padding: const EdgeInsets.symmetric(horizontal: 12),
decoration: BoxDecoration(
color: const Color(0xFF1E1E1E),
borderRadius: BorderRadius.circular(4),
border: Border.all(color: Color(0xFF49494B),
),
),
child: Center(
child: TextField(
controller: controller,
obscureText: obscure,
style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
hintText: hint,
hintStyle: const TextStyle(color: Colors.white54),
border: InputBorder.none,
suffixIcon: suffixIcon,
),
),
),
),
);
}
}