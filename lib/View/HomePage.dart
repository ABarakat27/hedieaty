import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> friends = [
    {'name': 'Youssef', 'profilePic': 'https://via.placeholder.com/150', 'events': 2},
    {'name': 'Talaat', 'profilePic': 'https://via.placeholder.com/150', 'events': 0},
    {'name': 'Anass', 'profilePic': 'https://via.placeholder.com/150', 'events': 1},
  ];

  void _addFriend() {
    TextEditingController searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Friend'),
          content: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: 'Enter Username or Phone Number',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final searchValue = searchController.text.trim();
                if (searchValue.isNotEmpty) {
                  final friendData = await _findFriend(searchValue);
                  if (friendData != null) {
                    setState(() {
                      friends.add(friendData);
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Friend added successfully!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Friend not found')),
                    );
                  }
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/eventList');
            },
            child: Text('Create Your Own Event/List'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                final friend = friends[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(friend['profilePic']),
                  ),
                  title: Text(friend['name']),
                  subtitle: Text(friend['events'] > 0
                      ? 'Upcoming Events: ${friend['events']}'
                      : 'No Upcoming Events'),
                  onTap: () {
                    Navigator.pushNamed(context, '/giftList');
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _addFriend,
            child: Text('Add Friend'),
          ),
        ],
      ),

    );
  }
}


  Future<Map<String, dynamic>?> _findFriend(String value) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: value)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      return {
        'name': doc['username'],
        'profilePic': doc['profilePictureUrl'] ?? 'https://via.placeholder.com/150',
        'events': 0,
      };
    }
    return null;
  }

/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> friends = [
    {'name': 'Youssef', 'profilePic': 'https://via.placeholder.com/150', 'events': 2},
    {'name': 'Talaat', 'profilePic': 'https://via.placeholder.com/150', 'events': 0},
    {'name': 'Anass', 'profilePic': 'https://via.placeholder.com/150', 'events': 1},
  ];

  void _addFriend() {
    TextEditingController searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Friend'),
          content: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: 'Enter Username or Phone Number',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final searchValue = searchController.text.trim();
                if (searchValue.isNotEmpty) {
                  final friendData = await _findFriend(searchValue);
                  if (friendData != null) {
                    setState(() {
                      friends.add(friendData);
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Friend added successfully!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Friend not found')),
                    );
                  }
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<Map<String, dynamic>?> _findFriend(String value) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: value)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      return {
        'name': doc['username'],
        'profilePic': doc['profilePictureUrl'] ?? 'https://via.placeholder.com/150',
        'events': 0,
      };
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                final friend = friends[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(friend['profilePic']),
                  ),
                  title: Text(friend['name']),
                  subtitle: const Text('No upcoming events'),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _addFriend,
            child: const Text('Add Friend'),
          ),
        ],
      ),
    );
  }
}
*/