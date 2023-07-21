import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'package:singleclinic/modals/profile_modeil.dart';
import 'package:singleclinic/services/api_service.dart';

import '../modals/profilemodel.dart';

class UserModel extends Model {
  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);
  UserModel._();

  static UserModel instance = UserModel._();

  UserModel() {
    getUserDetails();
  }
  UserDetail _user;
  UserDetail get user => _user;
  ApiService service = ApiService.instance;

  getUserDetails() async {
    _user = await service.getUserDetails();
    notifyListeners();
  }

  updateProfile({
    String name,
    String city,
    String address,
    String phoneNum,
    String zipCode,
    File profile_pic,
  }) async {
    var data = {
      "name": name.toString(),
      "city": city.toString(),
      "address": address,
      "phone_no": phoneNum.toString(),
      "zip_code": zipCode.toString(),
      "profile_pic": profile_pic
    };
    return await service.updateUserProfile(data: data);
  }
  // getServiceList()async{
  //   doctorList=await service.getDoctors();
  //   notifyListeners();
  // }
}
