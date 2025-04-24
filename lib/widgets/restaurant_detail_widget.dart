import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import '../models/restaurant.dart';

class RestaurantDetailWidget extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailWidget({super.key, required this.restaurant});

  // Fullscreen photo gallery
  Widget _buildPhotoGallery(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: PageView.builder(
        itemCount: restaurant.photos.length,
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(restaurant.photos[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  // Contact icons
  Widget _buildContactIcons(BuildContext context) {
    Future<void> _launchUrl(String url) async {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch URL')),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (restaurant.phone.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.phone, size: 30),
              onPressed: () => _launchUrl('tel:${restaurant.phone}'),
            ),
          if (restaurant.email.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.email, size: 30),
              onPressed: () => _launchUrl('mailto:${restaurant.email}'),
            ),
          if (restaurant.website.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.language, size: 30),
              onPressed: () => _launchUrl(restaurant.website),
            ),
          if (restaurant.facebook.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.facebook, size: 30),
              onPressed: () => _launchUrl(restaurant.facebook),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kTextColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top image with back and favorite icons
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  child: Image.asset(
                    restaurant.image,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  top: 250,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),

            // Restaurant info
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('${restaurant.province}, AFG'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 20),
                  Text(
                    'Description',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    height: 3,
                    width: 65,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    restaurant.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  // Contact icons
                  _buildContactIcons(context),

                  Text(
                    'Photos',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildPhotoGallery(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
