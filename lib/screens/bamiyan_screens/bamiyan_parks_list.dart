import 'package:flutter/material.dart';

import '../../database/db_helper.dart';
import '../../models/park.dart';
import '../../widgets/park_card.dart';
import '../../widgets/park_screen_widget.dart';




class BamiyanParksScreen extends StatefulWidget {


  @override
  State<BamiyanParksScreen> createState() => _BamiyanParksScreenState();
}

class _BamiyanParksScreenState extends State<BamiyanParksScreen> {
  late Future<List<Park>> _parksFuture;

  @override
  void initState() {
    super.initState();
    _parksFuture = _fetchParks();
  }

  // Function to fetch parks data from the database
  Future<List<Park>> _fetchParks() async {
    final dbHelper = DatabaseHelper();
    final allParks = await dbHelper.fetchParks();

    // Only select parks from Bamiyan
    final bamiyanParks = allParks.where((park) => park.provinceId == 4).toList();

    return bamiyanParks;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCEFEA),
      body: SafeArea(
        child: FutureBuilder<List<Park>>(
          future: _parksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No hotels found"));
            }

            final parks = snapshot.data!;

            return Column(
              children: [
                // Header section with back button and title
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
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                          ),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Bamiyan',
                        style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Parks', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ),

                const SizedBox(height: 16),

                // GridView to display parks
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      itemCount: parks.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final park = parks[index];
                        return ParkCard(
                          name: park.name,
                          image: park.image,
                          description: 'Bamiyan, Afghanistan',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ParkScreenWidget(parkId: park.id),
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
