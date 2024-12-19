/*import 'package:flutter/material.dart';

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
  /*void _addEvent() {
    TextEditingController eventNameController = TextEditingController();
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Event'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: eventNameController,
                    decoration: InputDecoration(
                      labelText: 'Event Name',
                      hintText: 'e.g., Birthday Party',
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    title: Text(selectedDate == null
                        ? 'Select Date'
                        : 'Date: ${selectedDate?.toLocal()}'.split(' ')[0]),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (eventNameController.text.isNotEmpty && selectedDate != null) {
                      setState(() {
                        // Add new event to the list
                        events.add({
                          'name': eventNameController.text,
                          'date': selectedDate,
                          'gifts': <>[],
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }
*/

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
*/







//////////////////////////////////////////////////////
/*
import 'package:flutter/material.dart';

class EventListPage extends StatefulWidget {
  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  final List<Map<String, dynamic>> events = [
    {'name': 'Birthday', 'date': DateTime(2024, 12, 25), 'gifts': []},
    {'name': 'Wedding', 'date': DateTime(2023, 10, 10), 'gifts': []},
  ];

  void _addEvent() {
    TextEditingController eventNameController = TextEditingController();
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Event'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: eventNameController,
                    decoration: InputDecoration(
                      labelText: 'Event Name',
                      hintText: 'e.g., Birthday Party',
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    title: Text(selectedDate == null
                        ? 'Select Date'
                        : 'Date: ${selectedDate?.toLocal()}'.split(' ')[0]),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (eventNameController.text.isNotEmpty && selectedDate != null) {
                      setState(() {
                        events.add({
                          'name': eventNameController.text,
                          'date': selectedDate,
                          'gifts': [],
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _sortEvents(String criteria) {
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
        title: Text('Event List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _sortEvents,
            itemBuilder: (context) => [
              PopupMenuItem(value: 'date', child: Text('Sort by Date')),
              PopupMenuItem(value: 'alphabetical', child: Text('Sort by Name')),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return ListTile(
            title: Text(event['name']),
            subtitle: Text('Date: ${event['date'].toLocal()}'.split(' ')[0]),
            onTap: () {
              Navigator.pushNamed(context, '/giftList');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        child: Icon(Icons.add),
      ),
    );
  }
}
*/

///////////////////////////////////THIS ONE IS THE WORKING ONE

/*
import 'package:flutter/material.dart';
import 'package:hedieaty/View/AddGiftsPage.dart';

class EventListPage extends StatefulWidget {
   List<Map<String, dynamic>> events ;

  EventListPage({Key? key, required this.events}) : super(key: key);

  @override
  _EventListPageState createState() => _EventListPageState();
}


class _EventListPageState extends State<EventListPage> {

  void _onAddGift(Map<String, dynamic> GiftDetails, int index){

    setState(() {
      widget.events[index]['gifts'].add({
        'name': GiftDetails['name'],
        'description': GiftDetails['description'],
        'category': GiftDetails['category'],
        'price': GiftDetails['price'],
        'isPledged': GiftDetails['isPledged']
      });
    });
  }

  void _addGiftToEvent(int eventIndex) async {
    final newGift = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddGiftPage(eventName: widget.events[eventIndex]['name'], onAddGift: (Map<String, dynamic> GiftDetails, int index){_onAddGift(GiftDetails,index);}, index: eventIndex,),
      ),
    );

    if (newGift != null) {
      setState(() {
        widget.events[eventIndex]['gifts'].add(newGift);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Events')),
      body: ListView.builder(
        itemCount: widget.events.length,
        itemBuilder: (context, index) {
          final event = widget.events[index];
          return Card(
            child: ListTile(
              title: Text(event['name']),
              subtitle: Text(
                'Date: ${event['date']} \nGifts: ${event['gifts'].join(', ')}',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _addGiftToEvent(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';

import 'AddGiftsPage.dart';

class EventListPage extends StatefulWidget {
  final List<Map<String, dynamic>> events;

  const EventListPage({Key? key, required this.events}) : super(key: key);

  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  int? expandedEventIndex;

  void _toggleEventExpansion(int index) {
    setState(() {
      if (expandedEventIndex == index) {
        expandedEventIndex = null; // Collapse if already expanded
      } else {
        expandedEventIndex = index; // Expand the selected event
      }
    });
  }

  void _onAddGift(Map<String, dynamic> giftDetails, int index) {
    setState(() {
      widget.events[index]['gifts'].add(giftDetails);
    });
  }

  void _addGiftToEvent(int eventIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddGiftPage(
          eventName: widget.events[eventIndex]['name'],
          index: eventIndex,
          onAddGift: _onAddGift,
        ),
      ),
    );
  }

  void _sortEvents(String criteria) {
    setState(() {
      if (criteria == 'date') {
        widget.events.sort((a, b) => a['date'].compareTo(b['date']));
      } else if (criteria == 'alphabetical') {
        widget.events.sort((a, b) => a['name'].compareTo(b['name']));
      }
    });
  }

  void _addEvent() {
    TextEditingController eventNameController = TextEditingController();
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Event'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: eventNameController,
                    decoration: InputDecoration(
                      labelText: 'Event Name',
                      hintText: 'e.g., Birthday Party',
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    title: Text(selectedDate == null
                        ? 'Select Date'
                        : 'Date: ${selectedDate?.toLocal()}'.split(' ')[0]),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (eventNameController.text.isNotEmpty && selectedDate != null) {
                      setState(() {
                        widget.events.add({
                          'name': eventNameController.text,
                          'date': selectedDate,
                          'gifts': [],
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Your Events'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _sortEvents,
            itemBuilder: (context) => [
              PopupMenuItem(value: 'date', child: Text('Sort by Date')),
              PopupMenuItem(value: 'alphabetical', child: Text('Sort by Name')),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.events.length,
        itemBuilder: (context, index) {
          final event = widget.events[index];
          final isExpanded = expandedEventIndex == index;

          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(event['name']),
                  subtitle: Text('Date: ${event['date']}'),
                  trailing: IconButton(
                    icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                    onPressed: () => _toggleEventExpansion(index),
                  ),
                ),
                if (isExpanded)

                  Column(
                    children: [
                      ...event['gifts'].map<Widget>((gift) {
                        return ListTile(
                          title: Text(gift['name']),
                          subtitle: Text(

                              '${gift['category']} - \$${gift['price']} - Pledged: ${gift['isPledged']=='true'? "yes": "no"}'),
                        );
                      }).toList(),
                      ElevatedButton(
                        onPressed: () => _addGiftToEvent(index),
                        child: const Text('Add Gift'),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        child: Icon(Icons.add),
      ),
    );
  }
}
