import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  String? userName;
  String? userEmail;
  String? userPhotoURL;
  bool isLoading = true; // To handle loading state

  @override
  void initState() {
    super.initState();
    _getUserData(); // Fetch user data only once when the page is first loaded
  }

  // Fetch user data from Firestore
  Future<void> _getUserData() async {
    user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      userEmail = user!.email;
      userName = user!.displayName;

      // Fetch additional user data from Firestore (optional)
      try {
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
        if (userDoc.exists) {
          final userData = userDoc.data() as Map<String, dynamic>;
          userPhotoURL = userData['profilePictureUrl']; // Retrieve profile photo URL from Firestore

          // Access additional user data from userData if needed
          setState(() {
            userName = userData['username'] ?? userName;
            isLoading = false; // Set loading to false after data is fetched
          });
        } else {
          // Handle case where Firestore document doesn't exist
          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          isLoading = false; // In case of an error, stop the loading state
        });
      }
    } else {
      setState(() {
        isLoading = false; // If user is not authenticated, stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // Listen to auth state changes
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || isLoading) {
          return Scaffold(
            appBar: AppBar(title: Text('Profile')),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text('Profile')),
            body: Center(child: Text('Something went wrong!')),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: Text('Profile')),
            body: Center(child: Text('Please log in to view your profile.')),
          );
        } else {
          // User is authenticated
          user = snapshot.data;

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
                        // Use the profile photo URL from Firestore or fallback to a default image
                        backgroundImage: userPhotoURL != null
                            ? NetworkImage(userPhotoURL!)
                            : AssetImage('assets/user_avatar.png') as ImageProvider,
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userName ?? 'Unknown User', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(userEmail ?? 'Unknown Email', style: TextStyle(fontSize: 14, color: Colors.grey)),
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
                // Notifications Section (unchanged)
              ],
            ),
          );
        }
      },
    );
  }
}
