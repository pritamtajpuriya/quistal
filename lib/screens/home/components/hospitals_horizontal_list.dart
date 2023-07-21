import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/common/widgets/heading_tile.dart';
import 'package:singleclinic/common/widgets/horizontal_shimmer_list.dart';
import 'package:singleclinic/modals/hospital_model.dart';
import 'package:singleclinic/scoped_models/hospitals_model.dart';
import 'package:singleclinic/screens/hospital/hospital_details_screen.dart';
import 'package:singleclinic/screens/hospital/hospital_list_screen.dart';
import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/utils/constants.dart';
import 'package:singleclinic/utils/extensions/padding.dart';

class HospitalsComp extends StatelessWidget {
  final List<Hospital> hospitalList;

  const HospitalsComp({Key key, this.hospitalList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Hospital build");
    return ScopedModel<HospitalsModel>(
      model:HospitalsModel.instance,
      child: Builder(

        builder: (context) {
          ScopedModel.of<HospitalsModel>(context).getHospitalList();
          return Column(
            children: [
              HeadingTile(
                title: "Book Appointment at Hospital",
                route: HospitalListScreen.routeName,
              ),
              SizedBox(
                height: 220,
                child: ScopedModelDescendant<HospitalsModel>(

                  builder: (context,s,model) {
                    return model.hospitalList.length>0? ListView(
                      scrollDirection: Axis.horizontal,
                      children: model.hospitalList
                          .map(
                            (e) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (c)=>HospitalDetailsScreen(hospital: e,)));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: e.logo != null ? e.logo.endsWith("g") ? Image.network(
                                            BASE_URL+"/public${e.logo}",
                                            width: 130,
                                            height: 130,
                                            fit: BoxFit.cover,
                                          ): Image.asset(
                                            "assets/location.png",
                                            width: 130,
                                            height: 130,
                                          ): Image.asset(
                                            "assets/location.png",
                                            width: 130,
                                            height: 130,
                                          )
                                      ),
                                      Text(
                                        e.name,
                                        style: GoogleFonts.poppins(),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 130,
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: BorderRadius.circular(4)),
                                        child: Center(
                                            child: Text(
                                              "Book Now",
                                              style: TextStyle(color: Colors.white),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }

                          )
                          .toList(),
                    ):HorizontalSimmerList();
                  }
                ),
              ).p(8),

            ],
          );
        }
      ),
    );
  }
}
