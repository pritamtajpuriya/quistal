import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/AllText.dart';
import 'package:singleclinic/screens/LoginScreen.dart';

import '../main.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String name = "";
  String emailAddress = "";
  String phoneNumber = "";
  String password = "";
  String confirmPassword = "";
  String path = "";
  TextEditingController Tname = TextEditingController();
  TextEditingController TemailAddress = TextEditingController();
  TextEditingController TphoneNumber = TextEditingController();
  TextEditingController Tpassword = TextEditingController();
  TextEditingController TconfirmPassword = TextEditingController();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  // final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          // brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              )),
        ),
        body: body(),
      ),
    );
  }

  body() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create an Account,Its free",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      makeInput(label: "Name", controller: Tname),
                      makeInput(
                          label: "Email",
                          keyboardType: TextInputType.emailAddress,
                          controller: TemailAddress),
                      makeInput(
                          label: "Phone Number",
                          keyboardType: TextInputType.number,
                          controller: TphoneNumber),
                      makeInput(
                          label: "Password",
                          obsureText: true,
                          controller: Tpassword),
                      makeInput(
                          label: "Confirm Pasword",
                          obsureText: true,
                          controller: TconfirmPassword),
                    ],
                  ),
                ),
                button(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  button() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              name = Tname.text;
              emailAddress = TemailAddress.text;
              phoneNumber = TphoneNumber.text;
              password = Tpassword.text;
              confirmPassword = TconfirmPassword.text;

              print(name);
              print(emailAddress);
              print(password);
              print(phoneNumber);

              if (name == '' ||
                  emailAddress == '' ||
                  password == '' ||
                  phoneNumber == '' ||
                  confirmPassword == '') {
                print('emty');
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
              } else if (password != confirmPassword) {
                print('pass error');
                final snackBar = SnackBar(
                  content:
                      Text('Passwords and Confirm password need to be same.'),
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
              } else {
                print('all good');
                createAccount();
              }
              // if (formKey.currentState.validate()) {
              //   formKey.currentState.save();
              //   createAccount();
              // }
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
                  REGISTER,
                  style: TextStyle(
                      color: WHITE, fontWeight: FontWeight.w700, fontSize: 17),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  // final picker = ImagePicker();

  // Future getImage({bool fromGallery = false}) async {
  //   final pickedFile = await picker.pickImage(
  //       source: fromGallery ? ImageSource.gallery : ImageSource.camera);

  //   setState(() {
  //     if (pickedFile != null) {
  //       setState(() {
  //         path = File(pickedFile.path).path;
  //       });
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  createAccount() async {
    processingDialog(PLEASE_WAIT_WHILE_CREATING_ACCOUNT);
    Response response;
    Dio dio = new Dio();

    FormData formData = FormData.fromMap({
      "name": "Name",
      "email": TemailAddress.text,
      "password": Tpassword.text,
      "phone": TphoneNumber.text,
      // "device_token": await firebaseMessaging.getToken(),
      // "device_type": "1",
      // "image": await MultipartFile.fromFile(path, filename: "upload.jpg"),
    });
    response = await dio.post(
      SERVER_ADDRESS + "/api/register",
      data: {
        "name":"$name",
        "email":"$emailAddress",
        "password":"$password",
        "phone": "$phoneNumber"


      },
      options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    );
    if (response.statusCode == 200 && response.data['status'] == 1) {
      print(response.toString());

      FirebaseDatabase.instance
          .reference()
          .child(response.data['data']['id'].toString())
          .set({
        "name": response.data['data']['name'],
        "usertype": response.data['data']['usertype'],
        "profile": "profile/" +
            response.data['data']['profile_pic'].toString().split("/").last,
      }).then((value) async {
        print("\n\nData added in cloud firebase\n\n");
        FirebaseDatabase.instance
            .reference()
            .child(response.data['data']['user_sid'].toString())
            .child("TokenList")
            .set({"device": await firebaseMessaging.getToken()}).then(
                (value) async {
          print("\n\nData added in firebase database\n\n");
          await SharedPreferences.getInstance().then((value) {
            value.setBool("isLoggedIn", true);
            value.setString("name", response.data['data']['name']);
            value.setString("email", response.data['data']['email']);
            value.setString("phone_no", response.data['data']['phone_no']);
            value.setString("password", password);

            value.setString(
                "profile_pic", response.data['data']['profile_pic'].toString());
            value.setInt("id", response.data['data']['id']);
            value.setInt("usertype", response.data['data']['usertype']);
            value.setString("uid", response.data['data']['id'].toString());
          });

          print("\n\nData added in device\n\n");

          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RootScreen(),
              ));
        }).catchError((e) {
          Navigator.pop(context);
          errorDialog(e.toString());
        });
      }).catchError((e) {
        Navigator.pop(context);
        errorDialog(e.toString());
      });
    } else {
      print("Here $name");
      print("Here $emailAddress");
      print("Here $password");
      print("Here $phoneNumber");




      print("Here ${response.toString()}");
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: response.toString().length > 56 &&
                    response.toString().length < 100
                ? AlertDialog(
                    // title: Text('Title'),
                    content: Text('Email has been already taken'),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Go Back'),
                      ),
                    ],
                  )
                : response.toString().length > 100
                    ? AlertDialog(
                        // title: Text('Title'),
                        content: Text('Password is too short'),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Go Back'),
                          ),
                        ],
                      )
                    : AlertDialog(
                        // title: Text('Title'),
                        content: Text('User Registered'),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: Text('Login'),
                          ),
                        ],
                      ),
          );
        },
      );
      print("Errossr" + response.toString());
      print(response.toString().length);
      // errorDialog(response.data['msg']);
    }
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
                  message,
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
}

Widget makeInput(
    {label,
    obsureText = false,
    TextEditingController controller,
    TextInputType keyboardType}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        controller: controller,
        obscureText: obsureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[400],
            ),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400])),
        ),
        keyboardType: keyboardType != null ? keyboardType : TextInputType.name,
      ),
      SizedBox(
        height: 30,
      )
    ],
  );
}
