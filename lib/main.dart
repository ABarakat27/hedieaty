import 'package:hedieaty/View/LogIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty/View/SignUp.dart';
import 'package:hedieaty/View/HiPage.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized() ;
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
    primarySwatch: Colors.blue,
    ),
    initialRoute: '/',
    routes: {
    '/': (context) => const HomePage(),
      '/login': (context) => const LoginPage(),
      '/signup': (context) => const SignupScreen(),
      '/hi': (context) => const HiPage(),
    },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context)
  {
  return Scaffold(
  appBar: AppBar(
  title: const Text('Welcome'),
  ),
  body: Center(
  child:
  Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  ElevatedButton(
  onPressed: () {
  Navigator.pushNamed(context, '/login');
  },
  child:
  const Text('Sign In'),
  ),
  ElevatedButton(
  onPressed: () {
  Navigator.pushNamed(context, '/signup');
  },
  child: const Text('Sign Up'),
  ),
  ],
  ),
  ),
  );
  }
}

