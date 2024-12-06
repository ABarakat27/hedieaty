import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});


  @override
  State<SignupScreen> createState() => _SignupScreenState();
}


class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  String? _profilePictureUrl;


  Future<void> _signUp() async {
    try {
// Check for username uniqueness
      final usernameExists = await _checkUsername(_usernameController.text);
      if (usernameExists) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(
            content: const Text('Username already exists'),
          ),
        );
        return;
      }


// Create user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final uid = userCredential.user?.uid;


// Upload profile picture (optional)
      if (_profilePictureUrl != null) {
// Implement logic to upload image to Firebase Storage
// Replace with your upload function
        await uploadProfilePicture(_profilePictureUrl!);
      }


// Save user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': _emailController.text,
        'username': _usernameController.text,
        'profilePictureUrl': _profilePictureUrl,
      });


// Handle successful signup and sign-in
// For example, navigate to the home screen
      Navigator.pushReplacementNamed(context as BuildContext, '/login');
    } on FirebaseAuthException catch (e) {
// Handle errors, such as weak password, invalid email, etc.
      print(e.message);
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );
    }
  }


  Future<bool> _checkUsername(String username) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    return snapshot.docs.isNotEmpty; snapshot.docs.isNotEmpty;
  }


// Replace this with your actual profile picture upload logic
// This function should upload the image to Firebase ;Storage
// and return the download URL
  Future<void> uploadProfilePicture(String filePath) async {
    try {
      final fileName = basename(filePath);
      final storageRef = FirebaseStorage.instance.ref().child('profile_pictures/$fileName');

      final file = File(filePath);
      final uploadTask = await storageRef.putFile(file);

      _profilePictureUrl = await uploadTask.ref.getDownloadURL();
      print('Profile picture uploaded successfully: $_profilePictureUrl');
    } catch (e) {
      print('Error uploading profile picture: $e');
      // Handle errors appropriately, like showing a user-friendly message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            Row(
              children: [
                Text('Profile Picture (Optional):'),
                TextButton(
                  onPressed: () async {
                    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        _profilePictureUrl = image.path;
                      });
                    }
                  },
                  child: const Text('Choose Image'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _signUp,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}