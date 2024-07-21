// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_webapp/widgets/signin_box.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SignIn(),
      ),
    );
  }
}
