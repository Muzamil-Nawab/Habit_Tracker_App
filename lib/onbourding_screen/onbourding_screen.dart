import 'package:flutter/material.dart';
import 'package:habits_tracker_app/constraint/contraints.dart';
import 'package:habits_tracker_app/Auth/login_screen.dart';
import 'package:habits_tracker_app/Auth/register_screen.dart';
import 'package:habits_tracker_app/widgets/button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart'; //  New import

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
      'image': 'assets/Healthy habit-bro.png',
      'title': 'Build Balanced Habits',
      'subtitle':
          'Track workouts, nutrition, hydration, and rest—all in one place.',
    },
    {
      'image': 'assets/Indoor bike-bro.png',
      'title': 'Exercise Anywhere',
      'subtitle': 'Log cardio, strength, and stretches—right from home or gym.',
    },
    {
      'image': 'assets/Market launch-bro.png',
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

  /// Function to handle completing onboarding (Skip or Get Started)
  Future<void> _completeOnboarding(Widget nextScreen) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true); //  Set the flag to true
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
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
      // Navigate to register screen after onboarding is complete
      _completeOnboarding(const RegisterScreen()); //  Use the new function
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
                    // Navigate to login screen after skipping onboarding
                    _completeOnboarding(const LoginScreen()); //  Use the new function
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
                        text: "Get Started",
                        onPressed: _nextPage, // This will call _completeOnboarding
                        backgroundColor: AppStyle.primaryGreen,
                        textColor: Colors.white,
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