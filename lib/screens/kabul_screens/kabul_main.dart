
import 'package:flutter/material.dart';
import '../../data/province_data.dart';
import '../../widgets/province_screen_widget.dart';



class KabulCityPage extends StatelessWidget {
  const KabulCityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProvinceScreen(provinceId: 1, provinceName: 'Kabul',);
  }
}

