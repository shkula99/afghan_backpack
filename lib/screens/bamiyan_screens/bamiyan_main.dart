
import 'package:flutter/material.dart';
import '../../data/province_data.dart';
import '../../widgets/province_screen.dart';



class BamiyanCityPage extends StatelessWidget {
  const BamiyanCityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProvinceScreen(province: bamiyanProvince);
  }
}

