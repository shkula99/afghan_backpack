import 'package:flutter/material.dart';
import 'package:untitled1/data/balkh/restaurants_data.dart';

class RestaurantCard extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final VoidCallback onTap;

  const RestaurantCard({
    required this.name,
    required this.image,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Makes the whole card tappable
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              child: Image.asset(
                image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 20, color: Colors.grey),
                      SizedBox(width: 4,),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ]
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
