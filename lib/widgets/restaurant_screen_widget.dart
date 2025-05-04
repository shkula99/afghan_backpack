import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import '../database/db_helper.dart';
import '../models/restaurant.dart';
import '../models/restaurant_photo.dart';

final Map<int, String> provinceNames = {
  1: 'Kabul',
  2: 'Herat',
  3: 'Balkh',
  4: 'Bamiyan',
};

class RestaurantScreenWidget extends StatelessWidget {
  final int restaurantId;

  Future<void> _openLocation(BuildContext context, double latitude, double longitude) async {
    final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    final uri = Uri.parse(googleMapsUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open Google Maps')),
      );
    }
  }


  const RestaurantScreenWidget({super.key, required this.restaurantId});

  Future<Restaurant> _fetchRestaurant(BuildContext context) async {
    final dbHelper = DatabaseHelper();
    final restaurant = await dbHelper.fetchRestaurantById(restaurantId);
    return restaurant!;
  }

  Future<List<RestaurantPhoto>> _fetchRestaurantPhotos(
    BuildContext context,
  ) async {
    final dbHelper = DatabaseHelper();
    final photos = await dbHelper.fetchRestaurantPhotos(restaurantId);
    return photos;
  }

  // Fullscreen photo gallery
  Widget _buildPhotoGallery(
    BuildContext context,
    List<RestaurantPhoto> photos,
  ) {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height *
          0.23, // Adjusted height for better proportion
      child: PageView.builder(
        itemCount: photos.length,
        controller: PageController(
          viewportFraction: 0.85,
        ), // Adjusting to fit the images nicely
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 16,
            ), // Add padding for spacing
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16), // Rounded corners
              child: Image.asset(
                photos[index]
                    .image, // Assuming photos are stored with URLs or network path
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          );
        },
      ),
    );
  }

  // Contact icons
  Widget _buildContactIcons(BuildContext context, Restaurant restaurant) {
    Future<void> _launchUrl(String url) async {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not launch URL')));
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Icons centered
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
    return FutureBuilder<Restaurant>(
      future: _fetchRestaurant(context), // Fetching restaurant data from DB
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: Text('No restaurant data found.'));
        }

        final restaurant = snapshot.data!;

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
                        restaurant
                            .image, // Assuming the image is fetched from a URL or network path
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
                          onPressed: () => Navigator.pop(context)
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
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.location_on, color: Colors.red),
                            onPressed: () => _openLocation(context, restaurant.latitude, restaurant.longitude),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${provinceNames[restaurant.provinceId] ?? "Unknown"}, AFG',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),
                      const SizedBox(height: 20),
                      Text(
                        'About',
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
                    ],
                  ),
                ),

                // Photos section
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Photos',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Fetching and displaying photos from the database
                      FutureBuilder<List<RestaurantPhoto>>(
                        future: _fetchRestaurantPhotos(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text('No photos available.'),
                            );
                          }

                          final photos = snapshot.data!;

                          return _buildPhotoGallery(context, photos);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(10),
            child: _buildContactIcons(context, restaurant),
          ),
        );
      },
    );
  }
}
