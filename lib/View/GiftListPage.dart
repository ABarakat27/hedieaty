import 'package:flutter/material.dart';

class GiftListPage extends StatelessWidget {
  final List<Map<String, String>> gifts = [
    {'name': 'Laptop', 'category': 'Electronics', 'status': 'Available'},
    {'name': 'Book', 'category': 'Books', 'status': 'Pledged'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gift List')),
      body: ListView.builder(
        itemCount: gifts.length,
        itemBuilder: (context, index) {
          final gift = gifts[index];
          return ListTile(
            title: Text(gift['name']!),
            subtitle: Text('Category: ${gift['category']}, Status: ${gift['status']}'),
            trailing: gift['status'] == 'Pledged'
                ? Icon(Icons.check_circle, color: Colors.green)
                : Icon(Icons.circle_outlined, color: Colors.grey),
            onTap: () {
              Navigator.pushNamed(context, '/showGiftDetails');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/createGiftDetails');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
