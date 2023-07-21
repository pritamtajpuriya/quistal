import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/common/widgets/LazyLoaderFooter.dart';
import 'package:singleclinic/modals/hospital_model.dart';
import 'package:singleclinic/scoped_models/hospital_scoped_model.dart';
import 'package:singleclinic/screens/hospital/widget/hospital_item_widget_vertical.dart';
import 'package:singleclinic/utils/colors.dart';

import '../../common/widgets/drawer.dart';
import 'hospital_details_screen.dart';

class HospitalListScreen extends StatefulWidget {
  static const routeName = "hospitalList";

  const HospitalListScreen({Key key}) : super(key: key);

  @override
  State<HospitalListScreen> createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  List<Hospital> searchedHospitals;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  String _selectedValue;

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
          "Hospitals",
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

        // l
        // leading: IconButton(
        //   onPressed: () => Navigator.pop(context),
        //   icon: Icon(Icons.arrow_back_ios),
        //   color: Colors.black,
        // ),
      ),
      drawer: DrawerWidget(),
      body: ScopedModel<HospitalScopedModel>(
          model: HospitalScopedModel.instance,
          child: Builder(builder: (context) {
            HospitalScopedModel.of(context).getHospitalList(
              {},
            );
            return ScopedModelDescendant<HospitalScopedModel>(
                builder: (context, _, model) {
              if (searchedHospitals?.length != null) {
                return searchedHospitals != null
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            searchField(model),
                            ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  HospitalItemVertical(
                                hospital: searchedHospitals[index],
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => HospitalDetailsScreen(
                                                hospital:
                                                    searchedHospitals[index],
                                              )));
                                },
                              ),
                              itemCount: searchedHospitals.length,
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              } else {
                print("no earch $_selectedValue");

                return model.hospitalList.length > 0
                    ? SingleChildScrollView(
                      child: Column(
                        children: [
                          searchField(model),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: model.hospitalList.length,

                            itemBuilder: (context, index) =>
                                HospitalItemVertical(
                              hospital: model.hospitalList[index],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) =>
                                            HospitalDetailsScreen(
                                              hospital:
                                                  model.hospitalList[index],
                                            )));
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              }
            });
          })),
    );
  }

  searchHospitals(String hospitalName, HospitalScopedModel model) {
    searchedHospitals = [];
    if (_selectedValue == null) {
       model.hospitalList.forEach((e) {
      if (e.name.toLowerCase().contains(hospitalName.toLowerCase())) {
        setState(() {
          searchedHospitals.add(e);
        });
      }
        if(searchedHospitals == []){
        print("time check");
      }
    });
    }else {
      print("Here ${_selectedValue.toString()}");
      model.hospitalList.forEach((e) {
      print("Here ${e.city.name.toString()}");

      if (e.name.toLowerCase().contains(hospitalName.toLowerCase())  && e.city.name.toLowerCase().contains(_selectedValue.toLowerCase())  ) {
        setState(() {
          searchedHospitals.add(e);
        });
      }
      if(searchedHospitals == []){
        print("time check");
      }
    });
    }
   
  }

  searchHospitalsCity(String hospitalName, HospitalScopedModel model) {
    searchedHospitals = [];
    
    model.hospitalList.forEach((e) {
      if (e.city.name.toLowerCase().contains(hospitalName.toLowerCase())) {
        setState(() {
          searchedHospitals.add(e);
        });
      }
    });
  }

  searchField(HospitalScopedModel model) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Select a city"),
              SizedBox(
                width: 150,
              ),
              DropdownButton<String>(
                value: _selectedValue,
                onChanged: (String newValue) {
                  searchHospitalsCity(newValue, model);
                  setState(() {
                    _selectedValue = newValue;
                  });
                },
                items: <String>[
                  'Biratnagar',
                  'Itahari',
                  'Dharan',
                  'Duhabi',
                  'Janakpur'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
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
                searchHospitals(value, model);
              },
            ),
          ),
        ],
      ),
    );
  }
}
