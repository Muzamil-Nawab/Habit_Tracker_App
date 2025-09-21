import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habits_tracker_app/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:habits_tracker_app/constraint/contraints.dart';
import 'package:habits_tracker_app/Auth/login_screen.dart';
//import 'package:habits_tracker_app/utils/utilis.dart';
import 'package:habits_tracker_app/widgets/button_widget.dart';
import 'package:habits_tracker_app/widgets/my_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

final _formKey = GlobalKey<FormState>(); // ✅ Form key
final _nameController = TextEditingController();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _confirmPasswordController = TextEditingController();
bool loading = false;

FirebaseAuth auth = FirebaseAuth.instance;

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /// top part
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text("Register", style: AppStyle.registertext),
                  ),
                  SizedBox(height: 30),
                  MyTextField(
                    hintText: "Name",
                    obscureText: false,
                    controller: _nameController,
                    icon: Icons.person_2_outlined,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 15),
                  MyTextField(
                    hintText: "Email",
                    obscureText: false,
                    controller: _emailController,
                    icon: Icons.email_outlined,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  MyTextField(
                    hintText: "Password",
                    obscureText: true,
                    controller: _passwordController,
                    icon: Icons.lock_outline,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  MyTextField(
                    hintText: "Confirm Password",
                    obscureText: true,
                    controller: _confirmPasswordController,
                    icon: Icons.lock_outline,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your confirm password";
                      }
                      if (value != _passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  /// bottom part
                  Column(
                    children: [
                      ButtonWidget(
                        loading: loading,
                        text: "Register",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            
                            auth
                                .createUserWithEmailAndPassword(
                                  email: _emailController.text.toString(),
                                  password: _passwordController.text.toString(),
                                )
                                .then((value) {
                                  setState(() {
                                    loading = false;
                                  });
                                  Navigator.pushReplacement(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavigationBarScreen(),
                                    ),
                                  );
                                })
                                .onError((error, stackTrace) {
                                  setState(() {
                                    loading = false;
                                  });
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(error.toString()),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                });
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Already have an account?",
                        style: AppStyle.alreadyhave,
                      ),
                      SizedBox(height: 4),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text("Login", style: AppStyle.login),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
