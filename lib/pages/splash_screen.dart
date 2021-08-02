import 'package:flutter/material.dart';
import 'package:medicine_app/pages/register_page.dart';
import 'package:medicine_app/widget/button_primary.dart';
import 'package:medicine_app/widget/general_logo_space.dart';
import 'package:medicine_app/widget/widget_ilustration.dart';

class SplashScreen extends StatelessWidget {
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
              subtitle2: "В любое удобное для вас время",
              child: ButtonPrimary(
                text: "НАЧАТЬ",
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => RegisterPages()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
