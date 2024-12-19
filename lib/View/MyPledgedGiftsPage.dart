import 'package:flutter/material.dart';

class MyPledgedGiftsPage extends StatelessWidget {
  final List<Map<String, String>> pledgedGifts = [
    {'name': 'Laptop', 'friend': 'Noshy', 'dueDate': '2024-12-31'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Pledged Gifts')),
      body: ListView.builder(
        itemCount: pledgedGifts.length,
        itemBuilder: (context, index) {
          final gift = pledgedGifts[index];
          return ListTile(
            title: Text(gift['name']!),
            subtitle: Text('Friend: ${gift['friend']}, Due Date: ${gift['dueDate']}'),
          );
        },
      ),
    );
  }
}
