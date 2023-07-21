import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/common/widgets/LazyLoaderFooter.dart';
import 'package:singleclinic/modals/Doctor_model.dart';
import 'package:singleclinic/scoped_models/department_scoped_model.dart';
import 'package:singleclinic/scoped_models/hospital_doctor_model.dart';
import 'package:singleclinic/screens/appointment/appointment_booking_screen.dart';
import 'package:singleclinic/screens/doctors/widget/doctor_item_widget_vertical.dart';
import 'package:singleclinic/utils/colors.dart';

import '../../common/widgets/drawer.dart';

class SortDoctorScreen extends StatefulWidget {
  static const routeName = "SortDoctorScreen";
  final Map<String, String> filtersMap;
  final String departmen_id;

  const SortDoctorScreen({Key key, this.filtersMap, this.departmen_id})
      : super(key: key);

  @override
  State<SortDoctorScreen> createState() => _SortDoctorScreenState();
}

class _SortDoctorScreenState extends State<SortDoctorScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController searchController = TextEditingController();
  List<Doctor> searchedDoctors;
  String _selectedValue;

  // ourDepartment() async {
  //   if (widget.filtersMap != null) {
  //     String currentId = widget.filtersMap['department_id'];
  //     await DepartmentScopedModel.instance.getDepartments();
  //     for (Department department
  //         in DepartmentScopedModel.instance.departmentsList) {
  //       print(currentId);
  //       print(department.id);
  //       if (currentId == department.id.toString()) {
  //         print("chiryo");
  //         if (department?.name != null) {
  //           _selectedValue = department.name.toLowerCase();
  //         } else {
  //           print("not found");
  //         }
  //         break;
  //       } else {
  //         print("chierena");
  //       }
  //     }
  //     searchDoctorsDepartment(
  //         _selectedValue.toLowerCase(), HospitalDoctorsScopedModel.instance);
  //     setState(() {});
  //   }
  // }

  @override
  void initState() {
    if (widget.departmen_id != null) {
      String text = widget.filtersMap.toString();
      text = text.replaceAll('{department_id: ', '').replaceAll('}', '');
      print("this is ${text}");
      _selectedValue = widget.departmen_id.toLowerCase();
    }
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xfff6f6f6),
        appBar: AppBar(
          title: Text(
            "Doctors",
            style: GoogleFonts.poppins().copyWith(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: 30,
              color: primaryColor,
            ),
          ),
        ),
        drawer: DrawerWidget(),
        body: ScopedModel<HospitalDoctorsScopedModel>(
            model: HospitalDoctorsScopedModel.instance,
            child: Builder(builder: (context) {
              print("Getting doctors from doctors screen");

              HospitalDoctorsScopedModel.of(context)
                  .getDoctors(widget.filtersMap, isRefresh: true);
              return ScopedModelDescendant<HospitalDoctorsScopedModel>(
                  builder: (context, _, model) {
                searchedDoctors = [];
                searchedDoctors.clear();

                model.doctorsList.forEach((e) {
                  if (e.department != null) {
                    print(e.department.name);
                    if (e.department.name.toLowerCase() ==
                        (_selectedValue.toLowerCase())) {
                      print("random");
                      searchedDoctors.add(e);
                      print(searchedDoctors.length);
                    }
                  }
                  // if (e.name.toLowerCase().contains(_selectedValue.toLowerCase())) {
                  //     searchedDoctors.add(e);
                  // }
                });
                searchedDoctors.toSet().toList();

                print("this is $searchedDoctors");
                if (searchedDoctors?.length != null) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        // searchField(model),
                        searchedDoctors.length > 0
                            ? ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    DoctorItemVertical(
                                  doctor: searchedDoctors[index],
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) =>
                                                DoctorAppointmentScreen(
                                                  doctor:
                                                      searchedDoctors[index],
                                                  back: false,
                                                )));
                                  },
                                ),
                                itemCount: searchedDoctors.length,
                              )
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 250.0),
                                  child: Text('Looking for available doctors'),
                                ),
                              ),
                      ],
                    ),
                  );
                } else {
                  return model.doctorsList.length > 0
                      ? SmartRefresher(
                          enablePullDown: false,
                          enablePullUp: true,
                          controller: model.doctorRefreshController =
                              RefreshController(initialRefresh: true),
                          onLoading: model.onFilteredLoad,
                          footer: LazyLoaderFooter(),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // searchField(model),
                                ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      DoctorItemVertical(
                                    doctor: model.doctorsList[index],
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (c) =>
                                                  DoctorAppointmentScreen(
                                                    doctor: model
                                                        .doctorsList[index],
                                                  back: false,
                                                  )));
                                    },
                                  ),
                                  itemCount: model.doctorsList.length,
                                ),
                              ],
                            ),
                          ))
                      : Center(child: CircularProgressIndicator());
                }
              });
            })));
  }

  searchDoctors(String doctorName, HospitalDoctorsScopedModel model) {
    searchedDoctors = [];
    model.doctorsList.forEach((e) {
      if (e.name.toLowerCase().contains(doctorName.toLowerCase())) {
        setState(() {
          searchedDoctors.add(e);
        });
      }
    });
  }

  searchDoctorsDepartment(String doctorName, HospitalDoctorsScopedModel model) {
    searchedDoctors = [];
    model.doctorsList.forEach((e) {
      if (e.department != null) {
        if (e.department.name.toLowerCase() == (doctorName.toLowerCase())) {
          setState(() {
            searchedDoctors.add(e);
          });
        }
      }
    });
  }

  searchField(HospitalDoctorsScopedModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Select a department"),
              ScopedModel<DepartmentScopedModel>(
                  model: DepartmentScopedModel.instance,
                  child: Builder(builder: (context) {
                    DepartmentScopedModel.of(context).getDepartments();
                    return ScopedModelDescendant<DepartmentScopedModel>(
                        builder: (context, _, departmentModel) {
                      return DropdownButton<String>(
                        value: _selectedValue,
                        onChanged: (String newValue) {
                          searchDoctorsDepartment(newValue, model);
                          _selectedValue = newValue.toLowerCase();
                          setState(() {});
                        },
                        items: departmentModel.departmentsList
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value.name.toLowerCase(),
                            child: Text(value.name.toLowerCase()),
                          );
                        }).toList(),
                      );
                    });
                  })),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 7,
                      offset: Offset(3, 3))
                ]),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none)),
              onChanged: (value) {
                searchDoctors(value, model);
              },
            ),
          ),
        ],
      ),
    );
  }
}
