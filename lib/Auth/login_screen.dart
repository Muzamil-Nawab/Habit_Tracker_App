import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habits_tracker_app/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:habits_tracker_app/constraint/contraints.dart';
import 'package:habits_tracker_app/Auth/register_screen.dart';
import 'package:habits_tracker_app/widgets/button_widget.dart';
import 'package:habits_tracker_app/widgets/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); //  Form key
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool loading = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF0D1421),
      appBar: AppBar(
        backgroundColor: Color(0xFF1F2442),
        
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                /// top part
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text("Login", style: AppStyle.logintext),
                ),
                SizedBox(height: 30),
            
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
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot password",
                        style: AppStyle.forgotpassword,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
            
                /// bottom part
                Column(
                  children: [
                    ButtonWidget(
                      loading: loading,
                      text: "Login",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          
                          auth
                              .signInWithEmailAndPassword(
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
                                    builder: (context) => BottomNavigationBarScreen(),
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
                    SizedBox(height: 40),
                    Text("Don't have an account?", style: AppStyle.donthavean),
                    SizedBox(height: 4),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text("Register", style: AppStyle.register),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
