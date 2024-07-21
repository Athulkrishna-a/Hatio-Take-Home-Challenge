import 'package:flutter/material.dart';
import 'package:todo_webapp/utils/contants.dart';
import 'package:todo_webapp/widgets/project_box.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return const Scaffold(
      body: ProjectBox(),
    );
  }
}
