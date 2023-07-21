import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/order/order_screen.dart';
import 'package:singleclinic/profile/profile.dart';
import 'package:singleclinic/screens/AppointmentScreen.dart';
import 'package:singleclinic/screens/ContactUsScreen.dart';
import 'package:singleclinic/screens/LoginScreen.dart';
import 'package:singleclinic/screens/SubcriptionList.dart';
import 'package:singleclinic/screens/TermAndConditions.dart';
import 'package:singleclinic/screens/department/department_screen.dart';
import 'package:singleclinic/screens/doctors/doctors_list_screen.dart';
import 'package:singleclinic/screens/hospital/hospital_list_screen.dart';
import 'package:singleclinic/screens/my_prescriptions/my_prescriptions.dart';
import 'package:singleclinic/screens/partner.dart';
import 'package:singleclinic/screens/pleaseLogin.dart';
import 'package:singleclinic/screens/shop/shop_screen.dart';
import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/screens/web_view.dart';
import 'package:singleclinic/wishlist_screen.dart';

import '../../main.dart';
import 'circle_widget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String imageUrl, name, phoneNum;
  String becomeASellerUrl = "https://questal.in/become-a-seller";
  String becomeOurHealthPartnerUrl =
      "https://questal.in/become-a-health-partner";
  String becomeOurDoctorUrl = "https://questal.in/become-a-doctor";
  String uploadPrescURL = "https://questal.in/upload-prescription";
  String token;

  shredPre() async {
    var pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
  }

  @override
  void initState() {
    shredPre();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        imageUrl = value.getString("profile_pic");
        name = value.getString("name");
        phoneNum = value.getString("phone_no");
        print(imageUrl);
        print(name);
      });
    });
    super.initState();
  }

  void handleWebViews(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: primaryColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: () {
                      if (name != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => UpdateProfilePage()));
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                  image: token != null
                                      ? NetworkImage(
                                          "https://questal.in/public/upload/profile/$imageUrl")
                                      : AssetImage('assets/sansarhealth.jpg'),
                                  fit: BoxFit.cover)),

                          // child: Center(
                          //     child: token != null
                          //         ? Image.network(
                          //               "https://questal.in/public/upload/profile/$imageUrl")
                          //         : Container(
                          //             width: 42,
                          //             height: 42,
                          //             child: Image(
                          // image: AssetImage(
                          //     'assets/sansarhealth.jpg'),
                          //               fit: BoxFit.fill,
                          //             ),
                          //             decoration: BoxDecoration(
                          //                 color: Colors.white,
                          //                 borderRadius:
                          //                     BorderRadius.circular(100)))),
                        ),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            token != null
                                ? Text(
                                    name ?? "",
                                    style: GoogleFonts.poppins().copyWith(
                                        fontSize: 19,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  )
                                : Text(
                                    'Sansar Health',
                                    style: GoogleFonts.poppins().copyWith(
                                        fontSize: 19,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                            Text(
                              phoneNum ?? "",
                              style: GoogleFonts.poppins().copyWith(
                                  fontSize: 19,
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (c) => HomeScreen()));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RootScreen(),
                        ));
                  },
                  leading: CircleWidget(
                      child: Icon(
                    CupertinoIcons.archivebox,
                    size: 17,
                  )),
                  title: Text(
                    "Dashborad",
                    style: GoogleFonts.poppins()
                        .copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, HospitalListScreen.routeName);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (c) => BookAppointment()));
                  },
                  leading: CircleWidget(
                      child: Icon(
                    CupertinoIcons.archivebox,
                    size: 17,
                  )),
                  title: Text(
                    "Book Appointment At Hospital",
                    style: GoogleFonts.poppins()
                        .copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(DoctorsListScreen.routeName);
                  },
                  leading: CircleWidget(
                      child: Icon(
                    CupertinoIcons.person,
                    size: 17,
                  )),
                  title: Text(
                    "Our Doctors",
                    style: GoogleFonts.poppins()
                        .copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(DepartmentListScreen.routeName);
                  },
                  leading: CircleWidget(
                      child: Icon(
                    CupertinoIcons.group,
                    size: 17,
                  )),
                  title: Text(
                    "Our Departments",
                    style: GoogleFonts.poppins()
                        .copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
                ListTile(
                  onTap: () =>
                      Navigator.of(context).pushNamed(ShopScreen.routeName),
                  leading: CircleWidget(
                      child: Icon(
                    CupertinoIcons.capsule,
                    size: 17,
                  )),
                  title: Text(
                    "Medicine",
                    style: GoogleFonts.poppins()
                        .copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
                ListTile(
                  onTap: () => Navigator.of(context)
                      .pushNamed(ContactUsScreen.routeName),
                  leading: CircleWidget(
                      child: Icon(
                    CupertinoIcons.phone,
                    size: 17,
                  )),
                  title: Text(
                    "Contact",
                    style: GoogleFonts.poppins()
                        .copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
                ListTile(
                  onTap: () => Navigator.of(context)
                      .pushNamed(TermAndConditions.routeName),
                  leading: CircleWidget(
                      child: Icon(
                    CupertinoIcons.doc,
                    size: 17,
                  )),
                  title: Text(
                    "Terms & Condition",
                    style: GoogleFonts.poppins()
                        .copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
                // ListTile(
                //   onTap: () => handleWebViews(context, becomeASellerUrl),
                //   leading: CircleWidget(
                //       child: Icon(
                //     CupertinoIcons.bag,
                //     size: 17,
                //   )),
                //   title: Text(
                //     "Become a Seller",
                //     style: GoogleFonts.poppins()
                //         .copyWith(color: Colors.white, fontSize: 17),
                //   ),
                // ),
                // ListTile(
                //   onTap: () =>
                //       handleWebViews(context, becomeOurHealthPartnerUrl),
                //   leading: CircleWidget(
                //       child: Icon(
                //     Icons.health_and_safety_outlined,
                //     size: 17,
                //   )),
                //   title: Text(
                //     "Become our Health Partner",
                //     style: GoogleFonts.poppins()
                //         .copyWith(color: Colors.white, fontSize: 17),
                //   ),
                // ),
                // ListTile(
                //   onTap: () => handleWebViews(context, becomeOurDoctorUrl),
                //   leading: CircleWidget(
                //       child: Icon(
                //     CupertinoIcons.heart,
                //     size: 17,
                //   )),
                //   title: Text(
                //     "Become our Doctor",
                //     style: GoogleFonts.poppins()
                //         .copyWith(color: Colors.white, fontSize: 17),
                //   ),
                // ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (c) => Partner()));
                  },
                  leading: CircleWidget(
                      child: Icon(
                    CupertinoIcons.group,
                    size: 17,
                  )),
                  title: Text(
                    "Become Our Partner",
                    style: GoogleFonts.poppins()
                        .copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
                ListTile(
                  onTap: () {
                    if (token != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => SubcriptionList()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => PleaseLogin(
                                    Feature: 'Subcription',
                                  )));
                    }
                  },
                  leading: CircleWidget(
                      child: Icon(
                    CupertinoIcons.phone,
                    size: 17,
                  )),
                  title: Text(
                    "My Subscriptions",
                    style: GoogleFonts.poppins()
                        .copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
                ListTile(
                  onTap: () {
                    if (token != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => MyPrescriptionsScreen()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => PleaseLogin(
                                    Feature: 'Prescription',
                                  )));
                    }
                  },
                  leading: CircleWidget(
                      child: Icon(
                    CupertinoIcons.airplane,
                    size: 17,
                  )),
                  title: Text(
                    "My Prescriptions",
                    style: GoogleFonts.poppins()
                        .copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
                ListTile(
                  onTap: () {
                    if (token != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppointmentScreen(),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => PleaseLogin(
                                    Feature: 'Appointment',
                                  )));
                    }
                  },
                  leading: CircleWidget(
                      child: Icon(
                    CupertinoIcons.phone,
                    size: 17,
                  )),
                  title: Text(
                    "My Appointments",
                    style: GoogleFonts.poppins()
                        .copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
                ListTile(
                  onTap: () {
                    if (token != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderScreen(),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => PleaseLogin(
                                    Feature: 'Order',
                                  )));
                    }
                  },
                  leading: CircleWidget(
                      child: Icon(
                    CupertinoIcons.phone,
                    size: 17,
                  )),
                  title: Text(
                    "My Orders",
                    style: GoogleFonts.poppins()
                        .copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
                ListTile(
                  onTap: () {
                    if (token != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WishlistScreen(),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => PleaseLogin(
                                    Feature: 'Wishlist',
                                  )));
                    }
                  },
                  leading: CircleWidget(
                      child: Icon(
                    CupertinoIcons.heart_circle,
                    size: 17,
                  )),
                  title: Text(
                    "My Wishlist",
                    style: GoogleFonts.poppins()
                        .copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () async {
                    var shared = await SharedPreferences.getInstance();
                    // shared.setBool("isLoggedIn", false);
                    // // shared.setString("name", ' ');
                    // // shared.setString("phone_no", ' ');
                    // await FirebaseMessaging.instance
                    //     .deleteToken()
                    //     .then((value) {});
                    FirebaseMessaging.instance.deleteToken();

                    // FirebaseMessaging.instance.unsubscribeFromTopic(topic);
                    await shared.clear();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => LoginScreen()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                      name == null ? "Login" : "Logout",
                      style:
                          GoogleFonts.poppins().copyWith(color: primaryColor),
                    )),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
