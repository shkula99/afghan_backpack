
import 'package:flutter/material.dart';
import 'package:untitled1/screens/welcome_screen1.dart';

void main() {
  runApp(MaterialApp(
    home: Page1(),
    debugShowCheckedModeBanner: false,
  ));
}

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  Page1State createState() => Page1State();
}

class Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Color(0xFFB3E5FC),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          color: const Color(0xFFB3E5FC),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50, bottom: 15),
                height: 444,
                width: double.infinity,
                child: Image.asset(
                  'images/bag.png', // Make sure this path matches the one in pubspec.yaml
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 21),
                child: Text(
                  "Afghan Backpack",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Welcomescreen1()),
                  );
                },
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF0D6EFD),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}