import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/appointment_status_model.dart';
import 'package:singleclinic/scoped_models/appointment_scoped_model.dart';
import 'package:singleclinic/screens/SplashScreen.dart';
import 'package:singleclinic/screens/appointment/pdf_widget/save_btn.dart';

import '../../scoped_models/doctors_model.dart';
import '../home/HomeScreen.dart';
import 'package:singleclinic/main.dart';
import 'package:restart_app/restart_app.dart';

class AppointmentSuccessScreen extends StatefulWidget {
  final ApointmentStatus status;
  final bool check;

  const AppointmentSuccessScreen({Key key, this.status, this.check}) : super(key: key);

  @override
  State<AppointmentSuccessScreen> createState() => _AppointmentSuccessScreenState();
}

class _AppointmentSuccessScreenState extends State<AppointmentSuccessScreen> {

  final DoctorsScopedModel doctorsScopedModel = DoctorsScopedModel.instance;
  final Map<String, String> individual = {"individual":"yes"};


  Future<void> fetchDataFromAPI() async {
    // Fetch data from API
    try {
      await doctorsScopedModel.getHomePageDoctors(individual, isRefresh: true);
      // Handle the fetched data
    } catch (error) {
      // Handle error
    }
  }
  @override
  Widget build(BuildContext context) {
    String namedet = "${widget.status.patient.firstName} ${widget.status.patient.lastName}";
    String agedet = "${widget.status.patient.age}";
    String genderdet = "${widget.status.patient.gender}";
    String locationdet = "${widget.status.patient.location}";
    String relationdet = "${widget.status.patient.relation}";
    bool check_back = widget.check;

    return WillPopScope(
      onWillPop: () async {
        print("Jenish basnet ");
        if (widget.check == false) {
          Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);

        
        Navigator.pop(context);
          
        }else{
                      showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirmation'),
                    content: Text('Do you want to continue?'),
                    actions: <Widget>[
                      
                      ElevatedButton(
                        child: Text('Continue'),
                        onPressed: () {
                          // Perform the desired action here
                          // Restart the app or navigate to a new screen
                          // ...
                          Restart.restartApp();
                          
                        },
                      ),
                    ],
                  );
                },
              );
                 
          
        }
        
      },
      child: ScopedModel<AppointmentModel>(
        model: AppointmentModel(),
        child: Scaffold(
          backgroundColor: Color(0xfff6f6f6),
          appBar: AppBar(
            title: Text(
              "Book Appointment",
              style: GoogleFonts.poppins().copyWith(color: Colors.black),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                if (widget.check == false) {
                                  Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                  
                }else{
                  showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirmation'),
                    content: Text('Do you want to continue?'),
                    actions: <Widget>[
                      
                      ElevatedButton(
                        child: Text('Continue'),
                        onPressed: () {
                          // Perform the desired action here
                          // Restart the app or navigate to a new screen
                          // ...
                          Restart.restartApp();
                          
                        },
                      ),
                    ],
                  );
                },
              );
                  
                  // restartApp();
    //               fetchDataFromAPI();
    //                return ScopedModel<DoctorsScopedModel>(
    //   model: DoctorsScopedModel.instance,
    //   child: Builder(builder: (context) {
    //     print("Building Horizontal");
    //     DoctorsScopedModel.of(context)
    //         .getHomePageDoctors(individual, isRefresh: true);
    //     return HomeScreen();
    //   }),
    // );
                  
                    // Navigator.pop(context);
                    // Navigator.pop(context);
                    // Navigator.pop(context);


                }

                
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 60,
                          ),
                          Text(
                            "Booking Successful",
                            style: GoogleFonts.poppins(fontSize: 28),
                          )
                        ],
                      ),
                      Text(
                        "Patient Details",
                        style: GoogleFonts.poppins(
                            fontSize: 28, fontWeight: FontWeight.w500),
                      ),
                      Table(
                        border: TableBorder.all(),
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Name"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "${widget.status.patient.firstName} ${widget.status.patient.lastName}"),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Age"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${widget.status.patient.age}"),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Gender"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.status.patient.gender),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Location"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.status.patient.location),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Relation"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.status.patient.relation),
                            ),
                          ]),

                          //  TableRow(children: [
                          //   Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Text("Hospital Name"),
                          //   ),
                          //   Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Text(status.hospital),
                          //   ),
                          // ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Doctor Name"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.status.doctor.name ?? ""),
                            ),
                          ]),

                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("DOB"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.status.patient.dob.toString()),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Phone"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.status.patient.phone),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Email"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.status.patient.email),
                            ),
                          ]),

                          // TableRow(children: [
                          //   Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Text("Address"),
                          //   ),
                          //   Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Text(status.patient?.address ?? ""),
                          //   ),
                          // ]),
                          // // TableRow(children: [
                          // //   Padding(
                          // //     padding: const EdgeInsets.all(8.0),
                          // //     child: Text("Name"),
                          // //   ),
                          // //   Padding(
                          // //     padding: const EdgeInsets.all(8.0),
                          // //     child: Text("Class"),
                          // //   ),

                          // // ]),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SaveBtnBuilder(
                        name: namedet,
                        age: agedet,
                        gender: genderdet,
                        location: locationdet,
                        relation: relationdet,
                        doctorName: widget.status.doctor.name ?? "",
                        dob: widget.status.patient.dob.toString(),
                        phone: widget.status.patient.phone,
                        email: widget.status.patient.email,
                      ),
                    ],
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
void restartApp() {
  SystemNavigator.pop(animated: false);
}