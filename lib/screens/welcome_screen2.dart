
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'welcome_screen3.dart';

class Welcomescreen2 extends StatelessWidget {
  const Welcomescreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrightColorForBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Image.asset(
                    'images/screen_images/wl_screen2.jpg',
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
                          'Have the best time\nof exploring',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: kFontColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 8,
                              width: 20,
                              decoration: BoxDecoration(
                                color: kButtonBackgroundColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                color: kBoxDecoration1Color,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        // "Next" button
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to Page4 when "Next" is clicked
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Welcomescreen3()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kButtonBackgroundColor,
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
                              color: kTextColor,
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
            // Skip button
            // Skip button
            Positioned(
              top: 16,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Welcomescreen3(),
                    ),
                  );
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    color: kTextColor,
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
