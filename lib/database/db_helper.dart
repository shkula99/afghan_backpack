import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class DBHelper {
  static Database? _db;

  // Singleton pattern to ensure only one database instance exists
  Future<Database> get database async {
    if (_db != null) return _db!;  // If database is already open, return it
    _db = await _initDB();  // Otherwise, initialize the database
    return _db!;
  }

  // Initialize the database
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();  // Get the default database path
    final path = join(dbPath, 'afghan_backpack.db');  // Name your database file here

    // Check if the database exists in the file system
    final exists = await databaseExists(path);

    if (!exists) {
      // If the database doesn't exist, copy it from assets
      try {
        await Directory(dirname(path)).create(recursive: true);  // Ensure directory exists

        // Load the database from assets
        ByteData data = await rootBundle.load('assets/database/afghan_backpack.db');  // Database path in assets
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        // Write the database to the correct file path
        await File(path).writeAsBytes(bytes, flush: true);
      } catch (e) {
        print('Error copying database: $e');  // Handle errors during database copy
      }
    }

    // Open the database after confirming the file exists
    return await openDatabase(path);
  }
}
