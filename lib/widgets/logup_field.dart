import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_webapp/services/firebase_services.dart';
import 'package:todo_webapp/utils/colors.dart';
import 'package:todo_webapp/widgets/signin_box.dart';

class LogupField extends StatefulWidget {
  const LogupField({super.key});

  @override
  State<LogupField> createState() => _LogupFieldState();
}

class _LogupFieldState extends State<LogupField> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  final FirebaseService _auth = FirebaseService();
  final _signupKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
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
          key: _signupKey,
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
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Center(
                  child: Text(
                    "Welcome aboard!, We've been waiting for you!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
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
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter User Name";
                        }
                      },
                      cursorHeight: 16,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 11, 11, 11), fontSize: 13),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: " Enter User Name",
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
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email Adress";
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
                  if (_signupKey.currentState!.validate()) {
                    _signUp();
                    _emailController.clear();
                    _passwordController.clear();
                    _nameController.clear();
                  }
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
                      "Sign Up",
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
                          child: const SignIn(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign In",
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

  // ignore: unused_element
  _signUp() async {
    final userData = await _auth.registerWithEmailAndPassword(
        _emailController.text.trim(), _passwordController.text.trim());
    if (userData != null) {
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const SignIn(),
        ),
      );
    }
  }
}
