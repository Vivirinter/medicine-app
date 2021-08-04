import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicine_app/network/api/url_api.dart';
import 'package:medicine_app/network/model/history_model.dart';
import 'package:medicine_app/network/model/profile_model.dart';
import 'package:medicine_app/widget/card_history.dart';
import 'package:medicine_app/widget/widget_ilustration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../theme.dart';

class HistoryPages extends StatefulWidget {
  @override
  _HistoryPagesState createState() => _HistoryPagesState();
}

class _HistoryPagesState extends State<HistoryPages> {
  List<HistoryOrdelModel> list = [];
  String userID;

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(Profile.idUSer);
    });
    getHistory();
  }

  getHistory() async {
    list.clear();
    var urlHistory = Uri.parse(BASEURL.historyOrder + userID);
    final response = await http.get(urlHistory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          list.add(HistoryOrdelModel.fromJson(item));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              height: 70,
              child: Text(
                "История заказа",
                style: regulerTextStyle.copyWith(fontSize: 25),
              )),
          SizedBox(
            height: (list.length == 0) ? 80 : 20,
          ),
          list.length == 0
              ? Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: WidgetIlustration(
                      image: "assets/no_history_ilustration.png",
                      subtitle1: "Отсутвует история заказов",
                      subtitle2: "Сделайте покупки сейчас!",
                      title: "Нет истории заказов",
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final x = list[i];
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      child: CardHistory(
                        model: x,
                      ),
                    );
                  }),
        ]),
      ),
    );
  }
}
