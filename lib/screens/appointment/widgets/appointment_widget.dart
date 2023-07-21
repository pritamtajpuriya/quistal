import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:singleclinic/modals/appointment_model.dart';
import 'package:singleclinic/utils/colors.dart';

class AppointmentItemWidget extends StatelessWidget {
  final Appointment appointment;

  const AppointmentItemWidget({Key key, this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String hospitalImage =
        "https://media.istockphoto.com/photos/hospital-building-picture-id510351863?k=20&m=510351863&s=612x612&w=0&h=q5uy4eA9OI27WXEYpqfZGXyJxGv0z9KmFQfcymhdhMY=";
    return Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 2)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      appointment.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 50),
                  Text(appointment.status!=1?"Active":"Done",style: GoogleFonts.poppins(color:appointment.status!=1?Colors.green:Colors.red ),),
                ],
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(appointment.time)),
              Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert_sharp,
                        color: primaryColor,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: RotatedBox(
                          child: Icon(
                            Icons.arrow_circle_down,
                            color: primaryColor,
                          ),
                          quarterTurns: -1)),
                ],
              )
            ],
          ),
        ));
  }
}
