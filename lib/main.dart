
import 'package:flutter/material.dart';
import 'constants/colors.dart';
import 'data/balkh/restaurants_data.dart';
import 'database/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'screens/splash_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Get database instance
//   final db = await DBHelper().database;
//
//   // Print database path
//   final dbPath = await getDatabasesPath();
//   print('✅ DB Path: $dbPath/afghan_backpack.db');
//
//   // Check if 'restaurants' table exists
//   final result = await db.rawQuery(
//       "SELECT name FROM sqlite_master WHERE type='table' AND name='restaurants';"
//   );
//
//   if (result.isNotEmpty) {
//     print('✅ Table "restaurants" exists!');
//   } else {
//     print('❌ Table "restaurants" does NOT exist!');
//   }
//
//   runApp(MyApp());
// }


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper().database;
  await DBHelper().insertRestaurants(restaurants);
  // await DBHelper().printAllRestaurants();
  //await deleteOldDatabase();
  runApp(MyApp());
}


Future<void> deleteOldDatabase() async {
  final dbPath = await getDatabasesPath();
  final path = '$dbPath/afghan_backpack.db';
  await deleteDatabase(path);
  print('Old database deleted!');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Afghan BackPack',
      theme: ThemeData(
        primaryColor: kBlueColor,
        scaffoldBackgroundColor: kLighterShadeForBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: kDarkBlueGreyColor,
          elevation: 4,
        ),
      ),
      home: const Splashscreen(),
    );
  }
}
