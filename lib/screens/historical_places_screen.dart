import 'package:flutter/material.dart';
import '../../database/db_helper.dart';
import '../../models/historical_place.dart';
import '../../widgets/historical_place_screen_widget.dart';
import '../widgets/place_card.dart';

class HistoricalPlacesScreen extends StatefulWidget {
  final int provinceId;
  final String provinceName;

  const HistoricalPlacesScreen({
    Key? key,
    required this.provinceId,
    required this.provinceName,
  }) : super(key: key);

  @override
  State<HistoricalPlacesScreen> createState() => _HistoricalPlacesScreenState();
}

class _HistoricalPlacesScreenState extends State<HistoricalPlacesScreen> {
  late Future<List<HistoricalPlace>> _historicalPlacesFuture;

  @override
  void initState() {
    super.initState();
    _historicalPlacesFuture = _fetchHistoricalPlaces();
  }

  Future<List<HistoricalPlace>> _fetchHistoricalPlaces() async {
    final dbHelper = DatabaseHelper();
    final allHistoricalPlaces = await dbHelper.fetchHistoricalPlaces();
    return allHistoricalPlaces
        .where((place) => place.provinceId == widget.provinceId)
        .toList();
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
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No historical places found"));
            }

            final historicalPlaces = snapshot.data!;

            return Column(
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
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                          ),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        widget.provinceName,
                        style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Historical Places',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 16),
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
                        return PlaceCard(
                          name: historicalPlace.name,
                          image: historicalPlace.image,
                          description: '${widget.provinceName}, Afghanistan',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoricalPlaceScreenWidget(
                                    historicalPlaceId: historicalPlace.id),
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
