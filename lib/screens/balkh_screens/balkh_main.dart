
import 'package:flutter/material.dart';
import '../../data/province_data.dart';
import '../../widgets/province_screen.dart';



class BalkhCityPage extends StatelessWidget {
  const BalkhCityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProvinceScreen(province: balkhProvince);
  }
}

