
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        leading: BackButton(),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 65,
              backgroundColor: Colors.blue.shade100,
              backgroundImage: AssetImage('assets/images/bag.webp'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Afghan Backpack',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Are you ready to pack your bag and visit Afghanistan? Afghan Backpack is your virtual assistant. Don’t panic! We got your back! You can find the best hotels, historical places and beautiful outdoor parks of Afghanistan in this app. Thanks for adding us to your exciting journey. Let’s start!",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),
            const Text(
              "Developers:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildDeveloper("Shkula Noorza", FontAwesomeIcons.twitter),
            _buildDeveloper("Narges Farahi", FontAwesomeIcons.twitter),
            _buildDeveloper("Fatameh Mahdizada", FontAwesomeIcons.twitter),
            const Divider(),
            const Text(
              "Connect with us:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _SocialIcon(icon: Icons.email, color: Colors.amber),
                _SocialIcon(icon: FontAwesomeIcons.twitter, color: Colors.lightBlue),
                _SocialIcon(icon: FontAwesomeIcons.facebook, color: Colors.indigo),
                _SocialIcon(icon: Icons.call, color: Colors.red),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Version "),
            const Text("© 2025 Code To Inspire"),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }

  Widget _buildDeveloper(String name, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
      child: Card(
        elevation: 2,
        child: ListTile(
          title: Text(name),
          trailing: Icon(icon, color: Colors.teal),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _SocialIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CircleAvatar(
        backgroundColor: color,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}