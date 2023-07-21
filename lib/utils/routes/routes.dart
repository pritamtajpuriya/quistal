import 'package:singleclinic/main.dart';
import 'package:singleclinic/screens/ContactUsScreen.dart';
import 'package:singleclinic/screens/ForgetPassword.dart';
import 'package:singleclinic/screens/SplashScreen.dart';
import 'package:singleclinic/screens/SubscriptionPlansScreen.dart';
import 'package:singleclinic/screens/TermAndConditions.dart';
import 'package:singleclinic/screens/department/department_screen.dart';
import 'package:singleclinic/screens/doctor_clinic/doctor_appointment_screen/doctor_appointment_screen.dart';
import 'package:singleclinic/screens/doctor_clinic/doctor_chat_screen/doctor_chat_screen.dart';
import 'package:singleclinic/screens/doctors/doctors_list_screen.dart';
import 'package:singleclinic/screens/hospital/hospital_list_screen.dart';
import 'package:singleclinic/screens/shop/shop_screen.dart';

import '../../screens/doctor_clinic/doctor_dashboard_screen/doctor_dashboard_screen.dart';

class Routes {
  static var routes = {
    RootScreen.routeName: (context) => RootScreen(),
    SplashScreen.routeName: (context) => SplashScreen(),
    HospitalListScreen.routeName: (context) => HospitalListScreen(),
    DepartmentListScreen.routeName: (context) => DepartmentListScreen(),
    DoctorsListScreen.routeName: (context) => DoctorsListScreen(),
    ShopScreen.routeName: (context) => ShopScreen(),
    ContactUsScreen.routeName: (context) => ContactUsScreen(),
    TermAndConditions.routeName: (context) => TermAndConditions(),
    DoctorDashboardScreen.routeName: (context) => DoctorDashboardScreen(),
    DoctorChatScreen.routeName: (context) => DoctorChatScreen(),
    DoctorAppointmentScreen.routeName: (context) => DoctorAppointmentScreen(),
    // oldChat.ChatList.routeName: (context) => oldChat.ChatList(),
    SubscriptionPlansScreen.routeName: (context) => SubscriptionPlansScreen(),
    ForgetPassword.routeName: (context) => ForgetPassword(),
  };
}
