import 'package:flutter/material.dart';
import 'package:medicine_app/network/model/profile_model.dart';
import 'package:medicine_app/widget/button_primary.dart';
import 'package:medicine_app/widget/general_logo_space.dart';
import 'package:medicine_app/widget/widget_ilustration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main_page.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userID;

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(Profile.idUSer);
      userID == null ? sessionLogout() : sessionLogin();
    });
  }

  sessionLogout() {}

  sessionLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainPages()));
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeneralLogoSpace(
        child: Column(
          children: [
            SizedBox(
              height: 45,
            ),
            WidgetIlustration(
              image: "assets/splash_ilustration.png",
              title: "Найдите свое медицинское\nрешение",
              subtitle1: "Проконсультируйтесь с врачом",
              subtitle2: "В удобное для вас время!",
              child: ButtonPrimary(
                text: "НАЧАТЬ",
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPages()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
