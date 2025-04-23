import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/province.dart';
import '../screens/balkh_screens/balkh_restaurants.dart';
import '../screens/herat_screens/herat_hotels.dart';
import '../screens/herat_screens/herat_restaraunts.dart';
import '../services/weather_service.dart';

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
                            // Weather info aligned to right
                            FutureBuilder<String>(
                              future: WeatherService().getTemperature(
                                province.latitude,
                                province.longitude,
                              ), // Use the lat/lon
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
                                        '${snapshot.data}°C', // Display the fetched temperature
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
                                Text(
                                  province.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

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
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 12,
                                          ),
                                          child: Text(province.about),
                                        ),
                                        province.photos.isEmpty
                                            ? const Center(
                                              child: Text(
                                                "No photos available",
                                              ),
                                            )
                                            : PageView.builder(
                                              itemCount: province.photos.length,
                                              controller: PageController(
                                                viewportFraction: 0.85,
                                              ),
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 16,
                                                      ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16,
                                                        ),
                                                    child: Image.asset(
                                                      province.photos[index],
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                    ),
                                                  ),
                                                );
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
                        categoryIcon(
                          'images/icons/historical_place.jpg',
                          'Historical Places',
                        ),
                        categoryIcon('images/icons/park.jpg', 'Parks'),
                        categoryIcon('images/icons/hotel.jpg', 'Hotels'),
                        GestureDetector(
                          onTap: () {
                            if (province.name == 'Herat') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => HeratRestaurantsScreen(),
                                ),
                              );
                            } else if (province.name == 'Balkh') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => BalkhRestaurantsScreen(),
                                ),
                              );
                            }
                            // else if (province.name == 'Bamyan') {
                            // Navigator.push(
                            // context,
                            // MaterialPageRoute(builder: (context) => BamyanRestaurantsScreen()),
                            // );
                            // } else if (province.name == 'Mazar') {
                            // Navigator.push(
                            // context,
                            // MaterialPageRoute(builder: (context) => MazarRestaurantsScreen()),
                            // );
                            // }
                          },

                          child: categoryIcon(
                            'images/icons/restaurant.jpg',
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
