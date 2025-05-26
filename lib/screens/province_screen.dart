import 'package:flutter/material.dart';
import 'package:untitled1/screens/hotels_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../database/db_helper.dart';
import '../models/province.dart';
import '../models/province_photo.dart';
import 'historical_places_screen.dart';
import 'parks_screen.dart';
import 'restaurants_screen.dart';
import '../services/weather_service.dart'; // Import your DatabaseHelper

class ProvinceScreen extends StatelessWidget {
  final Province province;

  const ProvinceScreen({Key? key, required this.province}) : super(key: key);

  void _openLocation(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Widget categoryIcon(String assetPath, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 30,
          backgroundImage: AssetImage(assetPath),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Fetch photos from the database
  Future<List<String>> fetchPhotosFromDatabase() async {
    List<ProvincePhoto> photos = await DatabaseHelper().fetchProvincePhotos(
      province.id,
    );
    return photos
        .map((photo) => photo.image)
        .toList(); // Assuming imageUrl is the field to store photo URLs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEEFEF),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                  child: SizedBox(
                    height: 340,
                    width: double.infinity,
                    child: Image.asset(province.image, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 24,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ],
            ),

            // MAIN CONTENT
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Weather
                            FutureBuilder<String>(
                              future: WeatherService().getTemperature(
                                province.latitude,
                                province.longitude,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return const Text(
                                    'Failed to load temperature',
                                  );
                                } else {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.thermostat,
                                        color: Colors.black,
                                        size: 28,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${snapshot.data}°C',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),

                            const SizedBox(height: 16),

                            // Province Name + Location
                            Row(
                              children: [
                                GestureDetector(
                                  onTap:
                                      () => _openLocation(province.locationUrl),
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.orange,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    province.name,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Tabs: About / Photos
                            DefaultTabController(
                              length: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TabBar(
                                    labelColor: Colors.black,
                                    indicatorColor: Colors.deepOrange,
                                    tabs: [
                                      Tab(text: 'About'),
                                      Tab(text: 'Photos'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 250,
                                    child: TabBarView(
                                      children: [
                                        // About Tab
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 12,
                                          ),
                                          child: Text(
                                            province.description,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        // Photos Tab
                                        FutureBuilder<List<String>>(
                                          future: fetchPhotosFromDatabase(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (snapshot.hasError) {
                                              return const Center(
                                                child: Text(
                                                  "Failed to load photos",
                                                ),
                                              );
                                            } else if (!snapshot.hasData ||
                                                snapshot.data!.isEmpty) {
                                              return const Center(
                                                child: Text(
                                                  "No photos available",
                                                ),
                                              );
                                            } else {
                                              return PageView.builder(
                                                itemCount:
                                                    snapshot.data!.length,
                                                controller: PageController(
                                                  viewportFraction: 0.85,
                                                ),
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 16,
                                                        ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            16,
                                                          ),
                                                      child: Image.asset(
                                                        snapshot
                                                            .data![index], // Use the URL or path here
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // EXPLORE SECTION
                    const Text(
                      'Explore',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => HistoricalPlacesScreen(
                                      provinceId: province.id,
                                      provinceName: province.name,
                                    ),
                              ),
                            );
                          },
                          child: categoryIcon(
                            'assets/images/icons/historical_place.webp',
                            'Historical Places',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ParksScreen(
                                      provinceId: province.id,
                                      provinceName: province.name,
                                    ),
                              ),
                            );
                          },
                          child: categoryIcon(
                            'assets/images/icons/park.webp',
                            'Parks',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => HotelsScreen(
                                      provinceId: province.id,
                                      provinceName: province.name,
                                    ),
                              ),
                            );
                          },
                          child: categoryIcon(
                            'assets/images/icons/hotel.webp',
                            'Hotels',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => RestaurantsScreen(
                                      provinceId: province.id,
                                      provinceName: province.name,
                                    ),
                              ),
                            );
                          },
                          child: categoryIcon(
                            'assets/images/icons/restaurant.webp',
                            'Restaurants',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
