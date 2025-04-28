import 'package:flutter/material.dart';

import '../../models/restaurant.dart';
import '../../database/db_helper.dart';
import '../../widgets/restaurant_card.dart';
import 'balkh_restaurant_details.dart'; // Adjust this path if needed

class BalkhRestaurantsScreen extends StatefulWidget {
  @override
  State<BalkhRestaurantsScreen> createState() => _BalkhRestaurantsScreenState();
}

class _BalkhRestaurantsScreenState extends State<BalkhRestaurantsScreen> {
  late Future<List<Restaurant>> _restaurantsFuture;

  @override
  void initState() {
    super.initState();
    _restaurantsFuture = _fetchRestaurants();
  }

  Future<List<Restaurant>> _fetchRestaurants() async {
    final db = await DBHelper.instance;
    final result = await db.query(
      'restaurants',
      where: 'province = ?',
      whereArgs: [3], // Use province id for Balkh (example id = 3)
    );
    return result.map((map) => Restaurant.fromMap(map)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCEFEA),
      body: SafeArea(
        child: FutureBuilder<List<Restaurant>>(
          future: _restaurantsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No restaurants found'));
            }

            final restaurants = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 8)
                            ],
                          ),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Balkh',
                        style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Restaurants',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 16),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      itemCount: restaurants.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final restaurant = restaurants[index];
                        return RestaurantCard(
                          name: restaurant.name,
                          image: restaurant.image,
                          description: 'Balkh, Afghanistan', // You can later make this dynamic if needed
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BalkhRestaurantDetailScreen(
                                  restaurantId: restaurant.id,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
