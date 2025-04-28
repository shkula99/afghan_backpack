import 'package:flutter/material.dart';
import '../../database/db_helper.dart';
import '../../models/restaurant.dart';
import '../../widgets/restaurant_detail_widget.dart';

class BalkhRestaurantDetailScreen extends StatefulWidget {
  final int restaurantId;

  const BalkhRestaurantDetailScreen({super.key, required this.restaurantId});

  @override
  State<BalkhRestaurantDetailScreen> createState() => _BalkhRestaurantDetailScreenState();
}

class _BalkhRestaurantDetailScreenState extends State<BalkhRestaurantDetailScreen> {
  late Future<Restaurant?> _restaurantFuture; // <-- nullable type

  @override
  void initState() {
    super.initState();
    _restaurantFuture = _fetchRestaurant();
  }

  Future<Restaurant?> _fetchRestaurant() async {
    final db = await DBHelper.database;
    final result = await db.query(
      'restaurants',
      where: 'id = ?',
      whereArgs: [widget.restaurantId],
    );

    if (result.isNotEmpty) {
      return Restaurant.fromMap(result.first);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant?>(
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
        } else if (!snapshot.hasData || snapshot.data == null) {
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
