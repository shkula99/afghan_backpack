// import 'package:flutter/material.dart';
// import '../../data/province_data.dart';
// import 'herat_hotels.dart';
// import 'herat_restaraunts.dart';
//
// class HeratCityPage extends StatelessWidget {
//   const HeratCityPage({Key? key}) : super(key: key);
//
//   static Widget categoryIcon(String assetPath, String label) {
//     return Column(
//       children: [
//         CircleAvatar(
//           backgroundColor: Colors.white,
//           radius: 30,
//           backgroundImage: AssetImage(assetPath),
//         ),
//         const SizedBox(height: 6),
//         Text(label, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final province = heratProvince;
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFFEEFEF),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(32),
//                     bottomRight: Radius.circular(32),
//                   ),
//                   child: SizedBox(
//                     height: 340,
//                     width: double.infinity,
//                     child: Image.asset(province.image, fit: BoxFit.cover),
//                   ),
//                 ),
//                 Positioned(
//                   top: 24,
//                   left: 16,
//                   child: GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: const Icon(Icons.arrow_back),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(24),
//                     topRight: Radius.circular(24),
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           const Icon(Icons.wb_sunny, color: Colors.amber, size: 28),
//                           const SizedBox(width: 8),
//                           Text(province.temperature, style: const TextStyle(fontSize: 18, color: Colors.black)),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           const Icon(Icons.location_on, color: Colors.orange),
//                           const SizedBox(width: 8),
//                           Text(
//                             province.name,
//                             style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Updated TabBar with only About and Photo tabs
//                       DefaultTabController(
//                         length: 3, // Reduced from 4 to 3
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const TabBar(
//                               labelColor: Colors.black,
//                               indicatorColor: Colors.deepOrange,
//                               tabs: [
//                                 Tab(text: 'About'),
//                                 Tab(text: 'Photo'),
//                                 Tab(text: 'Description'), // We add description here instead of review/video
//                               ],
//                             ),
//                             SizedBox(
//                               height: 100,
//                               child: TabBarView(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 12),
//                                     child: Text(province.about), // About Tab
//                                   ),
//                                   const Center(child: Text('Photos related to Herat.')), // Photo Tab
//                                   const Center(child: Text('Description of Herat')), // Description Tab
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//
//                       const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 8),
//                       Text(province.description), // Show the province description
//                       const SizedBox(height: 24),
//
//                       const Text('Explore', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 12),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           categoryIcon('images/icons/historical_place.jpg', 'Historical Places'),
//                           categoryIcon('images/icons/park.jpg', 'Parks'),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context) => HeratRestaurantsScreen()));
//                             },
//                             child: categoryIcon('images/icons/restaurant.jpg', 'Restaurants'),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context) => HeratHotelsScreen()));
//                             },
//                             child: categoryIcon('images/icons/hotel.jpg', 'Hotels'),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../data/province_data.dart';
import '../../widgets/province_screen_widget.dart';



class HeratCityPage extends StatelessWidget {
  const HeratCityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProvinceScreen(provinceId: 2, provinceName: 'Herat');
  }
}


