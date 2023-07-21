import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/appointment_model.dart';
import 'package:singleclinic/scoped_models/doctor_appointmet_scoped_model.dart';
import 'package:singleclinic/screens/doctor_clinic/custom_drawer.dart';
import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/utils/helper.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  const DoctorAppointmentScreen({Key key}) : super(key: key);
  static String routeName = "doctorAppointmentScreen";

  @override
  State<DoctorAppointmentScreen> createState() =>
      _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
  TextEditingController searchController;
  Appointment appointment;
  List<DataColumn> appointmentColumns = [
    DataColumn(
        label: Text(
      "ID",
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
    )),
    DataColumn(
        label: Text(
      "Patient Name",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    )),
    DataColumn(
        label: Text(
      "Timing",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    )),
    DataColumn(
        label: Text(
      "Messages",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    )),
    DataColumn(
        label: Text(
      "Status",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    )),
    // DataColumn(
    //     label: Text(
    //       "Action",
    //       style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 18
    //       ),
    //     )
    // )
  ];

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Appointments"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ScopedModel<DoctorAppointmentScopedModel>(
          model: DoctorAppointmentScopedModel(),
          child: Builder(
            builder: (context) {
              ScopedModel.of<DoctorAppointmentScopedModel>(context,
                      rebuildOnChange: false)
                  .getAppointmentList();

              return ScopedModelDescendant<DoctorAppointmentScopedModel>(
                builder: (context, w, model) {
                  return Column(
                    children: [
                      SizedBox(
                        height: screenWidth / 10,
                      ),
                      model.appointments.isNotEmpty
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: model.appointments.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              20,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Patient Name: ${model.appointments[index].name}',
                                                style: TextStyle(fontSize: 19),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'Phone: ${model.appointments[index].phoneNo.toString()}',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                'Time: ${model.appointments[index].time}',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                'Department: ${model.appointments[index].department.name}',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                'Status: ${getAppointmentStatus(int.parse(model.appointments[index].status))}',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                'Message: ${model.appointments[index].messages == null ? 'no message' : model.appointments[index].messages}',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: 8,
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

                              // children: [
                              //   Column(
                              //     children: [Text('data')],
                              //   )
                              // ],
                            )
                          // ? customDataTable(
                          //     tableName: "Upcoming Appointments",
                          //     context: context,
                          //     dataTableColumns: appointmentColumns,
                          //     dataTableRows: model.appointments
                          //         .map(
                          //           (e) => DataRow(cells: [
                          //             DataCell(Text(e.id.toString())),
                          //             DataCell(Text(e.department.name)),

                          //             DataCell(Text("")), // Service Name
                          //             DataCell(Text(e.patient.firstName +
                          //                 " " +
                          //                 e.patient.lastName)),

                          //             DataCell(Text(e.time)),
                          //             DataCell(Text(e.messages ?? "No message")),

                          //             DataCell(Text(getAppointmentStatus(
                          //                 int.parse(e.status)))),
                          //           ]),
                          //         )
                          //         .toList(),
                          //     hasShowAll: true,
                          //     routeName: DoctorAppointmentScreen.routeName)

                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                      SizedBox(
                        height: screenWidth / 10,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
