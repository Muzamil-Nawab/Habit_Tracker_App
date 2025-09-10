import 'package:flutter/material.dart';
import 'package:habits_tracker_app/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:habits_tracker_app/constraint/contraints.dart';
import 'package:habits_tracker_app/login_screen/login_screen.dart';
import 'package:habits_tracker_app/widgets/button_widget.dart';
import 'package:habits_tracker_app/widgets/my_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ////    code for top part
  Widget buildTopPart() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text("Register", style: AppStyle.registertext),
        ),
        SizedBox(height: 30),
        MyTextField(hintText: "Name", obscureText: false, ),
        SizedBox(height: 15),
        MyTextField(hintText: "Email", obscureText: false),
        SizedBox(height: 15),
        MyTextField(hintText: "Password", obscureText: true),
        SizedBox(height: 15),
        MyTextField(hintText: "Confirm Password", obscureText: false),
      ],
    );
  }

  ////    code for bottom part
  Widget buildBottomPart() {
    return Column(
      children: [
        ButtonWidget(text: "Register", onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavigationBarScreen()),
            );
        }),
        SizedBox(height: 20),
        Text("Already have an account?", style: AppStyle.alreadyhave),
        SizedBox(height: 4),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: Text("Login", style: AppStyle.login),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF0D1421),
      appBar: AppBar(
        backgroundColor: Color(0xFF1F2442),

        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
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
              SizedBox(height: 30),

              /// bottom part
              buildBottomPart(),
            ],
          ),
        ),
      ),
    );
  }
}
