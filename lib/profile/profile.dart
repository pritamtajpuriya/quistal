import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/scoped_models/userscopedmodel.dart';
import 'package:singleclinic/utils/constants.dart';

// import 'package:http/http.dart' as http;
// import 'dart:convert';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
  bool isFromHome;
  UpdateProfilePage({Key key, this.isFromHome}) : super(key: key);
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String image;
  bool isLoading = false;

  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        nameController.text = value.getString("name");
        // var pref=await SharedPreferences.getInstance();
        // String token=pref.getString("token");
        phoneController.text = value.getString("phone_no");
        print("pic ${value.getString("profile_pic")}");
        print(IMAGE_BASE_URL + value.getString("profile_pic"));
      });
    });
    super.initState();
  }

  // String imageUrl;
  File _profileImage;
  // String _name = "";
  // String _zipcode = "";

  Future getImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Update Profile"),
        elevation: 0,
        backgroundColor: Color(0xff00BE9C),
        // backgroundColor: Color.fromARGB(255, 26, 246, 154),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            // _scaffoldKey.currentState.openDrawer();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
      ),
      // drawer: DrawerWidget(),
      body: ScopedModel<UserModel>(
        model: UserModel.instance,
        child: Builder(builder: (context) {
          UserModel.of(context).getUserDetails();
          return ScopedModelDescendant<UserModel>(builder: (context, _, model) {
            if (model.user != null) {
              cityController.text = model.user.city;
              addressController.text = model.user.address;
              zipcodeController.text = model.user.zip_code;
              image = model.user.profilePic;
              emailController.text = model.user.email;
              return Padding(
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            width: 100,
                            height: 99,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color.fromARGB(255, 0, 190,
                                    156), // this is the border color
                                width: 3.0,
                              ),
                              image: DecorationImage(
                                image: image != null
                                    ? NetworkImage(
                                        IMAGE_BASE_URL + "/profile/" + image)
                                    : NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf-H0m8PLT9RhcZM6yR4cAR1T7K29zmMgUo_hTwYmzBw&s",
                                      ),
                                // : NetworkImage("https://via.placeholder.com/150"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: getImage,
                          child: Icon(Icons.camera_alt,
                              color: Color.fromARGB(255, 0, 190, 156),
                              size: 30),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Name"),
                          controller: nameController,
                          // onChanged: (value) {
                          //   setState(() {
                          //     name = value;
                          //   });
                          // },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(labelText: "City"),
                          controller: cityController,

                          // onChanged: (value) {
                          //   setState(() {
                          //     _city = value;
                          //   });
                          // },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Address"),
                          controller: addressController,
                          // onChanged: (value) {
                          //   setState(() {
                          //     _address = value;
                          //   });
                          // },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: phoneController,
                          decoration:
                              InputDecoration(labelText: "Phone Number"),
                          // onChanged: (value) {
                          //   setState(() {
                          //     phone_no = value;
                          //   });
                          // },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Zip Code"),
                          controller: zipcodeController,
                          // obscureText: true,
                          // enableSuggestions: false,
                          // autocorrect: false,
                          // onChanged: (value) {
                          //   setState(() {});
                          // },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Email"),
                          controller: emailController,
                          enabled: false,
                          // obscureText: true,
                          // enableSuggestions: false,
                          // autocorrect: false,
                          // onChanged: (value) {
                          //   setState(() {});
                          // },
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: isLoading == true
                              ? () {}
                              : () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Response userResponse =
                                      await model.updateProfile(
                                    name: nameController.text,
                                    address: addressController.text,
                                    city: cityController.text,
                                    zipCode: zipcodeController.text,
                                    phoneNum: phoneController.text,
                                    profile_pic: _profileImage,
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (jsonDecode(
                                          userResponse.body)["message"] ==
                                      "Profile updated successfully") {
                                    final snackBar = SnackBar(
                                      content: Text(jsonDecode(
                                          userResponse.body)["message"]),
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
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    final snackBar = SnackBar(
                                      content: Text(jsonDecode(
                                          userResponse.body)["message"]),
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
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.76,
                            height: MediaQuery.of(context).size.width * 0.12,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 190, 156),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 0, 190, 156),
                                  // offset: Offset(2, 2),
                                  blurRadius: 6,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Center(
                                child: isLoading == false
                                    ? Text(
                                        'UPDATE',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          });
        }),
      ),
    );
  }
}
