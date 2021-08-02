import 'package:flutter/material.dart';
import 'package:medicine_app/theme.dart';
import 'package:medicine_app/widget/button_primary.dart';
import 'package:medicine_app/widget/general_logo_space.dart';

class RegisterPages extends StatefulWidget {
  @override
  _RegisterPagesState createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
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
            Container(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "РЕГИСТРАЦИЯ",
                    style: regulerTextStyle.copyWith(fontSize: 25),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Зарегистрируйте новую учетную запись",
                    style: regulerTextStyle.copyWith(
                        fontSize: 15, color: greyLightColor),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x40000000),
                              offset: Offset(0, 1),
                              blurRadius: 4,
                              spreadRadius: 0)
                        ],
                        color: whiteColor),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Полное Имя",
                          hintStyle: lightTextStyle.copyWith(
                              fontSize: 15, color: greyLightColor)),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x40000000),
                              offset: Offset(0, 1),
                              blurRadius: 4,
                              spreadRadius: 0)
                        ],
                        color: whiteColor),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email адрес",
                          hintStyle: lightTextStyle.copyWith(
                              fontSize: 15, color: greyLightColor)),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x40000000),
                              offset: Offset(0, 1),
                              blurRadius: 4,
                              spreadRadius: 0)
                        ],
                        color: whiteColor),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Телефон",
                          hintStyle: lightTextStyle.copyWith(
                              fontSize: 15, color: greyLightColor)),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x40000000),
                              offset: Offset(0, 1),
                              blurRadius: 4,
                              spreadRadius: 0)
                        ],
                        color: whiteColor),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Домашний адрес",
                          hintStyle: lightTextStyle.copyWith(
                              fontSize: 15, color: greyLightColor)),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x40000000),
                              offset: Offset(0, 1),
                              blurRadius: 4,
                              spreadRadius: 0)
                        ],
                        color: whiteColor),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      obscureText: _secureText,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: showHide,
                            icon: _secureText
                                ? Icon(
                                    Icons.visibility_off,
                                    size: 20,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    size: 20,
                                  ),
                          ),
                          border: InputBorder.none,
                          hintText: "Пароль",
                          hintStyle: lightTextStyle.copyWith(
                              fontSize: 15, color: greyLightColor)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonPrimary(
                      text: "РЕГИСТРАЦИЯ",
                      onTap: () {},
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Уже есть аккаунт?",
                        style: lightTextStyle.copyWith(
                            color: greyLightColor, fontSize: 15),
                      ),
                      Text(
                        "Войти сейчас",
                        style: boldTextStyle.copyWith(
                            color: greenColor, fontSize: 15),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
