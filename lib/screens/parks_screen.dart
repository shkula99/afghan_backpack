import 'package:flutter/material.dart';
import '../../models/park.dart';
import '../../database/db_helper.dart';
import '../../widgets/park_screen_widget.dart';
import '../widgets/place_card.dart';

class ParksScreen extends StatefulWidget {
  final int provinceId;
  final String provinceName;

  const ParksScreen({
    required this.provinceId,
    required this.provinceName,
    Key? key,
  }) : super(key: key);

  @override
  State<ParksScreen> createState() => _ParksScreenState();
}

class _ParksScreenState extends State<ParksScreen> {
  late Future<List<Park>> _parksFuture;

  @override
  void initState() {
    super.initState();
    _parksFuture = _fetchParks();
  }

  Future<List<Park>> _fetchParks() async {
    final dbHelper = DatabaseHelper();
    final allParks = await dbHelper.fetchParks();
    return allParks.where((park) => park.provinceId == widget.provinceId).toList();
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
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No parks found"));
            }

            final parks = snapshot.data!;

            return Column(
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
                    child: Text('Parks', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ),

                const SizedBox(height: 16),

                // Grid View
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
                        return PlaceCard(
                          name: park.name,
                          image: park.image,
                          description: '${widget.provinceName}, Afghanistan',
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
