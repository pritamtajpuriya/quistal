import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/modals/Doctor_model.dart';
import 'package:singleclinic/modals/appointment_status_model.dart';
import 'package:singleclinic/scoped_models/appointment_scoped_model.dart';
import 'package:singleclinic/scoped_models/settings_scoped_model.dart';
import 'package:singleclinic/screens/LoginScreen.dart';
import 'package:singleclinic/screens/appointment/appointment_success_screen.dart';
import 'package:singleclinic/screens/doctors/widget/doctor_item_widget_vertical.dart';
import 'package:singleclinic/utils/colors.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  final Doctor doctor;
  final bool back;

  const DoctorAppointmentScreen({Key key, this.doctor, this.back}) : super(key: key);

  @override
  State<DoctorAppointmentScreen> createState() =>
      _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
  TextEditingController _date = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _relation = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  String genderDWValue = "male";
  String selectedDay = "today";
  DateTime pickedDate = DateTime.now();
  int count = 1;

  String token;
  bool check_back;

  shredPre() async {
    var pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
  }

  @override
  void initState() {
    shredPre();
    check_back = widget.back;
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppointmentModel>(
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
            onPressed: () => Navigator.pop(context),
          ),
        ),
        bottomNavigationBar: ScopedModelDescendant<AppointmentModel>(
            builder: (context, _, model) {
          return InkWell(
            onTap: () {
              if (model.selectedPatient != null &&
                  (model.selectedDate != null)) {
                showBottomSheeet(model: model);
              } else {
                if (token == null) {
                  final snackBar = SnackBar(
                    content: Text('Login To Book Appointment'),
                    backgroundColor: Colors.teal,
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: 'Login',
                      disabledTextColor: Colors.white,
                      textColor: Colors.yellow,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (con) => LoginScreen()));
                        //Do whatever you want
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (model.selectedPatient == null) {
                  final snackBar = SnackBar(
                    content: Text('Please Select Patient'),
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
                  final snackBar = SnackBar(
                    content: Text('Please select a available time'),
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
                }
              }
            },
            child: Container(
              padding: EdgeInsets.all(10),
              height: 60,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Text(
                "Book",
                style: GoogleFonts.poppins()
                    .copyWith(color: Colors.white, fontSize: 20),
              )),
            ),
          );
        }),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.black,
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      print(date);
                      pickedDate = date;
                      DateTime currentDateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 00, 00 ,00);
                      print(date.difference(currentDateTime).inDays);
                      if (date.difference(currentDateTime).inDays == 1) {
                        selectedDay = "tomorrow";
                        setState(() {});
                      } else if (date.difference(currentDateTime).inDays == 2) {
                        selectedDay = "dayAfterTomorrow";
                        setState(() {});
                      } else if (date.difference(currentDateTime).inDays == 0) {
                        selectedDay = "today";
                        setState(() {});
                      } else{
                        selectedDay = "nothing";
                        setState(() {});
                      }
                    },
                  ),
                  DoctorItemVertical(
                    doctor: widget.doctor,
                    // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c)=>DoctorDetails(doctor.id)))
                  ),
                  ScopedModelDescendant<AppointmentModel>(
                      builder: (context, _, model) {
                        print("This is length${widget
                              .doctor.dayAfterTomorrowAvailableTimes.availableTimes.length.toString()}");
                        if (widget
                              .doctor.dayAfterTomorrowAvailableTimes.availableTimes.length == 0) {
                                count = 0;                          
                        }
                        if (widget.doctor.hospitalId != null) {
                          return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      
                      itemCount: 1,
                      // selectedDay == "today"
                      //     ? widget
                      //         .doctor.todayAvailableTimes.availableTimes.length
                      //     : selectedDay == "tomorrow"
                      //         ? widget.doctor.tomorrowAvailableTimes
                      //             .availableTimes.length
                      //         : selectedDay == "dayAfterTomorrow"
                      //             ? widget.doctor.dayAfterTomorrowAvailableTimes
                      //                 .availableTimes.length
                      //             : 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 3 / 1),
                      itemBuilder: (context, index) {
                        String currentTime;
                        String currentSlots;
                        if (selectedDay == "today") {
                          if (widget
                              .doctor.todayAvailableTimes.availableTimes.length > 0) {
                               currentTime = widget
                              .doctor.todayAvailableTimes.availableTimes[index];
                           currentSlots = widget
                              .doctor.todayAvailableTimes.token.toString(); 
                            
                          } else{
                            currentSlots = 0.toString();
                          }
                         
                          print("Current slot $currentSlots");
                        } else if (selectedDay == "tomorrow") {
                          if (widget.doctor.tomorrowAvailableTimes
                              .availableTimes.length > 0) {
                                currentTime = widget.doctor.tomorrowAvailableTimes
                              .availableTimes[index];
                          currentSlots = widget
                              .doctor.tomorrowAvailableTimes.token.toString();
                            
                          }else{
                            currentSlots = 0.toString();
                          }
                           
                        } else if (selectedDay == "dayAfterTomorrow") {
                          if (widget.doctor.dayAfterTomorrowAvailableTimes
                              .availableTimes.length > 0) {
                                currentTime = widget
                              .doctor
                              .dayAfterTomorrowAvailableTimes
                              .availableTimes[index];
                          currentSlots = widget
                              .doctor.dayAfterTomorrowAvailableTimes.token.toString(); 
                            
                          }else{
                            currentSlots = 0.toString();
                          }
                          
                        } else{
                          currentSlots = 0.toString();
                        }

                        return InkWell(
                          onTap: () {
                            // String time;
                            // if (selectedDay == "today") {
                            //   time = widget.doctor.todayAvailableTimes
                            //       .availableTimes[index];
                            // } else if (selectedDay == "tomorrow") {
                            //   time = widget.doctor.tomorrowAvailableTimes
                            //       .availableTimes[index];
                            // } else if (selectedDay == "dayAfterTomorrow") {
                            //   time = widget
                            //       .doctor
                            //       .dayAfterTomorrowAvailableTimes
                            //       .availableTimes[index];
                            // }

                            AppointmentModel.of(context).selectedTime =
                                currentTime;
                            if (selectedDay == "today") {
                              AppointmentModel.of(context).selectedDate = widget
                                  .doctor.todayAvailableTimes.date
                                  .toString();
                            } else if (selectedDay == "tomorrow") {
                              AppointmentModel.of(context).selectedDate = widget
                                  .doctor.tomorrowAvailableTimes.date
                                  .toString();
                            } else if (selectedDay == "dayAfterTomorrow") {
                              AppointmentModel.of(context).selectedDate = widget
                                  .doctor.dayAfterTomorrowAvailableTimes.date
                                  .toString();
                            }

                            model.notifyListeners();
                          },
                          child: Container(
                            width: 500,
                            child: Card(
                              color: model.selectedTime == currentTime
                                  ? Colors.black.withOpacity(0.1)
                                  : Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "Token Available : $currentSlots" ?? "",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                                              
                        } else {
                          return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: selectedDay == "today"
                          ? widget
                              .doctor.todayAvailableTimes.availableTimes.length
                          : selectedDay == "tomorrow"
                              ? widget.doctor.tomorrowAvailableTimes
                                  .availableTimes.length
                              : selectedDay == "dayAfterTomorrow"
                                  ? widget.doctor.dayAfterTomorrowAvailableTimes
                                      .availableTimes.length
                                  : 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, childAspectRatio: 2 / 1),
                      itemBuilder: (context, index) {
                        String currentTime;
                        if (selectedDay == "today") {
                          currentTime = widget
                              .doctor.todayAvailableTimes.availableTimes[index];
                        } else if (selectedDay == "tomorrow") {
                          currentTime = widget.doctor.tomorrowAvailableTimes
                              .availableTimes[index];
                        } else if (selectedDay == "dayAfterTomorrow") {
                          currentTime = widget
                              .doctor
                              .dayAfterTomorrowAvailableTimes
                              .availableTimes[index];
                        }

                        return InkWell(
                          onTap: () {
                            // String time;
                            // if (selectedDay == "today") {
                            //   time = widget.doctor.todayAvailableTimes
                            //       .availableTimes[index];
                            // } else if (selectedDay == "tomorrow") {
                            //   time = widget.doctor.tomorrowAvailableTimes
                            //       .availableTimes[index];
                            // } else if (selectedDay == "dayAfterTomorrow") {
                            //   time = widget
                            //       .doctor
                            //       .dayAfterTomorrowAvailableTimes
                            //       .availableTimes[index];
                            // }

                            AppointmentModel.of(context).selectedTime =
                                currentTime;
                            if (selectedDay == "today") {
                              AppointmentModel.of(context).selectedDate = widget
                                  .doctor.todayAvailableTimes.date
                                  .toString();
                            } else if (selectedDay == "tomorrow") {
                              AppointmentModel.of(context).selectedDate = widget
                                  .doctor.tomorrowAvailableTimes.date
                                  .toString();
                            } else if (selectedDay == "dayAfterTomorrow") {
                              AppointmentModel.of(context).selectedDate = widget
                                  .doctor.dayAfterTomorrowAvailableTimes.date
                                  .toString();
                            }

                            model.notifyListeners();
                          },
                          child: Card(
                            color: model.selectedTime == currentTime
                                ? Colors.black.withOpacity(0.1)
                                : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  currentTime ?? "",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                    
                        }
                    // if (widget.doctor.todayAvailableTimes != null) {

                    // } else {
                    //   return Padding(
                    //     padding: const EdgeInsets.all(15.0),
                    //     child: Text("Not available today"),
                    //   );
                    // }
                  }),
                  ScopedModelDescendant<AppointmentModel>(
                      builder: (context, _, model) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: DropdownButton(
                          onChanged: (value) {
                            model.selectedPatient = model.patientsList
                                .firstWhere((element) => element.id == value);
                            model.notifyListeners();
                          },
                          value: model.selectedPatient != null
                              ? model.selectedPatient.id
                              : null,
                          isExpanded: true,
                          underline: SizedBox(),
                          hint: Text("Select Patient Name"),
                          items: model.patientsList
                              .map((e) => DropdownMenuItem(
                                    child: Text(e.firstName),
                                    value: e.id,
                                  ))
                              .toList()),
                    );
                  })
                ],
              ),
              ScopedModelDescendant<AppointmentModel>(
                  builder: (context, _, model) {
                model = AppointmentModel();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        if (token == null) {
                          final snackBar = SnackBar(
                            content: Text('Login To Add Patient'),
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
                          showNewPatientDialog(model: model);
                        }
                      },
                      child: const Text('Add new patient'),
                    ),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  showNewPatientDialog({AppointmentModel model}) {
    return showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
              scrollable: true,
              title: Text('Add new patient'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _firstName,
                    decoration: InputDecoration(hintText: 'Enter first name'),
                  ),
                  TextField(
                    controller: _lastName,
                    decoration: InputDecoration(hintText: 'Enter Last name'),
                  ),
                  TextField(
                    controller: _age,
                    decoration: new InputDecoration(labelText: "Enter Age"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  ),
                  TextField(
                    controller: _date,
                    decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today_rounded),
                        labelText: "Date of birth"),
                    onTap: () async {
                      DateTime pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2101));

                      if (pickeddate != null) {
                        setState(() {
                          _date.text =
                              DateFormat('yyyy-MM-dd').format(pickeddate);
                        });
                      }
                    },
                  ),
                  TextField(
                    controller: _location,
                    decoration: InputDecoration(hintText: 'Location'),
                  ),
                  TextField(
                    controller: _relation,
                    decoration: InputDecoration(hintText: 'Relation'),
                  ),
                  TextField(
                    controller: _phone,
                    decoration: new InputDecoration(labelText: "Phone"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  ),
                  TextField(
                    controller: _email,
                    decoration: new InputDecoration(labelText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                    // inputFormatters: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.allow(RegExp(
                    //       r"[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                    // ], // Only numbers can be entered
                  ),

                  // TextField(
                  //   decoration: InputDecoration(
                  //       hintText: 'Gender'),
                  // ),
                  SizedBox(
                    width: 300,
                    child: DropdownButton(
                        value: genderDWValue,
                        items: [
                          DropdownMenuItem(
                            child: Text("Male"),
                            value: "male",
                          ),
                          DropdownMenuItem(
                            child: Text("Female"),
                            value: "female",
                          )
                        ],
                        onChanged: (value) {
                          setState(() {
                            genderDWValue = value;
                          });
                        }),
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      try {
                        var patient = await model.registerNewPatient(
                            firstName: _firstName.text,
                            lastName: _lastName.text,
                            age: int.parse(_age.text).toString(),
                            gender: genderDWValue,
                            location: _location.text,
                            relation: _relation.text,
                            dob: DateTime.parse(_date.text),
                            phone: _phone.text,
                            email: _email.text);
                        Navigator.pop(context);
                        final snackBar = SnackBar(
                          content: Text('Patient Added'),
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
                        setState(() {});
                      } catch (e) {
                        print('assasasa');
                        Navigator.pop(context);
                        final snackBar = SnackBar(
                          content: Text('Patient Added'),
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
                        setState(() {});
                      }

                      //  Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => HomeScreen()));
                      // if(patient != null) {
                      //   showSuccessDialog(context: context);
                      // }
                    },
                    child: Text('Add'))
              ],
            ),
          );
        });
  }

  showSuccessDialog({context}) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Success"),
            content: Center(
              child: Text("Patient succesfully added"),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text("ok"))
            ],
          );
        });
  }

  showBottomSheeet({model}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.panorama_fish_eye_rounded),
                title: new Text('Cash on Delivery'),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Container(
                          child: AlertDialog(
                            title: Text("Continue with cash on delivery?"),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    String month = pickedDate.month.toString();
                                    String day = pickedDate.day.toString();
                                    

                                    if(int.parse(month) <10){
                                      month = "0$month";                                      

                                    }
                                    if(int.parse(day) <10){
                                      day = "0$day";                                      

                                    }
                                   print("check this${pickedDate.year}-${month}-${day}");
                                    ApointmentStatus status =
                                        await model.bookAppointment(
                                            doctorId: widget.doctor.id,
                                            choseDate: "${pickedDate.year}-${month}-${day}"
                                            );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) =>
                                                AppointmentSuccessScreen(
                                                  status: status,
                                                  check: check_back,
                                                )));
                                  },
                                  child: Text('Confirm Appointment')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'))
                            ],
                          ),
                        );
                      });
                },
              ),
              ListTile(
                leading: new Icon(Icons.payment),
                title: new Text('Manual Payment'),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Container(
                          child: AlertDialog(
                            title: Text("Continue with manual payment?"),
                            content: ScopedModel<SettingsScopedModel>(
                              model: SettingsScopedModel.instance,
                              child: Builder(builder: (context) {
                                SettingsScopedModel.of(context).getSettings();
                                return ScopedModelDescendant<
                                        SettingsScopedModel>(
                                    builder: (context, _, model) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Bank Name: " +
                                                model?.settings?.bankName ??
                                            "not available",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Bank Number: " +
                                                model?.settings
                                                    ?.bankAccountNumber ??
                                            "not available",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Esewa Id: " +
                                                model?.settings?.esewaId ??
                                            "not available",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  );
                                });
                              }),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                     String month = pickedDate.month.toString();
                                    String day = pickedDate.day.toString();
                                    

                                    if(int.parse(month) <10){
                                      month = "0$month";                                      

                                    }
                                    if(int.parse(day) <10){
                                      day = "0$day";                                      

                                    }
                                   print("check this${pickedDate.year}-${month}-${day}");
                                    ApointmentStatus status =
                                        await model.bookAppointment(
                                            doctorId: widget.doctor.id,
                                            choseDate: "${pickedDate.year}-${month}-${day}");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) =>
                                                AppointmentSuccessScreen(
                                                  status: status,
                                                )));
                                  },
                                  child: Text('Confirm Appointment')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'))
                            ],
                          ),
                        );
                      });
                },
              ),
            ],
          );
        });
  }
}
