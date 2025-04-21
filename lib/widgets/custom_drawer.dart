import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text('Narges Farahi'),
            accountEmail: Text('narges.farahi_354@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),
          const ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
          ),
          const ListTile(
            leading: Icon(Icons.star),
            title: Text('Stars'),
          ),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
          ),
          const ListTile(
            leading: Icon(Icons.call),
            title: Text('Call Us'),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
          ),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log out'),
          ),
        ],
      ),
    );
  }
}
