import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_webapp/pages/home_page/home_page.dart';

import 'package:todo_webapp/services/firebase_services.dart';
import 'package:todo_webapp/utils/colors.dart';
import 'package:todo_webapp/widgets/signup_box.dart';

class LoginField extends StatefulWidget {
  const LoginField({super.key});

  @override
  State<LoginField> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseService _auth = FirebaseService();
  final _logKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 400,
        width: 350,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Form(
          key: _logKey,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Hello There!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 70,
                ),
                child: Container(
                  height: 38,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 249, 245),
                      border: Border.all(
                          color: const Color.fromARGB(218, 15, 15, 15)),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 10),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value != null) {
                          return "enter valid email";
                        }
                      },
                      cursorHeight: 16,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 11, 11, 11), fontSize: 13),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: " Enter Email",
                        hintStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 70,
                ),
                child: Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 241, 249, 245),
                    border: Border.all(
                        color: const Color.fromARGB(218, 15, 15, 15)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 10),
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value != null) {
                          return "enter valid Password";
                        }
                      },
                      cursorHeight: 16,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 11, 11, 11), fontSize: 13),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: " Enter Password",
                        hintStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  //
                  _signIn();
                  _emailController.clear();
                  _passwordController.clear();
                },
                child: Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: const Color.fromARGB(119, 34, 34, 34)),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const SignUp(),
                        ),
                      );
                    },
                    child: const Text(
                      "Create One",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 128, 115, 6)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _signIn() async {
    final userData = await _auth.loginWithEmailAndPassword(
        _emailController.text.trim(), _passwordController.text.trim());
    if (userData != null) {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const HomePage(),
        ),
      );
    }
  }
}
