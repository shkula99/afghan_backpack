// import 'package:flutter/material.dart';
// import '../models/province.dart';
// import '../widgets/restaurant_card.dart';
//
// class RestaurantsScreen extends StatelessWidget {
//   final Province province;
//
//   const RestaurantsScreen({Key? key, required this.province}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Replace with your real restaurant list for this province
//     final restaurants = province.restaurants; // This should be a List<Restaurant>
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${province.name} Restaurants'),
//       ),
//       body: ListView.builder(
//         itemCount: restaurants.length,
//         itemBuilder: (context, index) {
//           return RestaurantCard(restaurant: restaurants[index]);
//         },
//       ),
//     );
//   }
// }
