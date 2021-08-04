import 'package:flutter/material.dart';
import 'package:medicine_app/widget/button_primary.dart';
import 'package:medicine_app/widget/general_logo_space.dart';
import 'package:medicine_app/widget/widget_ilustration.dart';

import '../main_page.dart';

class SuccessCheckout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GeneralLogoSpace(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(24),
        children: [
          SizedBox(
            height: 80,
          ),
          WidgetIlustration(
            image: "assets/order_success_ilustration.png",
            title: "Заказ успешно оформлен",
            subtitle1: "Проконсультируйтесь с врачом,",
            subtitle2: "В удобное для вас время!",
          ),
          SizedBox(
            height: 30,
          ),
          ButtonPrimary(
            text: "ВЕРНИТЕСЬ НА ГЛАВНУЮ",
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainPages()),
                  (route) => false);
            },
          )
        ],
      ),
    ));
  }
}
