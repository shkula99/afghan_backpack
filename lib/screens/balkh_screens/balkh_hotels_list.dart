import 'package:flutter/material.dart';
import 'package:untitled1/models/hotel.dart';
import '../../database/db_helper.dart';
import '../../widgets/hotel_card.dart';
import '../../widgets/hotel_screen_widget.dart';




class BalkhHotelsScreen extends StatefulWidget {


  @override
  State<BalkhHotelsScreen> createState() => _BalkhHotelsScreenState();
}

class _BalkhHotelsScreenState extends State<BalkhHotelsScreen> {
  late Future<List<Hotel>> _hotelsFuture;

  @override
  void initState() {
    super.initState();
    _hotelsFuture = _fetchHotels();
  }

  // Function to fetch hotels data from the database
  Future<List<Hotel>> _fetchHotels() async {
    final dbHelper = DatabaseHelper();
    final allHotels = await dbHelper.fetchHotels();

    // Only select hotels from Balkh
    final balkhHotels = allHotels.where((hotel) => hotel.provinceId == 3).toList();

    return balkhHotels;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCEFEA),
      body: SafeArea(
        child: FutureBuilder<List<Hotel>>(
          future: _hotelsFuture,
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

            final hotels = snapshot.data!;

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
                        'Balkh',
                        style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Hotels', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ),

                const SizedBox(height: 16),

                // GridView to display hotels
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      itemCount: hotels.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final hotel = hotels[index];
                        return HotelCard(
                          name: hotel.name,
                          image: hotel.image,
                          description: 'Balkh, Afghanistan',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HotelScreenWidget(hotelId: hotel.id),
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
