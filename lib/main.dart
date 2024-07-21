import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo_webapp/auth/env.dart';
import 'package:todo_webapp/pages/home_page/home_page.dart';
import 'package:todo_webapp/utils/colors.dart';
import 'package:todo_webapp/widgets/signin_box.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: Env.firebaseApiKey,
    authDomain: Env.firebaseAuthDomain,
    projectId: Env.firebaseProjectId,
    storageBucket: Env.firebaseStorageBucket,
    messagingSenderId: Env.firebaseMessagingSenderId,
    appId: Env.firebaseAppId,
    measurementId: Env.firebaseMeasurementId,
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
