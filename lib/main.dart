import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_webapp/pages/home_page/home_page.dart';
import 'package:todo_webapp/utils/colors.dart';

import 'package:todo_webapp/widgets/signin_box.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyA6ozmEEF_44FbXe_XI7zgPniWVlryz_4A",
    projectId: "todonote-10b28",
    messagingSenderId: "873762091935",
    appId: "1:873762091935:web:560febd6f13e5011bd43aa",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TOTask',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          fontFamily: 'OriginalSurfer',
          useMaterial3: true,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomePage();
              } else {
                return const SignIn();
              }
            }));
  }
}
