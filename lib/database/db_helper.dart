import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/hotel.dart';
import '../models/hotel_photo.dart';
import '../models/park.dart';
import '../models/park_photo.dart';
import '../models/province.dart';
import '../models/province_photo.dart';
import '../models/restaurant.dart';
import '../models/restaurant_photo.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'afghan_backpack.db');

    // Print database path for debugging
    //print('Database path: $path');

    // Check if the database exists
    final exists = await databaseExists(path);

    if (!exists) {
      try {
        // Create the directory if necessary
        await Directory(dirname(path)).create(recursive: true);

        // Load the database from assets
        ByteData data = await rootBundle.load(
          'assets/database/afghan_backpack.db',
        );
        List<int> bytes = data.buffer.asUint8List(
          data.offsetInBytes,
          data.lengthInBytes,
        );

        // Write the database to the local storage
        await File(path).writeAsBytes(bytes, flush: true);
        print('Database copied successfully.');
      } catch (e) {
        print('Error copying database: $e');
      }
    }

    // Open the database (in read-write mode)
    final db = await openDatabase(path, readOnly: false);

    // Check if the 'provinces' table exists
    final tables = await db.rawQuery(
      'SELECT name FROM sqlite_master WHERE type="table"',
    );
    //print('Tables in database: $tables');

    return db;
  }

  // #region Province Queries

  // Fetch all provinces for the list
  Future<List<Province>> fetchProvinces() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('provinces');

    return List.generate(maps.length, (i) {
      return Province.fromMap(maps[i]);
    });
  }

  // Fetch a single province by ID when clicked
  Future<Province?> fetchProvinceById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'provinces',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return Province.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Fetch all photos of a province
  Future<List<ProvincePhoto>> fetchProvincePhotos(int provinceId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'provinces_photos',
      where: 'province_id = ?',
      whereArgs: [provinceId],
    );

    return List.generate(maps.length, (i) {
      return ProvincePhoto.fromMap(maps[i]);
    });
  }

  // Restaurant Part

  // Fetch all restaurants
  Future<List<Restaurant>> fetchRestaurants() async {
    final db = await database;

    // Load all restaurants
    final List<Map<String, dynamic>> restaurantMaps = await db.query(
      'restaurants',
    );

    // Load all restaurant photos
    final List<Map<String, dynamic>> photoMaps = await db.query(
      'restaurants_photos',
    );

    // Convert to RestaurantPhoto objects
    List<RestaurantPhoto> allPhotos =
        photoMaps.map((map) => RestaurantPhoto.fromMap(map)).toList();

    // Map each restaurant with its photos
    return restaurantMaps.map((restaurantMap) {
      final restaurantPhotos =
          allPhotos
              .where((photo) => photo.restaurantId == restaurantMap['id'])
              .toList();

      return Restaurant.fromMap(restaurantMap, restaurantPhotos);
    }).toList();
  }

  // Fetch a single restaurant by ID
  Future<Restaurant?> fetchRestaurantById(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> restaurantMaps = await db.query(
      'restaurants',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (restaurantMaps.isEmpty) return null;

    final List<Map<String, dynamic>> photoMaps = await db.query(
      'restaurants_photos',
      where: 'restaurant_id = ?',
      whereArgs: [id],
    );

    List<RestaurantPhoto> restaurantPhotos =
        photoMaps.map((map) => RestaurantPhoto.fromMap(map)).toList();

    return Restaurant.fromMap(restaurantMaps.first, restaurantPhotos);
  }

  // Fetch all photos of a specific restaurant
  Future<List<RestaurantPhoto>> fetchRestaurantPhotos(int restaurantId) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'restaurants_photos',
      where: 'restaurant_id = ?',
      whereArgs: [restaurantId],
    );

    return List.generate(maps.length, (i) {
      return RestaurantPhoto.fromMap(maps[i]);
    });
  }



// Hotel Part

  // Fetch all hotels
  Future<List<Hotel>> fetchHotels() async {
    final db = await database;

    // Load all hotels
    final List<Map<String, dynamic>> hotelMaps = await db.query(
      'hotels',
    );

    // Load all hotels photos
    final List<Map<String, dynamic>> photoMaps = await db.query(
      'hotels_photos',
    );

    // Convert to HotelPhoto objects
    List<HotelPhoto> allPhotos =
    photoMaps.map((map) => HotelPhoto.fromMap(map)).toList();

    // Map each hotel with its photos
    return hotelMaps.map((hotelMap) {
      final hotelPhotos =
      allPhotos
          .where((photo) => photo.hotelId == hotelMap['id'])
          .toList();

      return Hotel.fromMap(hotelMap, hotelPhotos);
    }).toList();
  }


  // Fetch a single hotel by ID
  Future<Hotel?> fetchHotelById(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> hotelMaps = await db.query(
      'hotels',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (hotelMaps.isEmpty) return null;

    final List<Map<String, dynamic>> photoMaps = await db.query(
      'hotels_photos',
      where: 'hotel_id = ?',
      whereArgs: [id],
    );

    List<HotelPhoto> hotelPhotos =
    photoMaps.map((map) => HotelPhoto.fromMap(map)).toList();

    return Hotel.fromMap(hotelMaps.first, hotelPhotos);
  }

  // Fetch all photos of a specific hotel
  Future<List<HotelPhoto>> fetchHotelPhotos(int hotelId) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'hotels_photos',
      where: 'hotel_id = ?',
      whereArgs: [hotelId],
    );

    return List.generate(maps.length, (i) {
      return HotelPhoto.fromMap(maps[i]);
    });
  }





  // Historical Places Part



// Parks Part
// Fetch all parks
  Future<List<Park>> fetchParks() async {
    final db = await database;

    // Load all parks
    final List<Map<String, dynamic>> parkMaps = await db.query(
      'parks',
    );

    // Load all parks photos
    final List<Map<String, dynamic>> photoMaps = await db.query(
      'parks_photos',
    );

    // Convert to ParkPhoto objects
    List<ParkPhoto> allPhotos =
    photoMaps.map((map) => ParkPhoto.fromMap(map)).toList();

    // Map each park with its photos
    return parkMaps.map((parkMap) {
      final parkPhotos =
      allPhotos
          .where((photo) => photo.parkId == parkMap['id'])
          .toList();

      return Park.fromMap(parkMap, parkPhotos);
    }).toList();
  }


  // Fetch a single park by ID
  Future<Park?> fetchParkById(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> parkMaps = await db.query(
      'parks',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (parkMaps.isEmpty) return null;

    final List<Map<String, dynamic>> photoMaps = await db.query(
      'parks_photos',
      where: 'park_id = ?',
      whereArgs: [id],
    );

    List<ParkPhoto> parkPhotos =
    photoMaps.map((map) => ParkPhoto.fromMap(map)).toList();

    return Park.fromMap(parkMaps.first, parkPhotos);
  }

  // Fetch all photos of a specific park
  Future<List<ParkPhoto>> fetchParkPhotos(int parkId) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'parks_photos',
      where: 'park_id = ?',
      whereArgs: [parkId],
    );

    return List.generate(maps.length, (i) {
      return ParkPhoto.fromMap(maps[i]);
    });
  }


}
