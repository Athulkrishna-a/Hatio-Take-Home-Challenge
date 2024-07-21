import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:todo_webapp/pages/auth/logup.dart';
import 'package:todo_webapp/utils/colors.dart';
import 'package:todo_webapp/widgets/logup_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileSign(),
      desktop: DesktopSign(),
    );
  }

  Widget DesktopSign() {
    return Scaffold(
      body: Container(
        color: AppColors.primaryColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.55,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 30,
                          top: 30,
                          left: 30,
                        ),
                        child: Image.asset(
                          "assets/images/signup.png",
                          height: 200,
                          width: 200,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 20,
                        ),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            "Welcome!",
                            style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 25,
                          left: 25,
                          top: 20,
                        ),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            "Welcome to our note-taking app! To get started, please log in or sign up to unlock all the amazing features and begin organizing your thoughts effortlessly. Happy note-taking",
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              wordSpacing: 3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                LogupField(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MobileSign() {
    return Scaffold(
      body: Container(
        color: AppColors.secondaryColor,
        child: LogupField(),
      ),
    );
  }
}
