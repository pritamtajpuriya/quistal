import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/common/widgets/heading_tile.dart';
import 'package:singleclinic/common/widgets/horizontal_shimmer_list.dart';
import 'package:singleclinic/scoped_models/doctors_model.dart';
import 'package:singleclinic/screens/appointment/appointment_booking_screen.dart';
import 'package:singleclinic/utils/extensions/padding.dart';
import 'package:singleclinic/utils/helper.dart';

class DoctorsHorizontalList extends StatelessWidget {
  const DoctorsHorizontalList({Key key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final Map<String, String> individual = {"individual":"yes"};
    print("Hello world");
    return ScopedModel<DoctorsScopedModel>(
      model: DoctorsScopedModel.instance,
      child: Builder(builder: (context) {
        print("Building Horizontal");
        DoctorsScopedModel.of(context)
            .getHomePageDoctors(individual, isRefresh: true);
        return Column(
          children: [
            HeadingTile(
              title: "Meet Our Doctors",
              route: "DoctorsListScreen",
            ),
            ScopedModelDescendant<DoctorsScopedModel>(
                builder: (context, child, model) {
              return model.homePageDoctorList.length > 0
                  ? SizedBox(
                      height: 220,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: model.homePageDoctorList
                            .map(
                              (e) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) =>
                                              DoctorAppointmentScreen(
                                                doctor: e,
                                              )));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: SizedBox(
                                    width: 130,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: e.image != null
                                            ? e.image.endsWith("g")
                                                ? Image.network(
                                                    getDoctorImageUrl(e.image),
                                                    width: 130,
                                                    height: 130,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    "assets/doctor_placeholder.jpg")
                                                    : Image.asset("assets/doctor_placeholde.jpg")),
                                        Text(
                                          e.name,
                                          style: GoogleFonts.poppins().copyWith(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              e.appointmentFee != null &&
                                                      e.appointmentFee == 0
                                                  ? "Free"
                                                  : "Rs ${e.appointmentFee ?? "Free"}",
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ).p(8)
                  : HorizontalSimmerList();
            }),
          ],
        );
      }),
    );
  }
}
