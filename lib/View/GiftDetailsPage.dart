import 'package:flutter/material.dart';

class GiftDetailsPage extends StatelessWidget {
  final String giftName;

  const GiftDetailsPage({super.key, required this.giftName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gift Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gift Name: $giftName',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Details about $giftName will be shown here.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add functionality to pledge the gift.
              },
              child: Text('Pledge Gift'),
            ),
          ],
        ),
      ),
    );
  }
}
