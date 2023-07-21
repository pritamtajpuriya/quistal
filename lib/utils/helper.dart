


import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/utils/constants.dart';


getImageUrl(fileName){
  return BASE_URL+"/public${fileName}";

}
getDoctorImageUrl(String fileName){
  return IMAGE_BASE_URL+"/doctor/${fileName}";
}
getHospitalImageUrl(String fileName){
  return IMAGE_BASE_URL+"/hospital/${fileName}";
}
getDepartmentImageUrl(String fileName){
  return IMAGE_BASE_URL+"/department/${fileName}";

}

Future<bool> isUserLoggedIn()async{
  var prefs=await SharedPreferences.getInstance();
  return prefs.getBool("isLoggedIn");

}

String getFormattedDate(DateTime dateTime){
  return DateFormat.yMMMMd().format(dateTime);
}

String getAppointmentStatus(int id){
  String status="pending";
  switch(id){
    case 0:
      status="absent";
      break;
    case 1:
      status="pending";
      break;
    case 2:
      status="reschedule";
      break;
    case 3:
      status="approved";
      break;
    case 4:
      status="completed";
      break;
    case 5:
      status="refer doc";
      break;
    case 6:
      status="reject";
      break;

  }
  return status;
}