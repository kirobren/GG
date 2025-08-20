import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
const LandingPage({super.key});

@override
State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
with TickerProviderStateMixin {
late AnimationController _buttonLoadingController;
late Animation<double> _buttonScaleAnimation;
bool _isLoading = false;

@override
void initState() {
super.initState();

_buttonLoadingController = AnimationController(
vsync: this,
duration: const Duration(milliseconds: 500),
reverseDuration: const Duration(milliseconds: 200),
);

_buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
CurvedAnimation(
parent: _buttonLoadingController,
curve: Curves.easeInOut,
),
);
}

@override
void dispose() {
_buttonLoadingController.dispose();
super.dispose();
}

void _onReadySetGoPressed() async {
if (_isLoading) return;
setState(() {
_isLoading = true;
});

_buttonLoadingController.forward();
_buttonLoadingController.repeat(period: const Duration(seconds: 1));
await Future.delayed(const Duration(seconds: 3));

if (mounted) {
Navigator.pushReplacementNamed(context, '/login');
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFF222222),
body: Center(
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.center,
children: [
SizedBox(
width: 150,
height: 100,
child: Stack(
alignment: Alignment.center,
children: [
Image.asset('assets/whistle.png', height: 120, width: 120),
],
),
),
const SizedBox(height: 2),
const Text(
'Good Game Iloilo',
style: TextStyle(
color: Color(0xFEFEFEFE),
fontSize: 22,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 2),
const Text(
'Your very own sport events \necosystem',
textAlign: TextAlign.center,
style: TextStyle(
color: Color(0xFF8c8c8c),
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 32),
ScaleTransition(
scale: _buttonScaleAnimation,
child: SizedBox(
width: 300,
height: 48,
child: ElevatedButton(
onPressed: _isLoading ? null : _onReadySetGoPressed,
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFF26EEEB),
foregroundColor: const Color(0xFF0E0E0E),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(30),
),
),
child: _isLoading
? const CircularProgressIndicator(color: Color(0xFFFEFEFE))
: const Text(
'Ready, Set, Go...',
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
),
),
),
],
),
),
);
}
}