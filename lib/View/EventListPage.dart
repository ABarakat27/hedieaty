import 'package:flutter/material.dart';

class EventListPage extends StatefulWidget {
  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  final List<Map<String, String>> events = [
    {'name': 'Birthday', 'category': 'Celebration', 'status': 'Upcoming'},
    {'name': 'Wedding', 'category': 'Ceremony', 'status': 'Past'},
  ];

  void _addEvent(String name, String category, String status) {
    setState(() {
      events.add({'name': name, 'category': category, 'status': status});
    });
  }

  void _showAddEventDialog() {
    String name = '';
    String category = '';
    String status = 'Upcoming';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Event Name'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Category'),
                onChanged: (value) {
                  category = value;
                },
              ),
              DropdownButtonFormField<String>(
                value: status,
                items: ['Upcoming', 'Current']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  status = value!;
                },
                decoration: InputDecoration(labelText: 'Status'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (name.isNotEmpty && category.isNotEmpty) {
                  _addEvent(name, category, status);
                  Navigator.of(context).pop();
                }
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
      appBar: AppBar(title: Text('Event List')),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return ListTile(
            title: Text(event['name']!),
            subtitle: Text('Category: ${event['category']}, Status: ${event['status']}'),
            onTap: () {
              Navigator.pushNamed(context, '/giftList');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
