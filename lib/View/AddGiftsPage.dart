/*import 'package:flutter/material.dart';

class AddGiftPage extends StatefulWidget {
  final String eventName;

  const AddGiftPage({Key? key, required this.eventName}) : super(key: key);

  @override
  _AddGiftPageState createState() => _AddGiftPageState();
}

class _AddGiftPageState extends State<AddGiftPage> {
  final TextEditingController giftController = TextEditingController();

  void _submitGift() {
    if (giftController.text.isNotEmpty) {
      Navigator.pop(context, giftController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Gift to ${widget.eventName}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: giftController,
              decoration: const InputDecoration(labelText: 'Gift Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitGift,
              child: const Text('Add Gift'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';

class AddGiftPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddGift;

  const AddGiftPage({Key? key, required this.onAddGift}) : super(key: key);

  @override
  _AddGiftPageState createState() => _AddGiftPageState();
}

class _AddGiftPageState extends State<AddGiftPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  bool _isPledged = false;

  void _saveGift() {
    if (_nameController.text.isEmpty || _categoryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name and category are required!')),
      );
      return;
    }

    widget.onAddGift({
      'name': _nameController.text,
      'description': _descriptionController.text,
      'category': _categoryController.text,
      'price': _priceController.text,
      'isPledged': _isPledged,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Gift'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Gift Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Mark as Pledged:'),
                Switch(
                  value: _isPledged,
                  onChanged: (value) {
                    setState(() {
                      _isPledged = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveGift,
              child: const Text('Save Gift'),
            ),
          ],
        ),
      ),
    );
  }
}
*/

///////////////////////THIS ONE IS WORKING
/*
import 'package:flutter/material.dart';

class AddGiftPage extends StatefulWidget {
  final Function(Map<String, dynamic>, int index) onAddGift;
  final String eventName;
  final int index ;
  const AddGiftPage({Key? key, required this.onAddGift, required this.eventName, required this.index}) : super(key: key);

  @override
  _AddGiftPageState createState() => _AddGiftPageState();
}

class _AddGiftPageState extends State<AddGiftPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  bool _isPledged = false;

  void _saveGift() {
    if (_nameController.text.isEmpty || _categoryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name and category are required!')),
      );
      return;
    }

    widget.onAddGift({
      'name': _nameController.text,
      'description': _descriptionController.text,
      'category': _categoryController.text,
      'price': _priceController.text,
      'isPledged': _isPledged
    },
    widget.index,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Gift to ${widget.eventName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Gift Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Mark as Pledged:'),
                Switch(
                  value: _isPledged,
                  onChanged: (value) {
                    setState(() {
                      _isPledged = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveGift,
              child: const Text('Save Gift'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';

class AddGiftPage extends StatefulWidget {
  final Function(Map<String, dynamic>, int) onAddGift;
  final String eventName;
  final int index;

  const AddGiftPage({
    Key? key,
    required this.onAddGift,
    required this.eventName,
    required this.index,
  }) : super(key: key);

  @override
  _AddGiftPageState createState() => _AddGiftPageState();
}

class _AddGiftPageState extends State<AddGiftPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  bool isPledged = false;

  void _saveGift() {
    if (nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        categoryController.text.isNotEmpty &&
        priceController.text.isNotEmpty) {
      final newGift = {
        'name': nameController.text,
        'description': descriptionController.text,
        'category': categoryController.text,
        'price': int.tryParse(priceController.text) ?? 0, // Convert price to int
        'isPledged': false, // Boolean value
      };
      widget.onAddGift(newGift, widget.index);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Gift to ${widget.eventName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Gift Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Pledged'),
                Switch(
                  value: isPledged,
                  onChanged: (value) {
                    setState(() {
                      isPledged = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveGift,
              child: const Text('Save Gift'),
            ),
          ],
        ),
      ),
    );
  }
}
