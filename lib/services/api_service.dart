import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/modals/Doctor_model.dart';
import 'package:singleclinic/modals/appointment_model.dart';
import 'package:singleclinic/modals/appointment_status_model.dart';
import 'package:singleclinic/modals/cart_model.dart';
import 'package:singleclinic/modals/category_model.dart';
import 'package:singleclinic/modals/department_model.dart';
import 'package:singleclinic/modals/doctor_appointment_model.dart';
import 'package:singleclinic/modals/hospital_model.dart';
import 'package:singleclinic/modals/order_model.dart';
import 'package:singleclinic/modals/patient_model.dart';
import 'package:singleclinic/modals/prescription_model.dart';
import 'package:singleclinic/modals/product_model.dart';
import 'package:singleclinic/modals/settings_model.dart';
import 'package:singleclinic/modals/wishlist_model/wishlist_data_model.dart';
import 'package:singleclinic/utils/AppExceptions.dart';
import 'package:singleclinic/utils/constants.dart';

import '../modals/profilemodel.dart';

class ApiService {
  ApiService._();
  static final ApiService _instance = ApiService._();
  static get instance => _instance;

  Future<List<WishlistData>> getWishlist() async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${token}"
    };
    print(token);
    http.Response response = await http.get(
      Uri.parse(WISHLISTS),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return json['data']
          .map<WishlistData>((item) => WishlistData.fromJson(item))
          .toList();
    }
    print(response.body);
    throw Exception("Error");
  }

  Future<http.Response> uploadPrescription({data: const {}}) async {
    // var pref = await SharedPreferences.getInstance();
    // String token = pref.getString("token");
    // var headers = {
    //   'Accept': 'application/json',
    //   "Authorization": "Bearer ${token}"
    // };
    // http.Response response = await http.post(Uri.parse(UPDATE_PROFILE),
    //     headers: headers, body: data);
    // print(response.body);
    // if (response.statusCode == 200) {
    //   return response;
    // }
    // throw Exception("Error");
    http.Response response;
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      dynamic token = localStorage.get("token");
      print(token);

      Uri uri = Uri(
        scheme: 'https',
        host: 'sansarhealth.com',
        path: 'api/prescription/store',
      );
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      var req = http.MultipartRequest(
        'POST',
        uri,
      );

      req.fields["name"] = data["name"];
      req.fields["mobile"] = data["mobile"];
      req.fields["message"] = data["message"];
      req.fields["delivery_address"] = data["delivery_address"];

      req.headers.addAll(headers);
      File file = data["path"];

      if (file != null) {
        req
          ..headers.addAll(headers)
          ..files
              .add(await http.MultipartFile.fromPath("path", "${file.path}"));
      }
      var sRes = await req.send();

      var body = json.decode(await sRes.stream.bytesToString());
      print(body);
      print("hit");

      return body;
    } catch (e) {
      print("error");
      print(e.toString());
    }
  }

  Future<http.Response> updateUserProfile({data: const {}}) async {
    // var pref = await SharedPreferences.getInstance();
    // String token = pref.getString("token");
    // var headers = {
    //   'Accept': 'application/json',
    //   "Authorization": "Bearer ${token}"
    // };
    // http.Response response = await http.post(Uri.parse(UPDATE_PROFILE),
    //     headers: headers, body: data);
    // print(response.body);
    // if (response.statusCode == 200) {
    //   return response;
    // }
    // throw Exception("Error");
    http.Response response;
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      dynamic token = localStorage.get("token");
      print(token);

      Uri uri = Uri(
        scheme: 'https',
        host: 'sansarhealth.com',
        path: 'api/profile-update',
      );
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      var req = http.MultipartRequest(
        'POST',
        uri,
      );

      req.fields["name"] = data["name"];
      req.fields["city"] = data["city"];
      req.fields["address"] = data["address"];
      req.fields["zip_code"] = data["zip_code"];

      req.headers.addAll(headers);
      File file = data["profile_pic"];

      if (file != null) {
        req
          ..headers.addAll(headers)
          ..files.add(
              await http.MultipartFile.fromPath("profile_pic", "${file.path}"));
      }
      var sRes = await req.send();

      var body = json.decode(await sRes.stream.bytesToString());
      print(body);
      print("hit");

      return body;
    } catch (e) {
      print("error");
      print(e.toString());
    }
  }

  Future<List<Department>> getDepartments() async {
    http.Response response = await http.get(Uri.parse(DEPARTMENTS));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return json['data']['data']
          .map<Department>((item) => Department.fromMap(item))
          .toList();
    }
    throw Exception("Error");
  }

  Future<List<Prescription>> getMyPrescriptions() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    dynamic token = localStorage.get("token");
    print(token);
    http.Response response = await http.get(Uri.parse(PRESCRIPTIONS), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print("here ${response.body}");
      return json['data']
          .map<Prescription>((item) => Prescription.fromJson(item))
          .toList();
    } else {
      print(response.body);
    }
  }

  Future<Settings> getSettings() async {
    http.Response response = await http.get(Uri.parse(SETTINGS));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return Settings.fromJson(json);
    }
    throw Exception("Error");
  }

  Future<List<Doctor>> getDoctors() async {
    http.Response response = await http.get(Uri.parse(DOCTORS));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print("doctors ${response.body}");
      return json['data']['data']
          .map<Doctor>((item) => Doctor.fromMap(item))
          .toList();
    }
    throw Exception("Error");
  }

  Future<List<Doctor>> getFilteredDoctors(var data) async {
    Uri uri = Uri.parse(DOCTORS).replace(queryParameters: data);
    print(uri.toString());
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      if (json['data']['last_page'] == (int.parse(data['page']) - 1)) {
        throw NoMoreResult();
      }
      return json['data']['data']
          .map<Doctor>((item) => Doctor.fromMap(item))
          .toList();
    } else {
      print(response.statusCode);
      print("response ${response.body}");
    }
    throw Exception("Error");
  }

  Future<List<Hospital>> getHospitals(var data) async {
    http.Response response =
        await http.get(Uri.parse(HOSPITALS).replace(queryParameters: data));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      if (json['data']['last_page'] == (int.parse(data['page']) - 1)) {
        throw NoMoreResult();
      }
      return json['data']['data']
          .map<Hospital>((item) => Hospital.fromMap(item))
          .toList();
    }
    throw Exception("Error");
  }

  Future<UserDetail> getUserDetails() async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response =
        await http.get(Uri.parse(USER_DETAILS), headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body)["data"];
      return UserDetail.fromJson(json);
    } else {
      print("dasda ${response.statusCode}");
    }
    // throw Exception("Error");
  }

  /*
  getProducts()

  data = {
  "category_id":2

  }*/
  Future<List<Product>> getProducts({data = const {}}) async {
    print("try");
    Uri uri = Uri.parse(PRODUCTS).replace(queryParameters: data);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(json);
      return json['data']['data']
          .map<Product>((item) => Product.fromJson(item))
          .toList();
    }
    throw Exception("Error");
  }

  Future<List<Product>> getSubCategoryProducts({data = const {}}) async {
    print("try");
    Uri uri = Uri.parse(SUB_CATEGORY_PRODUCTS).replace(queryParameters: data);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(json);
      return json['data']['data']
          .map<Product>((item) => Product.fromJson(item))
          .toList();
    }
    throw Exception("Error");
  }

  Future<List<Product>> getAllProducts() async {
    Uri uri = Uri.parse(ALL_PRODUCTS);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return json['products']['data']
          .map<Product>((item) => Product.fromJson(item))
          .toList();
    }
    throw Exception("Error");
  }

  Future<List<Category>> getCategories() async {
    http.Response response = await http.get(Uri.parse(CATEGORIES));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return json['data']
          .map<Category>((item) => Category.fromMap(item))
          .toList();
    }
    throw Exception("Error");
  }

  Future<List<Patient>> getPatients() async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${token}"
    };
    http.Response response =
        await http.get(Uri.parse(PATIENTS), headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return json['data']
          .map<Patient>((item) => Patient.fromJson(item))
          .toList();
    }
    throw Exception("Error");
  }

  Future<Patient> registerNewPatient({data: const {}}) async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${token}"
    };
    http.Response response = await http.post(Uri.parse(REGISTER_PATIENT),
        headers: headers, body: data);
    print(response.body);
    if (response.statusCode == 200) {
      return Patient.fromJson(jsonDecode(response.body)["data"]);
    }
    throw Exception("Error");
  }

  Future<List<DoctorAppointment>> getDoctorAppointment() async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response =
        await http.get(Uri.parse(DOCTOR_APPOINTMENTS), headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json['data']
          .map<DoctorAppointment>((item) => DoctorAppointment.fromJson(item))
          .toList();
    }
    throw Exception("Error");
  }

  Future<List<Appointment>> getAppointment() async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response =
        await http.get(Uri.parse(APPOINTMENTS), headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return json['data']
          .map<Appointment>((item) => Appointment.fromJson(item))
          .toList();
    }
    throw Exception("Error");
  }

  Future<ApointmentStatus> bookAppointment({data: const {}}) async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response = await http.post(Uri.parse(BOOK_APPOINTMENT),
        headers: headers, body: data);
    print(response.body);

    if (response.statusCode == 200) {
      return ApointmentStatus.fromJson(jsonDecode(response.body));
    }
    throw Exception("Error");
  }

  Future<List<Cart>> getCart() async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response = await http.get(Uri.parse(CART), headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return json['data'].map<Cart>((item) => Cart.fromJson(item)).toList();
    }
    throw Exception("Error");
  }
