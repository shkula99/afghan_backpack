import 'package:flutter/material.dart';
import 'package:untitled1/models/province.dart';
import 'package:untitled1/screens/province_screen.dart';
import '../constants/icons.dart';
import '../database/db_helper.dart';
import '../widgets/city_card.dart';
import '../widgets/custom_drawer.dart';

/// 1. HomePage is a stateless widget that shows a top menu row + list of city cards.
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  /// 2. Key to control the Scaffold, so we can open the drawer programmatically.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// 3. Static list of cities with id.
  final List<Map<String, dynamic>> cities = [
    {
      'id': 1,
      'name': 'Kabul',
      'location': 'East of AFG',
      'image': 'assets/images/Kabul.webp',
    },
    {
      'id': 2,
      'name': 'Herat',
      'location': 'West of AFG',
      'image': 'assets/images/Herat.webp',
    },
    {
      'id': 3,
      'name': 'Balkh',
      'location': 'North of AFG',
      'image': 'assets/images/Balkh.webp',
    },
    {
      'id': 4,
      'name': 'Bamiyan',
      'location': 'Centre of AFG',
      'image': 'assets/images/Bamiyan.webp',
    },
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
              // Top Menu Row
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
                ],
              ),
              const SizedBox(height: 16),

              // City Cards List
              Expanded(
                child: ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    final city = cities[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                        onTap: () => _openProvince(context, city['id']),
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

  /// Function to fetch province by ID and open its details page
  Future<void> _openProvince(BuildContext context, int provinceId) async {
    final dbHelper = DatabaseHelper();
    Province? province = await dbHelper.fetchProvinceById(provinceId);
    if (province != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProvinceScreen(province: province),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Province not found.')),
      );
    }
  }
}
