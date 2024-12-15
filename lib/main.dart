import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty/View/LogIn.dart';
import 'package:hedieaty/View/SignUp.dart';
import 'package:hedieaty/View/HomePage.dart';
import 'package:hedieaty/View/EventListPage.dart';
import 'package:hedieaty/View/CreateGiftDetailsPage.dart';
import 'package:hedieaty/View/GiftListPage.dart';
import 'package:hedieaty/View/MyPledgedGiftsPage.dart';
import 'package:hedieaty/View/ProfilePage.dart';
import 'package:hedieaty/View/ShowGiftDetails.dart';
import 'package:hedieaty/widgets/main_navigation_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HiPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupScreen(),
        '/hi': (context) => const HiPage(),
        '/homePage': (context) => HomePage(),
        '/eventList': (context) => EventListPage(),
        '/giftList': (context) => GiftListPage(),
        '/createGiftDetails': (context) => CreateGiftDetailsPage(),
        '/showGiftDetails': (context) => ShowGiftDetailsPage(),
        '/profile': (context) => ProfilePage(),
        '/pledgedGifts': (context) => MyPledgedGiftsPage(),
        '/home': (context) => MainNavigationBar(), // New route for the navigation bar
      },
    );
  }
}

class HiPage extends StatelessWidget {
  const HiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: const Text('Go to App'),
            ),
          ],
        ),
      ),
    );
  }
}
