import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_app/network/api/url_api.dart';
import 'package:medicine_app/network/model/product_model.dart';
import 'package:medicine_app/network/model/profile_model.dart';
import 'package:medicine_app/widget/button_primary.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../main_page.dart';
import '../theme.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel productModel;

  DetailProduct(this.productModel);

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final priceFormat = NumberFormat("#,##0", "RU_RU");

  String userID;

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(Profile.idUSer);
    });
  }

  addToCart() async {
    var urlAddToCart = Uri.parse(BASEURL.addToCart);
    final response = await http.post(urlAddToCart, body: {
      "id_user": userID,
      "id_product": widget.productModel.idProduct,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Информация"),
                content: Text(message),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPages()),
                            (route) => false);
                      },
                      child: Text("Ок"))
                ],
              ));
      setState(() {});
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Информация"),
                content: Text(message),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Ок"))
                ],
              ));
      setState(() {});
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
      body: SafeArea(
        child: ListView(
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                height: 60,
                child: Row(children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_rounded,
                      size: 28,
                      color: greenColor,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Подробнее о продукте",
                    style: regulerTextStyle.copyWith(fontSize: 25),
                  )
                ])),
            SizedBox(
              height: 24,
            ),
            Container(
              height: 200,
              color: whiteColor,
              child: Image.network(widget.productModel.imageProduct),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productModel.nameProduct,
                    style: regulerTextStyle.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.productModel.description,
                    style: regulerTextStyle.copyWith(
                        fontSize: 14, color: greyBoldColor),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 64,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        "Rp " +
                            priceFormat
                                .format(int.parse(widget.productModel.price)),
                        style: boldTextStyle.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonPrimary(
                      onTap: () {
                        addToCart();
                      },
                      text: "ДОБАВИТЬ В КОРЗИНУ",
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
