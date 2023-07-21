import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/AllText.dart';
import 'package:singleclinic/main.dart';
import 'package:singleclinic/modals/prescription_model.dart';
import 'package:singleclinic/scoped_models/prescription_scoped_model.dart';
import 'package:singleclinic/screens/home/HomeScreen.dart';
import 'package:singleclinic/utils/helper.dart';

class MyPrescriptionsScreen extends StatefulWidget {
  MyPrescriptionsScreen({Key key}) : super(key: key);

  @override
  State<MyPrescriptionsScreen> createState() => _MyPrescriptionsScreenState();
}

class _MyPrescriptionsScreenState extends State<MyPrescriptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<PrescriptionScopedModel>(
        model: PrescriptionScopedModel.instance,
        child: Builder(builder: (context) {
          PrescriptionScopedModel.of(context).getMyPrescriptions();
          return ScopedModelDescendant<PrescriptionScopedModel>(
              builder: (context, _, model) {
            return Scaffold(
              backgroundColor: Color(0xfff6f6f6),
              appBar: AppBar(
                title: Text(
                  "My Prescriptions",
                  style: GoogleFonts.poppins().copyWith(color: Colors.black),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => HomeScreen())));
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: model.prescriptions?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          Prescription currentPrescription =
                              model.prescriptions[index];
                          print("Prescription ${currentPrescription.path}");
                          
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Container(
                                      width: 80,
                                      height: 100,
                                      child: currentPrescription.path != "" ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            getImageUrl(
                                                currentPrescription.path),
                                            fit: BoxFit.cover,
                                          )):  ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                          "assets/doctor_placeholder.jpg",
                                            fit: BoxFit.cover
                                            ,
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentPrescription.name,
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Phone: ${currentPrescription.mobile.toString()}',
                                          style: GoogleFonts.poppins().copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                       currentPrescription.message != null ?Text(
                                          currentPrescription.message
                                              .toString(),
                                          style: GoogleFonts.poppins().copyWith(
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ): SizedBox(),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                         "Date : "+ currentPrescription.preptime
                                             .substring(0, 10),
                                          style: GoogleFonts.poppins().copyWith(
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Divider(),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        }));
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
