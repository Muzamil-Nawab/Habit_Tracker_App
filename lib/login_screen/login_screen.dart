import 'package:flutter/material.dart';
import 'package:habits_tracker_app/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:habits_tracker_app/constraint/contraints.dart';
import 'package:habits_tracker_app/onbourding_screen/onbourding_screen.dart';
import 'package:habits_tracker_app/register_screen/register_screen.dart';
import 'package:habits_tracker_app/widgets/button_widget.dart';
import 'package:habits_tracker_app/widgets/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// here is code for  Top Part ////////
  Widget buildTopPart() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Text("Login", style: AppStyle.logintext),
        ),
        SizedBox(height: 30),

        MyTextField(hintText: "Email", obscureText: false),
        SizedBox(height: 15),

        MyTextField(hintText: "Password", obscureText: true),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {},
              child: Text("Forgot password", style: AppStyle.forgotpassword),
            ),
          ],
        ),
      ],
    );
  }

  ////// code for bottom part ////////

  Widget buildBottomPart() {
    return Column(
      children: [
        ButtonWidget(
          text: "Login",
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavigationBarScreen(),
              ),
            );
          },
        ),
        SizedBox(height: 40),
        Text("Don't have an account?", style: AppStyle.donthavean),
        SizedBox(height: 4),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
          },
          child: Text("Register", style: AppStyle.register),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF0D1421),
      appBar: AppBar(
        backgroundColor: Color(0xFF1F2442),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingScreen()),
            );
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            children: [
              /// top part
              buildTopPart(),
              SizedBox(height: 40),

              /// bottom part
              buildBottomPart(),
            ],
          ),
        ),
      ),
    );
  }
}
