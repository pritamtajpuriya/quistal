import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:singleclinic/modals/department_model.dart';
import 'package:singleclinic/screens/doctors/doctors_list_screen.dart';
import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/utils/helper.dart';

class DepartmentItemGrid extends StatelessWidget {
  final Department data;
  const DepartmentItemGrid({Key key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorsListScreen(
              filtersMap: {
                "department_id":
                data.name.toString()
              }))
          );
        },
        child: Card(
          color: primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                getDepartmentImageUrl(
                  data.image,
                )
              ),
              Text(
                  data.name,
                style: GoogleFonts.poppins()
                    .copyWith(fontSize: 22, color: Colors.white),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
