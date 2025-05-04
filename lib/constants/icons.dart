import 'package:flutter/material.dart';


const kStarIcon = Icons.star;
const kStarHalfIcon = Icons.star_half;
const kProfileIcon = Icons.account_circle;
const kLocationIcon = Icons.location_on;


const Widget kListIcon = _ListIcon();

class _ListIcon extends StatelessWidget {
  const _ListIcon();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/icons/listIcon.webp',
      width: 24,
      height: 24,
      fit: BoxFit.contain,
    );
  }
}