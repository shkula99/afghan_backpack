import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        leading: const BackButton(),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 65,
              backgroundColor: Colors.blue.shade100,
              backgroundImage: const AssetImage('assets/images/bag.webp'),
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
            _buildDeveloper(
              "Shkula Noorzai",
              FontAwesomeIcons.xTwitter,
              'https://x.com/ShkulaN?t=60B53XYIvO5gmbmQ69L-cA&s=35',
            ),
            _buildDeveloper(
              "Narges Farahi",
              FontAwesomeIcons.xTwitter,
              'https://x.com/FarahiNarg21721?t=auqqO9agHfelBPKI-SW-rg&s=35',
            ),
            _buildDeveloper(
              "Fatameh Mahdizada",
              FontAwesomeIcons.xTwitter,
              'https://x.com/FMadizada90174?t=LH4jUwWYzSK6sm--JswqdQ&s=35',
            ),
            const Divider(),
            const Text(
              "Connect with us:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SocialIcon(
                  icon: Icons.call,
                  color: Colors.red,
                  onTap: () => _launchURL('tel:0798300430'),
                ),
                _SocialIcon(
                  icon: FontAwesomeIcons.xTwitter,
                  color: Colors.black,
                  onTap: () =>
                      _launchURL('https://x.com/codetoinspire?lang=en'),
                ),
                _SocialIcon(
                  icon: FontAwesomeIcons.instagram,
                  color: Colors.pink,
                  onTap: () =>
                      _launchURL('https://www.instagram.com/codetoinspire/'),
                ),
                _SocialIcon(
                  icon: FontAwesomeIcons.linkedin,
                  color: Colors.blue,
                  onTap: () => _launchURL(
                      'https://www.linkedin.com/company/code-to-inspire'),
                ),
                _SocialIcon(
                  icon: FontAwesomeIcons.facebook,
                  color: Colors.indigo,
                  onTap: () =>
                      _launchURL('https://m.facebook.com/CodeToInspire/'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Version 1.0.0"),
            const Text("© 2025 Code To Inspire"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static Widget _buildDeveloper(String name, IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
      child: Card(
        elevation: 2,
        child: ListTile(
          title: Text(name),
          trailing: IconButton(
            icon: Icon(icon, color: Colors.teal),
            onPressed: () => _launchURL(url),
          ),
        ),
      ),
    );
  }

  static Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _SocialIcon({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icon, color: color),
        ),
      ),
    );
  }
}
