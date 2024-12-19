import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> friends = [];

  @override
  void initState() {
    super.initState();
    _fetchFriends(); // Fetch friends from Firestore on initialization
  }

  // Fetch the friends of the current user
  Future<void> _fetchFriends() async {
    try {
      // Fetch the current user's ID from Firebase Authentication
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      // Retrieve the current user's friends array
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUserId).get();

      if (userDoc.exists && userDoc.data() != null) {
        final friendInfoList = List<Map<String, dynamic>>.from(userDoc.data()!['friends'] ?? []);

        setState(() {
          friends = friendInfoList;
        });
      } else {
        setState(() {
          friends = []; // Current user document does not exist or has no friends
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load friends: $e')),
      );
    }
  }

  // Add the friend relationship to Firestore for both users
  Future<void> _addFriendRelationship(String currentUserId, String friendUserId) async {
    try {
      final usersCollection = FirebaseFirestore.instance.collection('users');

      // Fetch the friend data (username and profile picture)
      final friendDoc = await usersCollection.doc(friendUserId).get();
      if (!friendDoc.exists) {
        throw 'Friend not found';
      }

      final friendData = friendDoc.data();
      final friendInfo = {
        'id': friendUserId,
        'username': friendData!['username'],
        'profilePictureUrl': friendData['profilePictureUrl'] ?? 'https://via.placeholder.com/150',
      };

      // Add the friend's info to the current user's friends array
      await usersCollection.doc(currentUserId).update({
        'friends': FieldValue.arrayUnion([friendInfo]),
      });

      // Add the current user's info to the friend's friends array
      final currentUserDoc = await usersCollection.doc(currentUserId).get();
      final currentUserData = currentUserDoc.data();
      final currentUserInfo = {
        'id': currentUserId,
        'username': currentUserData!['username'],
        'profilePictureUrl': currentUserData['profilePictureUrl'] ?? 'https://via.placeholder.com/150',
      };

      await usersCollection.doc(friendUserId).update({
        'friends': FieldValue.arrayUnion([currentUserInfo]),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Friend relationship added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating friend relationship: $e')),
      );
    }
  }

  // Find a friend based on username or phone number
  Future<Map<String, dynamic>?> _findFriend(String value) async {
    try {
      final query = FirebaseFirestore.instance.collection('users');

      final usernameSnapshot = await query
          .where('username', isEqualTo: value)
          .get();

      final phoneNumberSnapshot = await query
          .where('phone', isEqualTo: value)
          .get();

      if (usernameSnapshot.docs.isNotEmpty) {
        final doc = usernameSnapshot.docs.first;
        return {
          'id': doc.id, // Add this to include the friend's user ID
          'username': doc['username'],
          'profilePictureUrl': doc['profilePictureUrl'] ?? 'https://via.placeholder.com/150',
        };
      } else if (phoneNumberSnapshot.docs.isNotEmpty) {
        final doc = phoneNumberSnapshot.docs.first;
        return {
          'id': doc.id, // Add this to include the friend's user ID
          'username': doc['username'],
          'profilePictureUrl': doc['profilePictureUrl'] ?? 'https://via.placeholder.com/150',
        };
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error finding friend: $e')),
      );
    }
    return null;
  }

  // Add friend data to Firestore (if required)
  Future<void> _addFriendToFirestore(Map<String, dynamic> friendData) async {
    try {
      await FirebaseFirestore.instance.collection('friends').add(friendData);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add friend: $e')),
      );
    }
  }

  // Add friend UI logic
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
                    try {
                      final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
                      if (currentUserId == null) {
                        print("Current user ID is null!");
                        return;
                      }

                      final friendUserId = friendData['id'];

                      // Call _addFriendRelationship to update mutual friends in Firestore
                      await _addFriendRelationship(currentUserId, friendUserId);

                      // Add friend data to local list and Firestore
                      setState(() {
                        friends.add(friendData);
                      });

                      await _addFriendToFirestore(friendData);

                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Friend added successfully!')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to add friend: $e')),
                      );
                    }
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
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/eventList');
            },
            child: const Text('Create Your Own Event/List'),
          ),
          Expanded(
            child: friends.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                final friend = friends[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(friend['profilePictureUrl']),
                  ),
                  title: Text(friend['username']),
                  onTap: () {
                    Navigator.pushNamed(context, '/giftList');
                  },
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
