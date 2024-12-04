import 'package:flutter/material.dart';

class HiPage extends StatelessWidget {
  const HiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/expenses'); // Navigate to Expense Overview
              },
              child: const Text('Go to Expenses'),
            ),
            // Add more buttons for other screens as needed
          ],
        ),
      ),
    );
  }
}