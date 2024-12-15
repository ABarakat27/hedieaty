import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Column(
        children: [
          ListTile(
            title: Text('Personal Info'),
            subtitle: Text('Update your personal information.'),
            onTap: () {},
          ),
          ListTile(
            title: Text('My Events'),
            onTap: () {
              Navigator.pushNamed(context, '/eventList');
            },
          ),
          ListTile(
            title: Text('My Pledged Gifts'),
            onTap: () {
              Navigator.pushNamed(context, '/pledgedGifts');
            },
          ),
        ],
      ),
    );
  }
}
