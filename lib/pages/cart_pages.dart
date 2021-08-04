import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_app/network/api/url_api.dart';
import 'package:medicine_app/network/model/cart_model.dart';
import 'package:medicine_app/network/model/profile_model.dart';
import 'package:medicine_app/pages/success_checkout.dart';
import 'package:medicine_app/widget/button_primary.dart';
import 'package:medicine_app/widget/widget_ilustration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main_page.dart';
import '../theme.dart';

class CartPages extends StatefulWidget {
  final VoidCallback method;

  CartPages(this.method);

  @override
  _CartPagesState createState() => _CartPagesState();
}

class _CartPagesState extends State<CartPages> {
  final price = NumberFormat("#,##0", "RU_RU");
  String userID, fullName, address, phone;
  int delivery = 0;

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(Profile.idUSer);
      fullName = sharedPreferences.getString(Profile.name);
      address = sharedPreferences.getString(Profile.address);
      phone = sharedPreferences.getString(Profile.phone);
    });
    getCart();
    cartTotalPrice();
  }

  List<CartModel> listCart = [];

  getCart() async {
    listCart.clear();
    var urlGetCart = Uri.parse(BASEURL.getProductCart + userID);
    final response = await http.get(urlGetCart);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          listCart.add(CartModel.fromJson(item));
        }
      });
    }
  }

  updateQuantity(String type, String model) async {
    var urlUpdateQuantity = Uri.parse(BASEURL.updateQuantityProductCart);
    final response = await http
        .post(urlUpdateQuantity, body: {"cartID": model, "type": type});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      print(message);
      setState(() {
        getPref();
        widget.method();
      });
    } else {
      print(message);
      setState(() {
        getPref();
      });
    }
  }

  checkout() async {
    var urlCheckout = Uri.parse(BASEURL.checkout);
    final response = await http.post(urlCheckout, body: {
      "idUser": userID,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SuccessCheckout()),
          (route) => false);
    } else {
      print(message);
    }
  }

  var sumPrice = "0";
  int totalPayment = 0;

  cartTotalPrice() async {
    var urlTotalPrice = Uri.parse(BASEURL.totalPriceCart + userID);
    final response = await http.get(urlTotalPrice);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String total = data['Total'];
      setState(() {
        sumPrice = total;
        totalPayment = sumPrice == null ? 0 : int.parse(sumPrice) + delivery;
      });
      print(sumPrice);
    }
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: listCart.length == 0
          ? SizedBox()
          : Container(
              padding: EdgeInsets.all(24),
              height: 220,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xfffcfcfc),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Все пункты",
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        "IDR " + price.format(int.parse(sumPrice)),
                        style: boldTextStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Плата за доставку",
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        delivery == 0 ? "БЕСПЛАТНО" : delivery,
                        style: boldTextStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Всего к оплате",
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        "IDR " + price.format(totalPayment),
                        style: boldTextStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonPrimary(
                      onTap: () {
                        checkout();
                      },
                      text: "ОПЛАТИТЬ",
                    ),
                  )
                ],
              ),
            ),
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.only(bottom: 220),
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              height: 70,
              child: Row(children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 32,
                    color: greenColor,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Корзина",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                )
              ])),
          listCart.length == 0 || listCart.length == null
              ? Container(
                  padding: EdgeInsets.all(24),
                  margin: EdgeInsets.only(top: 30),
                  child: WidgetIlustration(
                    image: "assets/empty_cart_ilustration.png",
                    title: "В вашей корзине нет продуктов",
                    subtitle1: "Ваша корзина все еще пуста",
                    subtitle2: "привлекательные продукты из MEDHEALTH",
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      width: MediaQuery.of(context).size.width,
                      child: ButtonPrimary(
                        text: "КУПИТЕ СЕЙЧАС",
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPages()),
                              (route) => false);
                        },
                      ),
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(24),
                  height: 166,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Место доставки",
                        style: regulerTextStyle.copyWith(fontSize: 18),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Имя",
                            style: regulerTextStyle.copyWith(
                                fontSize: 16, color: greyBoldColor),
                          ),
                          Text(
                            "$fullName",
                            style: boldTextStyle.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Адрес",
                            style: regulerTextStyle.copyWith(
                                fontSize: 16, color: greyBoldColor),
                          ),
                          Text(
                            "$address",
                            style: boldTextStyle.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Телефон",
                            style: regulerTextStyle.copyWith(
                                fontSize: 16, color: greyBoldColor),
                          ),
                          Text(
                            "$phone",
                            style: boldTextStyle.copyWith(fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
          ListView.builder(
              itemCount: listCart.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, i) {
                final x = listCart[i];
                return Container(
                  padding: EdgeInsets.all(24),
                  color: whiteColor,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            x.image,
                            width: 115,
                            height: 100,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  x.name,
                                  style:
                                      regulerTextStyle.copyWith(fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: greenColor,
                                        ),
                                        onPressed: () {
                                          updateQuantity("add", x.idCart);
                                        }),
                                    Text(x.quantity),
                                    IconButton(
                                        icon: Icon(
                                          Icons.remove_circle,
                                          color: Color(0xfff0997a),
                                        ),
                                        onPressed: () {
                                          updateQuantity("wanting", x.idCart);
                                        }),
                                  ],
                                ),
                                Text(
                                  "IDR " + price.format(int.parse(x.price)),
                                  style: boldTextStyle.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider()
                    ],
                  ),
                );
              })
        ],
      )),
    );
  }
}
