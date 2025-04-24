
import 'package:flutter/material.dart';
import 'package:untitled1/screens/profile_page.dart';

import '../constants/colors.dart';
import '../constants/icons.dart';
import '../data/province_data.dart';
import '../widgets/city_card.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/province_screen_widget.dart';
import 'herat_screens/herat_main.dart';

/// 1. HomePage is a stateless widget that shows a top menu row + list of city cards.
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  /// 2. Key to control the Scaffold, so we can open the drawer programmatically.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// 3. Sample data for the four Afghan cities.
  final List<Map<String, String>> cities = [
    {
      'name': 'Herat',
      'location': 'western of AFG',
      'image': 'images/Herat.jpg',
    },
    {
      'name': 'Kabul',
      'location': 'eastern of AFG',
      'image': 'images/Kabul.jpg',
    },
    {
      'name': 'Balkh',
      'location': 'northern of AFG',
      'image': 'images/Balkh.jpg',
    },
    {
      'name': 'Bamiyan',
      'location': 'central of AFG',
      'image': 'images/Bamiyan.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // 4. Scaffold provides the overall layout: a hidden drawer + body content.
    return Scaffold(
      key: _scaffoldKey,
        drawer: const CustomDrawer(), // ✅ from widgets/custom_drawer.dart// Hidden by default, opens when tapped
      body: SafeArea(
        // 5. SafeArea ensures no overlap with status bar/notch
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // ─── Top Menu Row ────────────────────────────────────────────
              Row(
                children: [
                  // 6a. Hamburger icon to open the drawer
                  IconButton(
                    icon: kListIcon,
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
                  const SizedBox(width: 8),
                  // 6b. Title text for the page
                  const Expanded(
                    child: Text(
                      'Popular Cities of Afghanistan',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // 6c. Profile icon navigates to ProfilePage
                  IconButton(
                    icon: const Icon(
                      Icons.account_circle,
                      size: 32,
                      color: kListIconColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ProfilePage()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ─── City Cards List ────────────────────────────────────────
              Expanded(
                // 7. ListView.builder to dynamically generate a card for each city
                child: ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    final city = cities[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                        // 7a. Tapping a card pushes to the HeratCityPage
                        onTap: () {
                          if (city['name'] == 'Herat') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProvinceScreen(province: heratProvince),
                              ),
                            );
                          } else if (city['name'] == 'Kabul') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProvinceScreen(province: kabulProvince),
                              ),
                            );
                          } else if (city['name'] == 'Balkh') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProvinceScreen(province: balkhProvince),
                              ),
                            );
                          } else if (city['name'] == 'Bamiyan') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProvinceScreen(province: bamiyanProvince),
                              ),
                            );
                          }
                        },
                        child: CityCard(
                          name: city['name']!,
                          location: city['location']!,
                          image: city['image']!,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 9. CityCard is a reusable widget for displaying each city.
///    - White background restored
///    - Increased padding & image size for a larger look
