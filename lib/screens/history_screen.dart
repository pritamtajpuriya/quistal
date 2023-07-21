import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/AllText.dart';
import 'package:singleclinic/order/order_screen.dart';
import 'package:singleclinic/screens/AppointmentScreen.dart';
import 'package:singleclinic/screens/LoginScreen.dart';
import 'package:singleclinic/screens/SubcriptionList.dart';
import 'package:singleclinic/screens/UpdateProfileScreen.dart';
import '../main.dart';

//The original settings screen has not been modified, this is a new screen.
class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String path = "";
  final picker = ImagePicker();
  String imageUrl;
  String name, email;
  // List<OptionsList> list = [];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        imageUrl = value.getString("profile_pic");
        name = value.getString("name");
        email = value.getString("phone_no");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LIGHT_GREY_SCREEN_BG,
        appBar: AppBar(
          flexibleSpace: header(),
          backgroundColor: WHITE,
        ),
        body: body(),
      ),
    );
  }

  header() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  HISTORY,
                  style: TextStyle(
                      color: BLACK, fontSize: 22, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  body() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [profileCard(), options()],
        ),
      ),
    );
  }

  profileCard() {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        if (name == null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: Container(
                      height: 110,
                      width: 110,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: imageUrl ?? " ",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Container(
                                child: Center(
                                    child: Icon(
                          Icons.account_circle,
                          size: 110,
                          color: LIGHT_GREY_TEXT,
                        ))),
                        errorWidget: (context, url, error) => Container(
                          child: Center(
                            child: Icon(
                              Icons.account_circle,
                              size: 110,
                              color: LIGHT_GREY_TEXT,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 110,
                    width: 110,
                    child: InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () async {
                            bool check = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateProfileScreen()));
                            if (check) {
                              await SharedPreferences.getInstance()
                                  .then((value) {
                                setState(() {
                                  imageUrl = value.getString("profile_pic");
                                  name = value.getString("name");
                                });
                              });
                            }
                          },
                          child: name != null
                              ? Image.asset(
                                  "assets/loginregister/edit.png",
                                  height: 35,
                                  width: 35,
                                  fit: BoxFit.fill,
                                )
                              : Container(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name != null ? name.toUpperCase() : "Sign In",
                    style: TextStyle(
                        color: NAVY_BLUE,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  name == null
                      ? Container()
                      : Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              color: LIGHT_GREY_TEXT,
                              size: 12,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              email,
                              style: TextStyle(
                                  color: LIGHT_GREY_TEXT,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                  name == null
                      ? Container()
                      : SizedBox(
                          height: 8,
                        ),
                  InkWell(
                    onTap: () {
                      messageDialog(ALERT, ARE_YOU_SURE_TO_LOG_OUT);
                    },
                    child: Text(
                      name == null ? PROFILE : LOG_OUT,
                      style: TextStyle(
                          color: name == null ? LIGHT_GREY_TEXT : BLACK,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          decoration: name == null
                              ? TextDecoration.none
                              : TextDecoration.underline),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: LIGHT_GREY_TEXT,
            thickness: 1,
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  options() {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text(
                "My Subscriptions",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (c) => SubcriptionList()))),
          SizedBox(
            height: 30,
          ),
          ListTile(
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text(
                "My Appointments",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (c) => AppointmentScreen()))),
          SizedBox(
            height: 30,
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text(
              "My Orders",
              style: TextStyle(fontSize: 20),
            ),
            // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c)=>SubcriptionList()))
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderScreen(),
                  ));
            },
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        setState(() {
          path = File(pickedFile.path).path;
        });
      } else {
        print('No image selected.');
      }
    });
  }

  messageDialog(String s1, String s2) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              s1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s2,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await SharedPreferences.getInstance().then((value) {
                    value.clear();
                  });
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                style: TextButton.styleFrom(backgroundColor: LIME),
                child: Text(
                  YES,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: WHITE,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
