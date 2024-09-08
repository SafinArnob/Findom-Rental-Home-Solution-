import 'package:flutter/material.dart';

import 'add_home.dart'; // Import the AddHomePage

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/image1.png'),
                ),
                SizedBox(height: 10),
                Text(
                  'example@email.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading:
                Icon(Icons.add_home_work_outlined), // Icon for Rent Your Home
            title: Text('Rent Your Home'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddHomePage()),
              );
            },
          ),
          // Add more ListTiles for additional drawer items
        ],
      ),
    );
  }
}
