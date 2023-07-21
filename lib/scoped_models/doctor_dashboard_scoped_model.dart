import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/appointment_model.dart';
import 'package:singleclinic/services/api_service.dart';

class DoctorDashboardScopedModel extends Model{
  List<Appointment> appointments=[];


  ApiService _apiService =ApiService.instance;

  int get completedAppointments=>appointments.where((element) => element.status==4).length;
  int get pendingAppointments=>appointments.where((element) => element.status==1).length;





  getAppointmentList()async{
    print("Getting appointment list");
    appointments=await _apiService.getAppointmentList();
    notifyListeners();

  }
}