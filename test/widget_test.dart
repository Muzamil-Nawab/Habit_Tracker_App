import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habits_tracker_app/bottom_navigation_bar/home_screen.dart';
import 'package:habits_tracker_app/main.dart';

void main() {
  testWidgets('App starts with splash screen for first time user', (WidgetTester tester) async {
    // Build our app and trigger a frame for first time user
    await tester.pumpWidget(MyApp(hasSeenOnboarding: false));

    // Verify that splash screen elements are present
    expect(find.text('Habits Tracker'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    
    // Verify the app icon is present
    expect(find.byIcon(Icons.track_changes), findsOneWidget);
  });

  testWidgets('Onboarding shows for first time users', (WidgetTester tester) async {
    // Build our app for first time user
    await tester.pumpWidget(MyApp(hasSeenOnboarding: false));

    // Wait for the splash screen delay and navigation
    await tester.pumpAndSettle(Duration(seconds: 3));

    // Since hasSeenOnboarding is false, onboarding should show
    expect(find.text('Track Your Habits'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('App goes directly to main screen for returning users', (WidgetTester tester) async {
    // Build our app for returning user who has seen onboarding
    await tester.pumpWidget(MyApp(hasSeenOnboarding: true));
    
    // Wait for navigation
    await tester.pumpAndSettle(Duration(seconds: 3));
    
    // Should go directly to main screen (assuming user is logged in for test)
    // This test might need adjustment based on your login logic
  });

  // Test HomeScreen widget in isolation
  testWidgets('HomeScreen displays greeting and habit cards', (WidgetTester tester) async {
    // Test your HomeScreen widget directly
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(), // Your existing HomeScreen widget
      ),
    );

    // Verify greeting is displayed
    expect(find.textContaining('Good'), findsOneWidget); // Good Morning/Afternoon/Evening/Night

    // Verify some habit cards are displayed
    expect(find.text('Reading Books'), findsOneWidget);
    expect(find.text('Daily Exercise'), findsOneWidget);
    expect(find.text('Drinking Water'), findsOneWidget);
    expect(find.text('Healthy Eating'), findsOneWidget);

    // Verify floating action button exists
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Floating action button navigates to new habits screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(),
      ),
    );

    // Find and tap the floating action button
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // This would verify navigation to NewHabitsScreen
    // You might need to adjust based on your navigation implementation
  });

  testWidgets('Header section displays correct stats', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(),
      ),
    );

    // Verify stats are displayed
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Total Habits'), findsOneWidget);
    expect(find.text('Streak'), findsOneWidget);

    // Verify the number of categories (should be 4 based on your code)
    expect(find.text('4'), findsOneWidget);
  });
}