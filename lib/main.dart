
import 'package:flutter/material.dart';
import 'constants/colors.dart';
import 'package:sqflite/sqflite.dart';
import 'screens/splash_screen.dart';



void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
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
