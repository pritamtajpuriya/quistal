import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/scoped_models/doctor_dashboard_scoped_model.dart';
import 'package:singleclinic/screens/doctor_clinic/custom_drawer.dart';
import 'package:singleclinic/screens/doctor_clinic/doctor_appointment_screen/doctor_appointment_screen.dart';
import 'package:singleclinic/screens/doctor_clinic/doctor_dashboard_screen/components/custom_data_table.dart';
import 'package:singleclinic/utils/colors.dart';

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({Key key}) : super(key: key);
  static String routeName = "doctorDashboardScreen";

  @override
  State<DoctorDashboardScreen> createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  List<DataColumn> latestAppointmentDataCols = [
    DataColumn(
        label: Text(
      "ID",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    )),
    DataColumn(
        label: Text(
      "Patient Name",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    )),
    DataColumn(
        label: Text(
      "Department Name",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    )),
    DataColumn(
        label: Text(
      "Service Name",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ))
  ];

  List<DashboardCategory> dashboardCategories = [
    DashboardCategory(
        categoryName: "Total Appointment",
        categoryIcon: Icon(
          CupertinoIcons.doc_person,
          color: Colors.blueAccent,
        ),
        categoryColor: Colors.blueAccent,
        categoryData: 11),
    DashboardCategory(
        categoryName: "Complete Appointment",
        categoryIcon: Icon(
          CupertinoIcons.doc_append,
          color: Colors.green,
        ),
        categoryColor: Colors.green,
        categoryData: 13),
    DashboardCategory(
        categoryName: "Pending Appointment",
        categoryIcon: Icon(
          CupertinoIcons.book,
          color: Colors.amber,
        ),
        categoryColor: Colors.amber,
        categoryData: 7),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      drawer: CustomDrawer(

      ),
      body: SingleChildScrollView(
        child: ScopedModel<DoctorDashboardScopedModel>(
            model: DoctorDashboardScopedModel(),
            child: Builder(builder: (context) {
              ScopedModel.of<DoctorDashboardScopedModel>(context,
                      rebuildOnChange: false)
                  .getAppointmentList();

              return   ScopedModelDescendant<DoctorDashboardScopedModel>(
                  builder: (context,w,model) {
                    return Column(
                    children: [
                      SizedBox(
                        height: screenWidth / 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: SizedBox(
                          height: 220,
                          child: ListView(
                            scrollDirection:Axis.horizontal ,
                            children: [
                              Container(
                                margin:EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 7,
                                          offset: Offset(3, 3))
                                    ]),
                                width: screenWidth / 2.33,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: screenWidth / 5,
                                      width: screenWidth / 5,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(color: Colors.blue)),
                                      child: Icon(Icons.file_copy_rounded),
                                    ),
                                    Text(
                                      "Total Appointments",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth / 25),
                                    ),
                                    Text(model.appointments.length.toString()),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),

                              Container(
                                margin:EdgeInsets.all(10),

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 7,
                                          offset: Offset(3, 3))
                                    ]),
                                width: screenWidth / 2.33,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: screenWidth / 5,
                                      width: screenWidth / 5,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(color: Colors.green)),
                                      child: Icon(Icons.check,color: Colors.green,),
                                    ),
                                    Text(
                                      "Completed Appointments",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth / 25),
                                    ),
                                    Text(model.completedAppointments.toString()),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              Container(
                                margin:EdgeInsets.all(10),

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 7,
                                          offset: Offset(3, 3))
                                    ]),
                                width: screenWidth / 2.33,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: screenWidth / 5,
                                      width: screenWidth / 5,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(color: Colors.yellow)),
                                      child: Icon(Icons.sim_card_download,color: Colors.yellow,),
                                    ),
                                    Text(
                                      "Pending Appointments",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth / 25),
                                    ),
                                    Text(model.pendingAppointments.toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenWidth / 10,
                      ),
                      model.appointments.isNotEmpty?  customDataTable(
                          tableName: "Upcoming Appointments",
                          context: context,
                          dataTableColumns: latestAppointmentDataCols,
                          dataTableRows: model.appointments.map((e) =>  DataRow(cells: [
                            DataCell(Text(e.id.toString())),
                            DataCell(Text(e.patient.firstName+" "+e.patient.lastName)),
                            DataCell(Text(e.department.name)),
                            DataCell(Text("")),

                          ]),).toList(),
                          hasShowAll: true,
                          routeName: DoctorAppointmentScreen.routeName):Center(child: CircularProgressIndicator(),),
                      SizedBox(
                        height: screenWidth / 10,
                      ),
                    ],
                  );
                }
              );
            })),
      ),
    );
  }
}

class DashboardCategory {
  String categoryName;
  Icon categoryIcon;
  Color categoryColor;
  var categoryData;

  DashboardCategory(
      {this.categoryName,
      this.categoryIcon,
      this.categoryColor,
      this.categoryData});
}
