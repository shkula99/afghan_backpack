
import 'package:flutter/material.dart';

import 'home_page.dart';

class Welcomescreen3 extends StatelessWidget {
  const Welcomescreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF2EC),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Top image with rounded bottom corners
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Image.asset(
                    'images/wl_screen3.jpg',
                    height: MediaQuery.of(context).size.height * 0.52,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // Bottom section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Have a great trip',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Page indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 4),
                              width: 13,
                              height: 7,
                              decoration: BoxDecoration(
                                color: Color(0xFFCAE9FF),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 4),
                              width: 6,
                              height: 7,
                              decoration: BoxDecoration(
                                color: Color(0xFFCAE9FF),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            Container(
                              width: 35,
                              height: 7,
                              decoration: BoxDecoration(
                                color: Color(0xFF0D6EFD),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        // "Next" button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PopularCitiesPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D6EFD),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // "Skip" button
            Positioned(
              top: 16,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
