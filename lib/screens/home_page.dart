import 'package:flutter/material.dart';
import 'package:untitled1/models/province.dart';
import 'package:untitled1/screens/province_screen.dart';
import '../constants/icons.dart';
import '../database/db_helper.dart';
import '../widgets/city_card.dart';
import '../widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late Future<List<Province>> _provincesFuture;

  /// Static location descriptions based on province ID
  final Map<int, String> staticLocations = {
    1: 'East of AFG',
    2: 'West of AFG',
    3: 'North of AFG',
    4: 'Centre of AFG',
  };

  @override
  void initState() {
    super.initState();
    _provincesFuture = DatabaseHelper().fetchProvinces();
  }

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
              /// Top Bar
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

              /// Dynamic List of City Cards
              Expanded(
                child: FutureBuilder<List<Province>>(
                  future: _provincesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error loading provinces'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No provinces found'));
                    }

                    final provinces = snapshot.data!;

                    return ListView.builder(
                      itemCount: provinces.length,
                      itemBuilder: (context, index) {
                        final province = provinces[index];
                        final staticLocation = staticLocations[province.id] ?? 'Unknown region';

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            onTap: () => _openProvince(context, province.id),
                            child: CityCard(
                              name: province.name,
                              image: province.image,
                              location: staticLocation,
                            ),
                          ),
                        );
                      },
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

  /// Opens province details using its ID from SQLite
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
