import 'package:flutter/material.dart';

class CreateGiftDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gift Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Gift Name')),
            TextField(decoration: InputDecoration(labelText: 'Description')),
            TextField(decoration: InputDecoration(labelText: 'Category')),
            TextField(decoration: InputDecoration(labelText: 'Price')),
            ElevatedButton(onPressed: () {}, child: Text('Upload Image')),
            SwitchListTile(
              title: Text('Pledged'),
              value: false,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
