import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/screens/ForgetPassword.dart';
import 'package:singleclinic/screens/SignUpScreen.dart';
import 'package:singleclinic/screens/doctor_clinic/doctor_dashboard_screen/doctor_dashboard_screen.dart';
import 'package:singleclinic/screens/home/HomeScreen.dart';
import 'package:singleclinic/services/AuthService.dart';
import '../AllText.dart';
import '../main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String name;
  String email;
  String password;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String image = "";

  logininfo() async {
    var prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn');
    print('Value from SharedPreferences: $isLoggedIn');
    final name = prefs.getString('name');
    print('Value from SharedPreferences: $name');
  }

  @override
  void initState() {
    logininfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: WHITE,
          body: body(),
          // resizeToAvoidBottomInset: false,
        ),
      ),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Container(
        // height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset("assets/logo.png"),
              SizedBox(
                height: 130,
              ),
              Text(
                LOGIN,
                style: TextStyle(
                    color: NAVY_BLUE,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                EMAIL_ADDRESS,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    onSaved: (val) => email = val,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[400],
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400])),
                    ),
                    keyboardType: TextInputType.name,
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                onSaved: (val) => password = val,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[400],
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400])),
                ),
                keyboardType: TextInputType.name,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPassword()));
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    FORGET_PASSWORD,
                    style: TextStyle(
                        color: NAVY_BLUE,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (email == '' || password == '') {
                          final snackBar = SnackBar(
                            content: Text('Field empty.'),
                            backgroundColor: Colors.teal,
                            behavior: SnackBarBehavior.floating,
                            action: SnackBarAction(
                              label: 'Dismiss',
                              disabledTextColor: Colors.white,
                              textColor: Colors.yellow,
                              onPressed: () {
                                //Do whatever you want
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          loginIntoAccount(1);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: LIME,
                        ),
                        child: Center(
                          child: Text(
                            LOGIN,
                            style: TextStyle(
                                color: WHITE,
                                fontWeight: FontWeight.w700,
                                fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: LIGHT_GREY_TEXT, fontSize: 12),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text(
                      REGISTER,
                      style: TextStyle(
                          color: NAVY_BLUE,
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: Text(
                      'Continue as Guest',
                      style: TextStyle(
                          color: NAVY_BLUE,
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Platform.isIOS
                  ? Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: NAVY_BLUE.withOpacity(0.7),
                            ),
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Image.asset(
                                        "assets/loginregister/appleid.png",
                                      ),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Text(
                                    CONTINUE_WITH_APPLE_ID,
                                    style: TextStyle(
                                        color: WHITE,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  errorDialog(message) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.error,
                  size: 80,
                  color: Colors.red,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  message.toString(),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  processingDialog(message) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(LOADING),
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 2,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(color: LIGHT_GREY_TEXT, fontSize: 14),
                  ),
                )
              ],
            ),
          );
        });
  }

  loginIntoAccount(int type) async {
    processingDialog(PLEASE_WAIT_WHILE_LOGGING_INTO_ACCOUNT);
    Response response;
    Dio dio = new Dio();

    FormData formData = type == 1
        ? FormData.fromMap({
            "email": email,
            "password": password,
            "device_token": await firebaseMessaging.getToken(),
            "device_type": "$type",
          })
        : FormData.fromMap({
            "name": name,
            "email": email,
            "image": image,
            "device_token": await firebaseMessaging.getToken(),
            "device_type": "$type",
          });
    response = await dio
        .post(
            SERVER_ADDRESS +
                "/api/login?login_type=$type&device_token=${await firebaseMessaging.getToken()}&device_type=1&email=$email",
            data: formData)
        .catchError((e) {
      print("ERROR : $e");
      if (type == 2) {
        googleLogin();
      } else {
        Navigator.pop(context);
        print("Error" + e.toString());
        errorDialog('Something went wrong');
      }
    });

    if (response != null &&
        response.statusCode == 200 &&
        response.data['status'] == true) {
      print("Logged in success");
      await SharedPreferences.getInstance().then((value) {
        value.setBool("isLoggedIn", true);
        value.setString("name", response.data['data']['name'] ?? "");
        value.setString("token", response.data['data']['api_token'] ?? "");
        value.setString("email", response.data['data']['email'] ?? "");
        value.setString("phone_no", response.data['data']['phone_no'] ?? "");
        value.setString("password", password ?? "");
        value.setString(
            "profile_pic", response.data['data']['profile_pic'] ?? "");
        value.setInt("id", response.data['data']['id']);
        value.setString("usertype", response.data['data']['usertype']);
        value.setString("uid", response.data['data']['id'].toString());
        if (response.data['data']['usertype'] == "3") {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorDashboardScreen(),
              ));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RootScreen(),
              ));
        }
      }).catchError((e) {
        Navigator.pop(context);
        errorDialog('Something Wrong with your internet');
      });
    } else {
      Navigator.pop(context);
      print("Error" + response.toString());
      errorDialog('Invalid credentials');
    }
  }

  facebookLogin() async {
    dynamic result = await AuthService.facebookLogin();

    if (result != null) {
      if (result is String) {
        errorDialog('${result}');
      } else if (result is Map) {
        setState(() {
          name = result['name'];
          email = result['email'] ?? "null";
          image = result['profile'] ?? " ";
        });

        loginIntoAccount(3);
      } else {
        errorDialog('Something went wrong with the login process');
      }
    } else {
      errorDialog('Something went wrong with the login process');
    }
  }

  googleLogin() async {
    await _googleSignIn.signIn().then((value) {
      value.authentication.then((googleKey) {
        print(googleKey.idToken);
        print(googleKey.accessToken);
        print(value.email);
        print(value.displayName);
        print(value.photoUrl);
        setState(() {
          name = value.displayName;
          email = value.email;
          image = value.photoUrl;
        });

        loginIntoAccount(2);
      }).catchError((e) {
        print(e.toString());
        errorDialog('Something went wrong');
      });
    }).catchError((e) {
      print(e.toString());
      errorDialog('Something went wrong');
    });
  }
}