/*
  data = {
  "id":2,

  }*/

  addToCart({data: const {}}) async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response =
        await http.post(Uri.parse(ADD_TO_CART), headers: headers, body: data);
    print(response.body);

    if (response.statusCode == 200) {
      {
        var json = jsonDecode(response.body);
        print(response.body);
        //return json['data'].map<Cart>((item) => Cart.fromJson(item)).toList();
      }
    }
  }

  setQuantity({data: const {}}) async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response =
        await http.post(Uri.parse(SET_QUANTITY), headers: headers, body: data);
    print(response.body);

    if (response.statusCode == 200) {
      {
        var json = jsonDecode(response.body);
        print(response.body);
        //return json['data'].map<Cart>((item) => Cart.fromJson(item)).toList();
      }
    }
  }

  removeFromCart({data: const {}}) async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response = await http.post(Uri.parse(REMOTE_FROM_CART),
        headers: headers, body: data);
    print(response.body);

    if (response.statusCode == 200) {
      {
        var json = jsonDecode(response.body);
        print(response.body);
        //return json['data'].map<Cart>((item) => Cart.fromJson(item)).toList();
      }
    }
  }

  confirmCashOnDelivery({data: const {}}) async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response = await http.post(
        Uri.parse(CONFIRM_CASH_ON_DELIVERY),
        headers: headers,
        body: data);
    print(response.body);

    if (response.statusCode == 200) {
      {
        var json = jsonDecode(response.body);
        print(response.body);
        //return json['data'].map<Cart>((item) => Cart.fromJson(item)).toList();
      }
    }
  }

  Future<List<Order>> getOrder() async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response = await http.get(Uri.parse(ODER), headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return json['data'].map<Order>((item) => Order.fromJson(item)).toList();
    }
    throw Exception("Error");
  }

  Future<List<Appointment>> getAppointmentList() async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}"
    };
    print(headers.toString());
    http.Response response =
        await http.get(Uri.parse(DOCTOR_APPOINTMENTS), headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return json['data']['data']
          .map<Appointment>((item) => Appointment.fromJson(item))
          .toList();
    }
    throw Exception("Error");
  }
}
