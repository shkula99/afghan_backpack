import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/icons.dart';

class CityCard extends StatelessWidget {
  final String name;
  final String location;
  final String image;

  const CityCard({
    Key? key,
    required this.name,
    required this.location,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // restored original white background
      margin: const EdgeInsets.symmetric(vertical: 13), // original spacing
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4, // depth effect
      child: Padding(
        padding: const EdgeInsets.all(20), // increased padding
        child: Row(
          children: [
            // 9a. Rounded city image, now larger (120×120)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                image,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            // 9b. City name and location only (no stars)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // City name
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20, // slightly larger text
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Location row with icon
                  Row(
                    children: [
                      Icon(kLocationIcon, color: kLocationColor, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        location,
                        style:
                        TextStyle(fontSize: 16, color: kLocationColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}