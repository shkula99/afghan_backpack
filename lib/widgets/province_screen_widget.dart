import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/province.dart';


class ProvinceScreen extends StatelessWidget {
  final int provinceId;
  final String? provinceName; // <-- make name optional
  ProvinceScreen({
    Key? key,
    required this.provinceId,
    this.provinceName, // <-- no longer required
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Province>(
      future: DBHelper().getProvinceById(provinceId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('Province not found.'));
        } else {
          final province = snapshot.data!;

          return Scaffold(
            appBar: AppBar(title: Text(province.name)),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(province.image),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(province.about),
                  ),
                  // Other fields: latitude, longitude, photos etc.
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
