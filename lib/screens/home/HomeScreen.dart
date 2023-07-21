import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/common/widgets/drawer.dart';
import 'package:singleclinic/main.dart';
import 'package:singleclinic/modals/DoctorsList.dart';
import 'package:singleclinic/scoped_models/cart_scoped_model.dart';
import 'package:singleclinic/scoped_models/wishlist_scoped_model.dart';
import 'package:singleclinic/screens/DoctorDetail.dart';
import 'package:singleclinic/screens/LoginScreen.dart';
import 'package:singleclinic/screens/cart/cart_screen.dart';
import 'package:singleclinic/screens/home/components/upload_prescription_dialog.dart';
import 'package:singleclinic/screens/prescription/prescription.dart';

import 'package:singleclinic/screens/shop/widgets/subscription_horizontal.dart';
import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/utils/extensions/padding.dart';
import 'package:singleclinic/wishlist_screen.dart';

import '../web_view.dart';
import 'components/doctors_horizontal_component.dart';
import 'components/hospitals_horizontal_list.dart';
import 'components/medicine_horizontal_list.dart';
import 'components/appliances_horizontal_list.dart';
import 'components/our_departmetns_comp.dart';
import 'components/search_area.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  var screenWidth;
  File imageFile;
  var uploadPrescriptionTxt =
      "Diagnostic Services Professional Consultation Tooth Diagnostic Services Professional Consultation Tooth";
  DoctorsList doctorsList;
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  List<InnerData> myList = [];

  TextEditingController prescriptionNameController;
  TextEditingController prescriptionMobileController;
  TextEditingController prescriptionMessageController;
  TextEditingController prescriptionDeliveryAddressController;

  String nextUrl = "";
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();
  String myUid = "";
  Timer timer;
  String uploadPrescURL = "https://questal.in/upload-prescription";

  bool isLoggedIn = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String token;

  shredPre() async {
    var pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
  }

  @override
  void initState() {
    shredPre();
    super.initState();
    prescriptionNameController = TextEditingController(text: "");
    prescriptionMobileController = TextEditingController(text: "");
    prescriptionMessageController = TextEditingController(text: "");
    prescriptionDeliveryAddressController = TextEditingController(text: "");

    FirebaseMessaging.onMessage.listen((event) async {
      print("\n\nonMessage: $event");
      print("\nchannel: ${event.notification}");
      await SharedPreferences.getInstance().then((value) {
        print(value.get(event.data['uid']) ?? "does not exist");
        if (value.get(event.data['uid']) ?? false) {
          notificationHelper.showMessagingNotification(
              data: event.data, context2: context);
        }
      });
    });
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    setState(() {});
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit the app'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // <-- SEE HERE
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void handleWebViews(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }

  @override
  void dispose() {
    prescriptionNameController.dispose();
    prescriptionMobileController.dispose();
    prescriptionMessageController.dispose();
    prescriptionDeliveryAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    print("Home building");
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: LIGHT_GREY_SCREEN_BG,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff00BE9C),
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: 35,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Stack(
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        if (token == null) {
                          final snackBar = SnackBar(
                            content: Text('Login To Add To Cart'),
                            backgroundColor: Colors.teal,
                            behavior: SnackBarBehavior.floating,
                            action: SnackBarAction(
                              label: 'Login',
                              disabledTextColor: Colors.white,
                              textColor: Colors.yellow,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (con) => LoginScreen()));
                                //Do whatever you want
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (con) => WishlistScreen()));
                        }

                        // print(model.cart.length);
                      },
                      icon: Icon(
                        CupertinoIcons.heart,
                        color: Colors.white,
                        size: 35,
                      )), //Container
                  Positioned(
                    top: 10,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white),
                      child: Center(
                          child: ScopedModel<WishlistModel>(
                              model: WishlistModel.instance,
                              child: Builder(builder: (context) {
                                WishlistModel.of(context).getWishlist();
                                return ScopedModelDescendant<WishlistModel>(
                                    builder: (context, _, model) {
                                  if (token == null) {
                                    return Text('0',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor));
                                  } else {
                                    print('object');
                                    print(WishlistModel.of(context)
                                        .wishlistData
                                        .length
                                        .toString());
                                    return Text(
                                        WishlistModel.of(context)
                                            .wishlistData
                                            .length
                                            .toString(),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor));
                                  }
                                  // model.getCartList();
                                });
                              }))),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Stack(
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        if (token == null) {
                          final snackBar = SnackBar(
                            content: Text('Login To Add To Cart'),
                            backgroundColor: Colors.teal,
                            behavior: SnackBarBehavior.floating,
                            action: SnackBarAction(
                              label: 'Login',
                              disabledTextColor: Colors.white,
                              textColor: Colors.yellow,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (con) => LoginScreen()));
                                //Do whatever you want
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (con) => CartScreen()));
                        }

                        // print(model.cart.length);
                      },
                      icon: Icon(
                        CupertinoIcons.bag,
                        color: Colors.white,
                        size: 35,
                      )), //Container
                  Positioned(
                    top: 10,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white),
                      child: Center(
                          child: ScopedModel<CartModel>(
                              model: CartModel.instance,
                              child: Builder(builder: (context) {
                                CartModel.of(context).getCartList();
                                return ScopedModelDescendant<CartModel>(
                                    builder: (context, _, model) {
                                  if (token == null) {
                                    return Text('0',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor));
                                  } else {
                                    return Text(
                                        CartModel.of(context)
                                            .cart
                                            .length
                                            .toString(),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor));
                                  }
                                  // model.getCartList();
                                });
                              }))),
                    ),
                  ),
                ],
              ),
            )
          ],
          title: Row(
            children: [
              Image.asset(
                "assets/app_icon.png",
                width: 30,
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sansar Health",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "dyna")),
                ],
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
        drawer: DrawerWidget(),
        body: body(),
      ),
    );
  }

  body() {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          SearchArea(),

          OurDepartments(),

          /*Book appointment at hospital*/
          HospitalsComp(),

          /*Meet doctors*/
          DoctorsHorizontalList(),

          SubscriptionHorizontalList(),

          /*Become seller and upload prescription*/
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Upload Prescription",
                    style: GoogleFonts.poppins().copyWith(
                        fontSize: 17,
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w700),
                  ),
                ),
              )),

          SizedBox(
            height: 170,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [_uploadPrescriptionWidget()],
            ),
          ).p(8),

          /*Buy Medicine online*/

          MedicineHorizontalList(
            title: "Buy Medicine Online",
          ),

          /*Buy Medicine online*/

          ApplianceHorizontalList(
            title: "Buy Medicine Appliances",
          ),
          // HealthPackages()
        ],
      ),
    );
  }

  doctorDetailTile(
      {String imageUrl,
      String name,
      String department,
      String aboutUs,
      int id}) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DoctorDetails(id)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: LIGHT_GREY, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  height: 72,
                  width: 72,
                  fit: BoxFit.cover,
                  imageUrl: Uri.parse(imageUrl).toString(),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                          height: 75,
                          width: 75,
                          child: Center(child: Icon(Icons.image))),
                  errorWidget: (context, url, error) => Container(
                    height: 75,
                    width: 75,
                    child: Center(
                      child: Icon(Icons.broken_image_rounded),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: BLACK,
                        fontSize: 17,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: LIME,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                      child: Text(
                        department,
                        style: TextStyle(
                            color: WHITE,
                            fontSize: 10,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          aboutUs,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: LIGHT_GREY_TEXT,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 16,
            )
          ],
        ),
        margin: EdgeInsets.fromLTRB(16, 6, 16, 6),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    print("\n\nLifecycle state $state");

    if (state == AppLifecycleState.resumed) {
      updateUserPresence();
    } else {
      if (timer != null) {
        timer.cancel();
      }
      Map<String, dynamic> presenceStatusFalse = {
        'presence': false,
        'last_seen': DateTime.now().toUtc().toString(),
      };

      if (myUid != null) {
        await databaseReference
            .child(myUid)
            .update(presenceStatusFalse)
            .whenComplete(() => print('Updated your presence.'))
            .catchError((e) => print(e));
      }
    }
  }

  checkIfLoggedInFromAnotherDevice() async {}

  updateUserPresence() async {
    Map<String, dynamic> presenceStatusTrue = {
      'presence': true,
      'last_seen': DateTime.now().toUtc().toString(),
    };

    await databaseReference
        .child(myUid)
        .update(presenceStatusTrue)
        .whenComplete(() => print('Updated your presence.'))
        .catchError((e) => print(e));

    Map<String, dynamic> presenceStatusFalse = {
      'presence': false,
      'last_seen': DateTime.now().toUtc().toString(),
    };

    databaseReference.child(myUid).onDisconnect().update(presenceStatusFalse);
  }

  updatePreferenceAgainAndAgain() {
    Map<String, dynamic> presenceStatusTrue = {
      'presence': true,
      'connections': true,
      'last_seen': DateTime.now().toString(),
    };

    databaseReference.child(myUid).update(presenceStatusTrue).whenComplete(() {
      updateUserPresence();
      print('Updated your presence.');
    }).catchError((e) => print(e));
  }

  alertDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: _willPopScope,
            child: AlertDialog(
              title: Text("Log Out"),
              content: Text("Your account is logged In from another device"),
              actions: [
                TextButton(
                  child: Text("ok"),
                  onPressed: () async {},
                )
              ],
            ),
          );
        });
  }

  Future<bool> _willPopScope() async {
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
    return false;
  }

  // Widget _becomeSellerWidget() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 8),
  //     padding: EdgeInsets.all(10),
  //     decoration: BoxDecoration(
  //         color: Colors.white, borderRadius: BorderRadius.circular(8)),
  //     child: Column(
  //       children: [
  //         Stack(
  //           children: [
  //             ClipRRect(
  //                 borderRadius: BorderRadius.circular(10),
  //                 child: Image.network(
  //                   "https://images.unsplash.com/photo-1607619056574-7b8d3ee536b2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGlsbHN8ZW58MHx8MHx8&w=1000&q=80",
  //                   width: 130,
  //                   height: 90,
  //                   fit: BoxFit.cover,
  //                 )),
  //             Container(
  //               height: 90,
  //               width: 130,
  //               child: Center(
  //                   child: Text(
  //                     "Become a Seller",
  //                     style: TextStyle(color: Colors.white),
  //                   )),
  //               color: Colors.black.withOpacity(0.4),
  //             )
  //           ],
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         Container(
  //           width: 120,
  //           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
  //           decoration: BoxDecoration(
  //               color: primaryColor, borderRadius: BorderRadius.circular(4)),
  //           child: Center(
  //               child: Text(
  //                 "Register Now",
  //                 style: TextStyle(color: Colors.white),
  //               )),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _uploadPrescriptionWidget() {
    return Container(
      width: screenWidth / 1.07,
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
          color: Color(0xFF0f4a86), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: primaryColor,
                border: Border.all(width: 6, color: Colors.white)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    "assets/homescreen/upload_prescription.PNG",
                    height: 80,
                    width: 130,
                    fit: BoxFit.contain,
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Upload Prescription",
                style:
                    TextStyle(color: Colors.white, fontSize: screenWidth / 21),
              ),
              SizedBox(
                width: screenWidth / 2,
                child: Text(
                  uploadPrescriptionTxt,
                  style: TextStyle(
                      color: Colors.white, fontSize: screenWidth / 33),
                  textAlign: TextAlign.end,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // handleWebViews(context, uploadPrescURL);

                  // if (token == null) {
                  //   final snackBar = SnackBar(
                  //     content: Text('Login To Upload Prescription'),
                  //     backgroundColor: Colors.teal,
                  //     behavior: SnackBarBehavior.floating,
                  //     action: SnackBarAction(
                  //       label: 'Login',
                  //       disabledTextColor: Colors.white,
                  //       textColor: Colors.yellow,
                  //       onPressed: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (con) => LoginScreen()));
                  //         //Do whatever you want
                  //       },
                  //     ),
                  //   );
                  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // } else {
                  // showUploadPrescriptionDialog(
                  //     imageFile: imageFile,
                  //     screenWidth: screenWidth,
                  //     context: context,
                  //     primaryColor: primaryColor,
                  //     prescriptionDeliveryAddressController:
                  //         prescriptionDeliveryAddressController,
                  //     prescriptionMessageController:
                  //         prescriptionMessageController,
                  //     prescriptionMobileController:
                  //         prescriptionMobileController,
                  //     prescriptionNameController: prescriptionNameController);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UploadPrescription()),
                  );
                },
                child: Container(
                  width: screenWidth / 3,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text(
                    "Upload Now",
                    style: TextStyle(color: Colors.black),
                  )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // showUploadPrescriptionDialog({
  //   var context,
  //   var screenWidth,
  //   var primaryColor,
  //   var prescriptionNameController,
  //   var prescriptionMobileController,
  //   var prescriptionMessageController,
  //   var prescriptionDeliveryAddressController,
  //   var imageFile,
  // }) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           scrollable: true,
  //           backgroundColor: Colors.grey.shade300,
  //           contentPadding: EdgeInsets.zero,
  //           content: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Container(
  //                 height: 50,
  //                 width: screenWidth / 1.3,
  //                 decoration: BoxDecoration(
  //                   color: primaryColor,
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(10.0),
  //                   child: Align(
  //                     alignment: Alignment.centerLeft,
  //                     child: Text(
  //                       "Upload Prescription",
  //                       style: TextStyle(fontSize: 18),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               customTextFieldForDialog(
  //                   title: "Name", controller: prescriptionNameController),
  //               customTextFieldForDialog(
  //                   title: "Mobile", controller: prescriptionMobileController),
  //               customTextFieldForDialog(
  //                   title: "Message",
  //                   controller: prescriptionMessageController),
  //               customTextFieldForDialog(
  //                   title: "Delivery Address",
  //                   controller: prescriptionDeliveryAddressController),
  //               Padding(
  //                 padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text("Profile Image"),
  //                         GestureDetector(
  //                           onTap: () async {
  //                             XFile pickedFile = await ImagePicker().pickImage(
  //                               source: ImageSource.gallery,
  //                               maxWidth: 500,
  //                               maxHeight: 500,
  //                             );
  //                             if (pickedFile != null) {
  //                               setState(() {
  //                                 imageFile = File(pickedFile.path);
  //                               });
  //                             }
  //                           },
  //                           child: Container(
  //                             height: screenWidth / 11,
  //                             width: screenWidth / 3,
  //                             decoration: BoxDecoration(
  //                                 border: Border.all(
  //                                     width: 1, color: Colors.black)),
  //                             child: Center(
  //                               child: Text("Choose File"),
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     imageFile != null
  //                         ? Container(
  //                             width: screenWidth / 1.6,
  //                             height: screenWidth / 3,
  //                             child: Image.file(
  //                               imageFile,
  //                               fit: BoxFit.cover,
  //                             ),
  //                           )
  //                         : Container(
  //                             child: Center(
  //                               child: Text("No file choosen"),
  //                             ),
  //                           )
  //                   ],
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
  //                 child: GestureDetector(
  //                   onTap: () {},
  //                   child: Container(
  //                     height: screenWidth / 9,
  //                     width: screenWidth / 2.7,
  //                     decoration: BoxDecoration(color: Colors.orange),
  //                     child: Center(
  //                       child: Text(
  //                         "Upload Now",
  //                         style: TextStyle(color: Colors.white),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }
}
