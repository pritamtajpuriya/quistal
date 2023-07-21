import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/DepartmentDetails.dart';
import 'package:singleclinic/modals/Doctor_model.dart';
import 'package:singleclinic/modals/department_model.dart';
import 'package:singleclinic/modals/doctor_appointment_model.dart';
import 'package:singleclinic/modals/patient_model.dart';
import 'package:singleclinic/services/api_service.dart';

class DoctorAppointmentModel extends Model {
  static DoctorAppointmentModel of(BuildContext context) =>
      ScopedModel.of<DoctorAppointmentModel>(context);
  List<Patient> patientsList = [];
  List<DoctorAppointment> appointmentList = [];
  List<Department> departmentList = [];
  List<Doctor> doctorList = [];
  List<Service> serviceList = [];
  Patient selectedPatient;
  String selectedDate;
  String selectedTime;
  ApiService service = ApiService.instance;
  DoctorAppointmentModel() {
    getPatientsList();
    getDoctorList();
    getDepartmentsList();
  }

  getDepartmentsList() async {
    departmentList = await service.getDepartments();
    notifyListeners();
  }

  getPatientsList() async {
    patientsList = await service.getPatients();
    notifyListeners();
  }

  getAppointmentList() async {
    appointmentList = await service.getDoctorAppointment();
    notifyListeners();
  }

  getDoctorList() async {
    doctorList = await service.getDoctors();
    notifyListeners();
  }
}
