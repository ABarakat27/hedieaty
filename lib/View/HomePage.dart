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
    TextEditingController usernameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Friend'),
          content: TextField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'Enter Username',
              hintText: 'e.g., JohnDoe123',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (usernameController.text.isNotEmpty) {
                  setState(() {
                    friends.add({
                      'name': usernameController.text,
                      'profilePic': 'https://via.placeholder.com/150', // Default image
                      'events': 0, // No upcoming events initially
                    });
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Add'),
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
