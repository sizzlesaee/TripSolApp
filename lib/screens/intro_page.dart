import 'package:flutter/material.dart';
import 'package:tripsol_clean/screens/login_screen.dart';
import 'package:lottie/lottie.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffade1f5), Color(0xffd0f0f8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08,
              vertical: screenHeight * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Section: Title + Tagline + Animation
                Column(
                  children: [
                    const SizedBox(height: 20),

                    Text(
                      "Trip Sol",
                      style: TextStyle(
                        fontSize: screenWidth * 0.2,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlaywriteUSModern',
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.public, color: Colors.blueAccent),
                        const SizedBox(width: 8),
                        Text(
                          "Dream. Plan. Explore",
                          style: TextStyle(
                            fontSize: screenWidth * 0.055,
                            fontFamily: "ArchitectsDaughter",
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Corrected: Lottie animation instead of image
                    Lottie.asset(
                      'assets/lottie/travel_animation.json',
                      height: screenHeight * 0.40,
                    ),
                  ],
                ),

                // Bottom Section: Get Started Button
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff007e74),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.2,
                        vertical: screenHeight * 0.02,
                      ),
                    ),
                    child: Text(
                      "GET STARTED",
                      style: TextStyle(
                        fontSize: screenWidth * 0.060,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
