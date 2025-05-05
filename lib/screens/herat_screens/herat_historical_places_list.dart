import 'package:flutter/material.dart';
import 'package:untitled1/models/historical_place.dart';
import 'package:untitled1/widgets/historical_place_screen_widget.dart';
import '../../database/db_helper.dart';
import '../../widgets/historical_place_card.dart';




class HeratHistoricalPlacesScreen extends StatefulWidget {


  @override
  State<HeratHistoricalPlacesScreen> createState() => _HeratHistoricalPlacesScreenState();
}

class _HeratHistoricalPlacesScreenState extends State<HeratHistoricalPlacesScreen> {
  late Future<List<HistoricalPlace>> _historicalPlacesFuture;

  @override
  void initState() {
    super.initState();
    _historicalPlacesFuture = _fetchHistoricalPlaces();
  }

  // Function to fetch parks data from the database
  Future<List<HistoricalPlace>> _fetchHistoricalPlaces() async {
    final dbHelper = DatabaseHelper();
    final allHistoricalPlaces = await dbHelper.fetchHistoricalPlaces();

    // Only select historical places from herat
    final balkhHistoricalPlaces = allHistoricalPlaces.where((historicalPlace) => historicalPlace.provinceId == 2).toList();

    return balkhHistoricalPlaces;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCEFEA),
      body: SafeArea(
        child: FutureBuilder<List<HistoricalPlace>>(
          future: _historicalPlacesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No historical place found"));
            }

            final historicalPlaces = snapshot.data!;

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
                        'Herat',
                        style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Historical Places', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ),

                const SizedBox(height: 16),

                // GridView to display parks
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      itemCount: historicalPlaces.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final historicalPlace = historicalPlaces[index];
                        return HistoricalPlaceCard(
                          name: historicalPlace.name,
                          image: historicalPlace.image,
                          description: 'Herat, Afghanistan',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoricalPlaceScreenWidget(historicalPlaceId: historicalPlace.id),
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
