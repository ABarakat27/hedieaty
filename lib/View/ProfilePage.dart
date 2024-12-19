import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {'title': 'Gift Pledged', 'message': 'Your friend John pledged a gift for your event.'},
    {'title': 'New Event Created', 'message': 'You created a new event: Birthday Party.'},
    {'title': 'Reminder', 'message': 'Your event Wedding is tomorrow.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Column(
        children: [
          // User Information Section
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/user_avatar.png'), // Replace with user's profile picture
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('John Doe', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('johndoe@example.com', style: TextStyle(fontSize: 14, color: Colors.grey)),
                    SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        // Add edit profile logic
                      },
                      child: Text('Edit Profile'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Notifications Section
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return ListTile(
                  leading: Icon(Icons.notifications, color: Colors.blue),
                  title: Text(notification['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(notification['message']!),
                  onTap: () {
                    // Handle notification tap (e.g., navigate to event/gift details)
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Map<String, dynamic>> _userEvents = [];
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _fetchUserEvents();
  }

  Future<void> _fetchUserEvents() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    try {
      // Fetch events where ownerUid matches the logged-in user's uid
      final snapshot = await FirebaseFirestore.instance
          .collection('events')
          .where('ownerUid', isEqualTo: currentUser.uid)
          .get();

      setState(() {
        _userEvents = snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      print('Error fetching user events: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Events & Gifts'),
      ),
      body: _userEvents.isEmpty
          ? Center(child: Text('No events found.'))
          : ListView.builder(
        itemCount: _userEvents.length,
        itemBuilder: (context, index) {
          final event = _userEvents[index];
          final gifts = event['gifts'] as List<dynamic>;

          return Card(
            margin: EdgeInsets.all(10),
            child: ExpansionTile(
              title: Text(event['name']),
              subtitle: Text('Gifts: ${gifts.length}'),
              children: gifts.map((gift) {
                return ListTile(
                  leading: Icon(Icons.card_giftcard),
                  title: Text(gift),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
*/