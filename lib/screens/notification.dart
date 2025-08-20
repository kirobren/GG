import 'package:flutter/material.dart';

class NotificationModel {
final String id;
final String title;
final String body;
final String timeAgo;
final String category;

NotificationModel({
required this.id,
required this.title,
required this.body,
required this.timeAgo,
required this.category,
});
}

class NotificationsScreen extends StatefulWidget {
const NotificationsScreen({super.key});

@override
State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
List<NotificationModel> _notifications = [
NotificationModel(
id: '1',
title: 'SPORTS ACADEMY',
body: 'Posted 2 events',
timeAgo: '5 days ago',
category: 'This week',
),
NotificationModel(
id: '2',
title: 'SPORTS ACADEMY',
body: 'Posted 2 events',
timeAgo: '5 days ago',
category: 'Past week',
),
NotificationModel(
id: '3',
title: 'SPORTS ACADEMY',
body: 'Posted 2 events',
timeAgo: '5 days ago',
category: 'Past week',
),
NotificationModel(
id: '4',
title: 'SPORTS ACADEMY',
body: 'Posted 2 events',
timeAgo: '5 days ago',
category: 'Past week',
),
NotificationModel(
id: '5',
title: 'SPORTS ACADEMY',
body: 'Posted 2 events',
timeAgo: '5 days ago',
category: 'Past week',
),
NotificationModel(
id: '6',
title: 'SPORTS ACADEMY',
body: 'Posted 2 events',
timeAgo: '5 days ago',
category: 'Past week',
),
NotificationModel(
id: '7',
title: 'SPORTS ACADEMY',
body: 'Posted 2 events',
timeAgo: '5 days ago',
category: 'Past week',
),
NotificationModel(
id: '8',
title: 'SPORTS ACADEMY',
body: 'Posted 2 events',
timeAgo: '5 days ago',
category: 'Past week',
),
NotificationModel(
id: '9',
title: 'SPORTS ACADEMY',
body: 'Posted 2 events',
timeAgo: '5 days ago',
category: 'Past week',
),
NotificationModel(
id: '10',
title: 'SPORTS ACADEMY',
body: 'Posted 2 events',
timeAgo: '5 days ago',
category: 'Past week',
),
];

@override
Widget build(BuildContext context) {
// Group notifications by category
final thisWeekNotifications = _notifications.where(
(notification) => notification.category == 'This week').toList();
final pastWeekNotifications = _notifications.where(
(notification) => notification.category == 'Past week').toList();

return Scaffold(
backgroundColor: const Color(0xFF121212), 
appBar: AppBar(
backgroundColor: const Color(0xFF121212),
leading: IconButton(
icon: const Icon(Icons.arrow_back, color: Colors.white),
onPressed: () {
Navigator.of(context).pop();
},
),
title: const Text(
'Notifications',
style: TextStyle(color: Colors.white),
),
),
body: SingleChildScrollView(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
if (thisWeekNotifications.isNotEmpty) ...[
const Padding(
padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
child: Text(
'This week',
style: TextStyle(
color: Colors.white,
fontSize: 16,
fontWeight: FontWeight.bold,
),
),
),
_buildNotificationList(thisWeekNotifications),
],


if (pastWeekNotifications.isNotEmpty) ...[
const Padding(
padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
child: Text(
'Past week',
style: TextStyle(
color: Colors.white,
fontSize: 16,
fontWeight: FontWeight.bold,
),
),
),
_buildNotificationList(pastWeekNotifications),
],
],
),
),
);
}

void _showDeleteConfirmationDialog(NotificationModel notification) {
showDialog(
context: context,
builder: (BuildContext context) {
return AlertDialog(
backgroundColor: const Color(0xFF1E1E1E),
title: const Text('Delete Notification', style: TextStyle(color: Colors.white)),
content: Text(
'Are you sure you want to delete this notification from "${notification.title}"?',
style: const TextStyle(color: Colors.white70),
),
actions: [
TextButton(
onPressed: () => Navigator.of(context).pop(), 
child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
),
TextButton(
onPressed: () {
setState(() {
_notifications.removeWhere((item) => item.id == notification.id);
});
Navigator.of(context).pop();
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text('Notification from "${notification.title}" deleted.'),
backgroundColor: Colors.red,
),
);
},
child: const Text('Delete', style: TextStyle(color: Colors.red)),
),
],
);
},
);
}

Widget _buildNotificationList(List<NotificationModel> notifications) {
return ListView.builder(
shrinkWrap: true,
physics: const NeverScrollableScrollPhysics(), 
itemCount: notifications.length,
itemBuilder: (context, index) {
final notification = notifications[index];
return Dismissible(
key: Key(notification.id), 
direction: DismissDirection.endToStart, 
background: Container(
color: Colors.red, 
alignment: Alignment.centerRight,
padding: const EdgeInsets.symmetric(horizontal: 20.0),
child: const Icon(Icons.delete, color: Colors.white),
),
onDismissed: (direction) {
setState(() {
_notifications.removeWhere(
(item) => item.id == notification.id);
});
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text('${notification.title} notification dismissed'),
action: SnackBarAction(
label: 'UNDO',
onPressed: () {
setState(() {
_notifications.insert(index, notification);
});
},
),
),
);
},
child: _buildNotificationItem(notification),
);
},
);
}

Widget _buildNotificationItem(NotificationModel notification) {
return Container(
padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
decoration: const BoxDecoration(
border: Border(bottom: BorderSide(color: Colors.white12, width: 0.5)),
),
child: Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
// Left-side icon/image
Padding(
padding: const EdgeInsets.only(right: 16.0),
child: CircleAvatar(
backgroundColor: Colors.white,
child: Image.asset(
'assets/logo.png', 
fit: BoxFit.contain,
),
),
),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
notification.title,
style: const TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 4),
Text(
notification.body,
style: const TextStyle(color: Colors.white70),
),
const SizedBox(height: 4),
Text(
notification.timeAgo,
style: const TextStyle(color: Colors.white54, fontSize: 12),
),
],
),
),
IconButton(
icon: const Icon(Icons.more_vert, color: Colors.white54),
onPressed: () {
_showDeleteConfirmationDialog(notification);
},
),
],
),
);
}
}
