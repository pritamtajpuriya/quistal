import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/appointment_model.dart';
import 'package:singleclinic/services/api_service.dart';

class DoctorAppointmentScopedModel extends Model{
  List<Appointment> appointments=[];


  ApiService _apiService =ApiService.instance;






  getAppointmentList()async{
    print("Getting appointment list");
    appointments=await _apiService.getAppointmentList();
    notifyListeners();

  }
}