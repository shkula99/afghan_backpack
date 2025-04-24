import 'package:flutter/material.dart';
import '../../database/db_helper.dart';
import '../../models/restaurant.dart';
import '../../widgets/restaurant_detail_widget.dart';


class BalkhRestaurantDetailScreen extends StatefulWidget {
  final int restaurantId;

  const BalkhRestaurantDetailScreen({super.key, required this.restaurantId});

  @override
  State<BalkhRestaurantDetailScreen> createState() =>
      _BalkhRestaurantDetailScreenState();
}

class _BalkhRestaurantDetailScreenState
    extends State<BalkhRestaurantDetailScreen> {
  late Future<Restaurant> _restaurantFuture;

  @override
  void initState() {
    super.initState();
    _restaurantFuture = DBHelper().getRestaurantById(widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant>(
      future: _restaurantFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text('Restaurant not found')),
          );
        }

        final restaurant = snapshot.data!;
        return RestaurantDetailWidget(restaurant: restaurant);
      },
    );
  }
}
