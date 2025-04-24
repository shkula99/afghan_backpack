import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/restaurant.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'afghan_backpack.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE restaurants (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        image TEXT NOT NULL,
        description TEXT,
        latitude REAL,
        longitude REAL,
        phone TEXT,
        email TEXT,
        website TEXT,
        facebook TEXT,
        instagram TEXT,
        province TEXT NOT NULL,
        photos TEXT
      )
    ''');
  }


  Future<void> insertRestaurants(List<Map<String, dynamic>> restaurants) async {
    final db = await database; // get the database instance

    for (var restaurant in restaurants) {
      // Check if the restaurant already exists based on a unique field (e.g., id or name)
      final existingRestaurant = await db.query(
        'restaurants',
        where: 'name = ?', // Assuming 'name' is a unique field
        whereArgs: [restaurant['name']],
      );

      // If the restaurant doesn't exist, insert it
      if (existingRestaurant.isEmpty) {
        await db.insert(
          'restaurants',
          restaurant,
          conflictAlgorithm: ConflictAlgorithm.ignore, // avoids overwriting
        );
      } else {
        print("Restaurant '${restaurant['name']}' already exists in the database.");
      }
    }
  }


  Future<void> printAllRestaurants() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('restaurants');

    for (var row in maps) {
      print(row);
    }
  }

  Future<Restaurant> getRestaurantById(int id) async {
    final db = await database;
    final result = await db.query(
      'restaurants',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Restaurant.fromMap(result.first);
    } else {
      throw Exception('Restaurant not found');
    }
  }

}

