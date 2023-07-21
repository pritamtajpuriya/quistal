import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/common/widgets/heading_tile.dart';
import 'package:singleclinic/common/widgets/horizontal_shimmer_list.dart';
import 'package:singleclinic/main.dart';
import 'package:singleclinic/modals/HealthPackage.dart';
import 'package:singleclinic/scoped_models/doctors_model.dart';
import 'package:singleclinic/screens/SubscriptionPlansScreen.dart';
import 'package:singleclinic/screens/appointment/appointment_booking_screen.dart';
import 'package:singleclinic/screens/doctors/doctors_list_screen.dart';
import 'package:singleclinic/utils/extensions/padding.dart';
import 'package:singleclinic/utils/helper.dart';

class SubscriptionHorizontalList extends StatefulWidget {
  const SubscriptionHorizontalList({Key key}) : super(key: key);

  @override
  State<SubscriptionHorizontalList> createState() =>
      _SubscriptionHorizontalListState();
}

class _SubscriptionHorizontalListState
    extends State<SubscriptionHorizontalList> {
  HealthPackage healthPackage;

  fetchPlans() async {
    final response =
        await get(Uri.parse("$SERVER_ADDRESS/api/gethealthpackage"));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        healthPackage = HealthPackage.fromJson(jsonResponse);
      });
    }
  }

  @override
  void initState() {
    fetchPlans();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Hello world");
    return Column(
      children: [
        HeadingTile(
          title: "Our Packages",
          route: "SubscriptionPlansScreen",
        ),
        SizedBox(
          height: 350,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: healthPackage?.data?.length ?? 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => SubscriptionPlansScreen(
                              // doctor: e,
                              )));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: SizedBox(
                    // width: 130,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.81,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                height: 150,
                                width: 150,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          color: Colors.grey.shade300,
                                          offset: Offset(3, 3))
                                    ]),
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/doctor_placeholder.jpg",
                                  width: 250,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            SizedBox(height: 10),
                            Center(
                              child: Text(
                                healthPackage.data[index].name,
                                style: GoogleFonts.poppins().copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Color.fromARGB(253, 11, 222, 184)),
                              ),
                            ),
                            SizedBox(height: 4),
                            Center(
                              child: Text(
                                'Consultation with the best',
                                style: GoogleFonts.poppins().copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 180,
                              // height: ,
                              // height: 150,
                              child: Text(
                                "Rs ${healthPackage.data[index].price}",
                                style: GoogleFonts.poppins().copyWith(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                                softWrap: false,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) =>
                                              SubscriptionPlansScreen(
                                                  // doctor: e,
                                                  )));

                                  // Handle button tap
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.76,
                                  height:
                                      MediaQuery.of(context).size.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(17, 72, 136, 2),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(17, 72, 136, 2),
                                        // offset: Offset(2, 2),
                                        blurRadius: 6,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Center(
                                      child: Text(
                                        'SUBSCRIBE',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            //   ElevatedButton(

                            //     onPressed: () {
                            //       Navigator.push(
                            // context,
                            // MaterialPageRoute(
                            //     builder: (c) =>
                            //         DoctorAppointmentScreen(
                            //           doctor: e,
                            //         )));
                            //     },
                            //     child: Text('Book appoitment'),
                            //   )

                            // SizedBox(
                            //   height: 5,
                            // ),
                            // SizedBox(
                            //   width: 250,
                            //   child: Align(
                            //     alignment: Alignment.centerRight,
                            //     child: Text(
                            //       "Free",
                            //       style: GoogleFonts.poppins(),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),

                    // child: Column(
                    //   crossAxisAlignment:
                    //       CrossAxisAlignment.start,
                    //   children: [
                    //     ClipRRect(
                    //         borderRadius:
                    //             BorderRadius.circular(10),
                    //         child:  Image.asset("assets/doctor_placeholder.jpg")),
                    //     Text(
                    //       healthPackage.data[index].name,
                    //       style: GoogleFonts.poppins().copyWith(
                    //           fontWeight: FontWeight.w700),
                    //     ),
                    //     SizedBox(
                    //       height: 5,
                    //     ),
                    //     SizedBox(
                    //       width: double.infinity,
                    //       child: Align(
                    //         alignment: Alignment.centerRight,
                    //         child: Text(
                    //           "Rs ${healthPackage.data[index].price}",
                    //           style: GoogleFonts.poppins(),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                ),
              );
            },
          ),
        ).p(8)
      ],
    );
  }
}
