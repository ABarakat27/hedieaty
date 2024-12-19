import 'package:flutter/material.dart';

class ShowGiftDetailsPage extends StatelessWidget {
  final Map<String, dynamic> gift = {
    'name': 'Wireless Headphones',
    'description': 'High-quality noise-canceling wireless headphones.',
    'category': 'Electronics',
    'price': 250.00,
    'image': 'https://placebear.com/150/150',
    'isPledged': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gift Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                gift['image'],
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              gift['name'],
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),

            Text(
              gift['description'],
              style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
            ),
            const SizedBox(height: 16.0),

            Row(
              children: [
                Text(
                  'Category: ',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  gift['category'],
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 8.0),

            // Gift Price
            Row(
              children: [
                Text(
                  'Price: ',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${gift['price'].toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 8.0),

            Row(
              children: [
                Text(
                  'Status: ',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  gift['isPledged'] ? 'Pledged' : 'Available',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: gift['isPledged'] ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back to List'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
