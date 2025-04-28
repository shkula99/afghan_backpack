

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/restaurant_card.dart';

class HeratRestaurantsScreen extends StatelessWidget {
  final List<Map<String, String>> restaurants = [
    {
      'name': 'Parmis Restaurant',
      'image': 'assets/images/herat_resturants/parmis/4.jpg',
      'description': 'Herat Afghanistan'
    },
    {
      'name': 'Parmis Restaurant',
      'image': 'assets/images/herat_resturants/parmis/4.jpg',
      'description': 'Herat Afghanistan'
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCEFEA),
      body: SafeArea(
        child: Column(
          children: [
            // Header
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
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Herat',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            // Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Restaurants',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Grid
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
                      name: restaurant['name']!,
                      image: restaurant['image']!,
                      description: restaurant['description']!, // Add this in your data
                      onTap: () {
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

