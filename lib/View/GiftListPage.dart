/*import 'package:flutter/material.dart';

class GiftListPage extends StatelessWidget {
  final List<Map<String, dynamic>> events = [
    {
      'name': 'Birthday Party',
      'gifts': ['Watch', 'Book', 'Smartphone'],
    },
    {
      'name': 'Wedding',
      'gifts': ['Photo Frame', 'Candle Holder'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events & Gifts')),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return ExpansionTile(
            title: Text(
              event['name'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            children: event['gifts'].map<Widget>((gift) {
              return ListTile(
                title: Text(gift),
                onTap: () {
                  // Navigate to Gift Details
                  Navigator.pushNamed(context, '/showGiftDetails');
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
*/
///////////////////////////////////////////////////////////////
/*
import 'package:flutter/material.dart';

class GiftListPage extends StatefulWidget {
  @override
  _GiftListPageState createState() => _GiftListPageState();
}

class _GiftListPageState extends State<GiftListPage> {
  final List<Map<String, dynamic>> events = [
    {
      'name': 'Birthday Party',
      'gifts': [
        {'name': 'Watch', 'pledged': false},
        {'name': 'Book', 'pledged': false},
        {'name': 'Smartphone', 'pledged': false},
      ],
    },
    {
      'name': 'Wedding',
      'gifts': [
        {'name': 'Photo Frame', 'pledged': false},
        {'name': 'Candle Holder', 'pledged': false},
      ],
    },
  ];

  void _pledgeGift(int eventIndex, int giftIndex) {
    setState(() {
      events[eventIndex]['gifts'][giftIndex]['pledged'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gifts'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, eventIndex) {
          final event = events[eventIndex];
          return Card(
            child: ExpansionTile(
              title: Text(event['name']),
              children: [
                ...event['gifts'].asMap().entries.map((entry) {
                  final giftIndex = entry.key;
                  final gift = entry.value;
                  return ListTile(
                    title: Text(gift['name']),
                    trailing: gift['pledged']
                        ? Icon(Icons.check, color: Colors.green)
                        : ElevatedButton(
                      onPressed: () => _pledgeGift(eventIndex, giftIndex),
                      child: Text('Pledge'),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
*/

///////////////////////////////////////////

import 'package:flutter/material.dart';

class GiftListPage extends StatefulWidget {
  @override
  _GiftListPageState createState() => _GiftListPageState();
}

class _GiftListPageState extends State<GiftListPage> {
  final List<Map<String, dynamic>> events = [
    {
      'name': 'Birthday Party',
      'date': DateTime(2024, 12, 25),
      'gifts': ['Watch', 'Book', 'Smartphone'],
    },
    {
      'name': 'Wedding',
      'date': DateTime(2023, 10, 10),
      'gifts': ['Photo Frame', 'Candle Holder'],
    },
  ];

  void _sortGifts(String criteria) {
    setState(() {
      if (criteria == 'date') {
        events.sort((a, b) => a['date'].compareTo(b['date']));
      } else if (criteria == 'alphabetical') {
        events.sort((a, b) => a['name'].compareTo(b['name']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gifts List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _sortGifts,
            itemBuilder: (context) => [
              PopupMenuItem(value: 'date', child: Text('Sort by Date')),
              PopupMenuItem(value: 'alphabetical', child: Text('Sort by Name')),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, eventIndex) {
          final event = events[eventIndex];
          return ExpansionTile(
            title: Text(event['name']),
            subtitle: Text('Date: ${event['date'].toLocal()}'.split(' ')[0]),
            children: event['gifts']
                .map<Widget>(
                  (gift) => ListTile(
                title: Text(gift),
                onTap: () {
                  Navigator.pushNamed(context, '/showGiftDetails', arguments: gift);
                },
              ),
            )
                .toList(),
          );
        },
      ),
    );
  }
}

////////////////////////////////////////////
/*
import 'package:flutter/material.dart';
import 'package:hedieaty/View/AddGiftsPage.dart';
import 'AddGiftsPage.dart';

class GiftListPage extends StatefulWidget {
  @override
  _GiftListPageState createState() => _GiftListPageState();
}

class _GiftListPageState extends State<GiftListPage> {
  List<Map<String, dynamic>> gifts = [
    {'name': 'Smartphone', 'description': 'A high-end smartphone', 'category': 'Electronics', 'price': '800', 'isPledged': false},
    {'name': 'Book', 'description': 'A mystery novel', 'category': 'Books', 'price': '20', 'isPledged': true},
  ];

  void _addGift(Map<String, dynamic> gift) {
    setState(() {
      gifts.add(gift);
    });
  }

  void _sortGiftsByName() {
    setState(() {
      gifts.sort((a, b) => a['name'].compareTo(b['name']));
    });
  }

  void _sortGiftsByCategory() {
    setState(() {
      gifts.sort((a, b) => a['category'].compareTo(b['category']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gift List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort_by_alpha),
            onPressed: _sortGiftsByName,
          ),
          IconButton(
            icon: const Icon(Icons.category),
            onPressed: _sortGiftsByCategory,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: gifts.length,
        itemBuilder: (context, index) {
          final gift = gifts[index];
          return ListTile(
            title: Text(gift['name']),
            subtitle: Text('${gift['category']} - ${gift['price']} USD'),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: gift['isPledged']
                  ? null
                  : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddGiftPage(
                      eventName: widget.events[eventIndex]['name'],
                      onAddGift: (Map<String, dynamic> GiftDetails, int index){
                        _onAddGift(GiftDetails,index);
                        },
                      index: eventIndex,
                    ),

                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddGiftPage(onAddGift: _addGift),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
*/