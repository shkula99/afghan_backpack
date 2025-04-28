
import 'package:flutter/material.dart';
import '../../data/province_data.dart';
import '../../widgets/province_screen_widget.dart';



class BamiyanCityPage extends StatelessWidget {
  const BamiyanCityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProvinceScreen(provinceId: 4, provinceName: 'Bamiyan',);
  }
}

