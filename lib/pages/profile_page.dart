import 'package:flutter/material.dart';
import 'package:medicine_app/network/model/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';
import 'login_page.dart';

class ProfilePages extends StatefulWidget {
  @override
  _ProfilePagesState createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  String fullName, createdDate, phone, email, address;

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      fullName = sharedPreferences.getString(Profile.name);
      createdDate = sharedPreferences.getString(Profile.cretedAt);
      phone = sharedPreferences.getString(Profile.phone);
      email = sharedPreferences.getString(Profile.email);
      address = sharedPreferences.getString(Profile.address);
    });
  }

  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(Profile.idUSer);
    sharedPreferences.remove(Profile.name);
    sharedPreferences.remove(Profile.email);
    sharedPreferences.remove(Profile.phone);
    sharedPreferences.remove(Profile.address);
    sharedPreferences.remove(Profile.cretedAt);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPages()),
        (route) => false);
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
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Мой профиль",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                ),
                InkWell(
                  onTap: () {
                    signOut();
                  },
                  child: Icon(
                    Icons.exit_to_app,
                    color: greenColor,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: boldTextStyle.copyWith(fontSize: 18),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Присоединяйтесь к " + createdDate,
                  style: lightTextStyle,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: whiteColor,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Телефон",
                  style: lightTextStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  phone,
                  style: boldTextStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email адрес",
                  style: lightTextStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  email,
                  style: boldTextStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: whiteColor,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Адрес",
                  style: lightTextStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  address,
                  style: boldTextStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
