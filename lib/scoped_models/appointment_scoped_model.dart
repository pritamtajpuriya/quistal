import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/DepartmentDetails.dart';
import 'package:singleclinic/modals/appointment_model.dart';
import 'package:singleclinic/modals/appointment_status_model.dart';
import 'package:singleclinic/modals/department_model.dart';
import 'package:singleclinic/modals/patient_model.dart';
import 'package:singleclinic/services/api_service.dart';

import '../modals/Doctor_model.dart';

class AppointmentModel extends Model{


 static AppointmentModel of(BuildContext context)=>ScopedModel.of<AppointmentModel>(context);
  List<Patient> patientsList=[];
  List<Appointment> appointmentList=[];
  List<Department> departmentList = [];
  List<Doctor> doctorList = [];
  List<Service> serviceList = [];
  Patient selectedPatient;
  Patient newPatient;
  String selectedDate;
  String selectedTime;
  ApiService service=ApiService.instance;
  AppointmentModel(){
    getPatientsList();
    getDoctorList();
    getDepartmentsList();
  }

  getDepartmentsList() async {
    departmentList = await service.getDepartments();
    notifyListeners();
  }


  getPatientsList()async{
    patientsList=await service.getPatients();
    notifyListeners();

  }
  getAppointmentList()async{
    appointmentList=await service.getAppointment();
    notifyListeners();
  }
 getDoctorList()async{
   doctorList=await service.getDoctors();
   notifyListeners();
 }
 // getServiceList()async{
 //   doctorList=await service.getDoctors();
 //   notifyListeners();
 // }

 Future<ApointmentStatus> bookAppointment({int doctorId, String choseDate})async{
    var data={
      "patient_id":selectedPatient.id.toString(),
      "doctor_id":doctorId.toString(),
      "date":choseDate.toString(),
      "time":selectedTime.toString(),

    };
   return await service.bookAppointment(data: data);


  }

  Future<Patient> registerNewPatient({
    String firstName,
    String lastName,
    String age,
    String gender,
    String location,
    String relation,
    DateTime dob,
    String phone,
    String email
  })async{
   var data={
     "first_name":firstName.toString(),
     "last_name":lastName.toString(),
     "age": age,
     "gender":gender.toString(),
     "location":location.toString(),
     "relation":relation.toString(),
     "dob":dob.toString(),
     "phone":phone.toString(),
     "email":email.toString(),
   };
   return await service.registerNewPatient(data: data);


 }


}