import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
      await db.insert(
        'restaurants',
        restaurant,
        conflictAlgorithm: ConflictAlgorithm.ignore, // avoids overwriting
      );
    }
  }

  Future<void> printAllRestaurants() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('restaurants');

    for (var row in maps) {
      print(row);
    }
  }

}

