// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_webapp/widgets/signup_box.dart';

class LogUp extends StatefulWidget {
  const LogUp({super.key});

  @override
  State<LogUp> createState() => _LogUpState();
}

class _LogUpState extends State<LogUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SignUp(),
      ),
    );
  }
}
