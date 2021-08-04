import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicine_app/network/api/url_api.dart';
import 'package:medicine_app/network/model/product_model.dart';
import 'package:medicine_app/widget/card_product.dart';
import 'package:medicine_app/widget/widget_ilustration.dart';
import 'package:http/http.dart' as http;
import '../theme.dart';
import 'detail_product.dart';

class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  TextEditingController searchController = TextEditingController();
  List<ProductModel> listProduct = [];
  List<ProductModel> listSearchProduct = [];

  getProduct() async {
    listProduct.clear();
    var urlProduct = Uri.parse(BASEURL.getProduct);
    final response = await http.get(urlProduct);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map product in data) {
          listProduct.add(ProductModel.fromJson(product));
        }
      });
    }
  }

  searchProduct(String text) {
    listSearchProduct.clear();
    if (text.isEmpty) {
      setState(() {});
    } else {
      listProduct.forEach((element) {
        if (element.nameProduct.toLowerCase().contains(text)) {
          listSearchProduct.add(element);
        }
      });
      setState(() {});
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  width: MediaQuery.of(context).size.width - 100,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffe4faf0)),
                  child: TextField(
                    onChanged: searchProduct,
                    controller: searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xffb1d8b2),
                        ),
                        hintText: "Поиск лекарств...",
                        hintStyle: regulerTextStyle.copyWith(
                            color: Color(0xffb0d8b2))),
                  ),
                ),
              ],
            ),
          ),
          searchController.text.isEmpty || listSearchProduct.length == 0
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
                  child: WidgetIlustration(
                    title: "Отсутствует лекарство, которое вы ищите",
                    image: "assets/no_data_ilustration.png",
                    subtitle1: "Найдите нужный продукт,",
                    subtitle2: "товар появится здесь",
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(24),
                  child: GridView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: listSearchProduct.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16),
                      itemBuilder: (context, i) {
                        final y = listSearchProduct[i];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailProduct(y)));
                          },
                          child: CardProduct(
                            nameProduct: y.nameProduct,
                            imageProduct: y.imageProduct,
                            price: y.price,
                          ),
                        );
                      }),
                ),
        ],
      )),
    );
  }
}
