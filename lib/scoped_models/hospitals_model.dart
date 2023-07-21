import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/hospital_model.dart';
import 'package:singleclinic/services/api_service.dart';

class HospitalsModel extends Model {

  HospitalsModel._();
  static final HospitalsModel instance=HospitalsModel._();
  List<Hospital> hospitalList = [];
  ApiService service = ApiService.instance;

  static HospitalsModel of(BuildContext context) =>
      ScopedModel.of<HospitalsModel>(context);

  HospitalsModel() {
    getHospitalList();
  }


  getHospitalList()async {

    hospitalList=await service.getHospitals({"page":"1"});
    notifyListeners();

  }
}
