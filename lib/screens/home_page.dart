import 'package:flutter/material.dart';
import 'package:untitled1/screens/profile_page.dart';
import '../constants/colors.dart';
import '../constants/icons.dart';
import '../widgets/city_card.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/province_screen_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> cities = [
    {'name': 'Herat', 'location': 'Western Afghanistan', 'image': 'assets/images/Herat.jpg', 'id': 2},
    {'name': 'Kabul', 'location': 'Eastern Afghanistan', 'image': 'assets/images/Kabul.jpg', 'id': 1},
    {'name': 'Balkh', 'location': 'Northern Afghanistan', 'image': 'assets/images/Balkh.jpg', 'id': 3},
    {'name': 'Bamiyan', 'location': 'Central Afghanistan', 'image': 'assets/images/Bamiyan.jpg', 'id': 4},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: kListIcon,
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Popular Cities of Afghanistan',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
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
              Expanded(
                child: ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    final city = cities[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProvinceScreen(
                                provinceId: city['id'],
                                provinceName: city['name'],
                              ),
                            ),
                          );
                        },
                        child: CityCard(
                          name: city['name'],
                          location: city['location'],
                          image: city['image'],
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
