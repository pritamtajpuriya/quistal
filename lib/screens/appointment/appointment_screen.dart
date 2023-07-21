import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/scoped_models/appointment_scoped_model.dart';
import 'package:singleclinic/screens/appointment/widgets/appointment_widget.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      appBar: AppBar(
        title: Text("Appointments",style: GoogleFonts.poppins().copyWith(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back_ios,color:Colors.black,),

      ),

      body:ScopedModel<AppointmentModel>(
          model: AppointmentModel(),

          child: Builder(
            builder: (context) {
              print("Build done");
              AppointmentModel.of(context).getAppointmentList();
              return ScopedModelDescendant<AppointmentModel>(
                builder: (context,_,model) {
                  return ListView.builder(itemBuilder: (context,index)=>AppointmentItemWidget(
                    appointment: model.appointmentList[index],
                  ),itemCount: model.appointmentList.length,);
                }
              );
            }
          )),
    );
  }
}
