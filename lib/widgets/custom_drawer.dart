
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            accountName: const Text(
              'Narges Farahi',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text(
              'narges.farahi_354@example.com',
              style: TextStyle(color: Colors.grey),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(Icons.home, 'Home', () {
                  Navigator.pop(context);
                }),
                _buildDrawerItem(Icons.favorite, 'Favorites', () {}),
                _buildDrawerItem(Icons.star, 'Stars', () {}),
                _buildDrawerItem(Icons.person, 'Profile', () {}),
                _buildDrawerItem(Icons.call, 'Contact Us', () {}),
                _buildDrawerItem(Icons.logout, 'Log out', () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
      horizontalTitleGap: 10,
    );
  }
}