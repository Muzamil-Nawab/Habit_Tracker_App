import 'package:flutter/material.dart';
import 'package:habits_tracker_app/constraint/contraints.dart';
import 'package:habits_tracker_app/login_screen/login_screen.dart';
import 'package:habits_tracker_app/register_screen/register_screen.dart';
import 'package:habits_tracker_app/widgets/button_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

/// list for image showing on onbourding screen //////
  final List<Map<String, String>> slides = [
    {
      'image': 'lib/assets/Healthy habit-bro.png',
      'title': 'Build Balanced Habits',
      'subtitle':
          'Track workouts, nutrition, hydration, and rest—all in one place.',
    },
    {
      'image': 'lib/assets/Indoor bike-bro.png',
      'title': 'Exercise Anywhere',
      'subtitle': 'Log cardio, strength, and stretches—right from home or gym.',
    },
    {
      'image': 'lib/assets/Market launch-bro.png',
      'title': 'Launch Your Potential',
      'subtitle':
          'Set goals, maintain streaks, and watch your progress skyrocket.',
    },
  ];

///  code for dots shoiwng on bottom the pics ////////
  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(slides.length, (index) {
        bool isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 12 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? AppStyle.primaryGreen : Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

/// function for next page ////
  void _nextPage() {
    if (_currentPage < slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to register screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  RegisterScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Color(0xFF0D1421), // Ensure background is white
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: slides.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final slide = slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Image.asset(
                            slide['image']!,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          slide['title']!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          slide['subtitle']!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),
            _buildDots(),
            const SizedBox(height: 32),

            // Button area - always visible
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: _currentPage == slides.length - 1
                    ? ButtonWidget(
                        text: "Get Started", // Fixed: proper button text
                        onPressed: _nextPage,
                        backgroundColor: AppStyle.primaryGreen,
                        textColor: Colors
                            .white, // Add text color if your ButtonWidget supports it
                      )
                    : ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppStyle.primaryGreen,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
