import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/prescription_model.dart';
import 'package:singleclinic/services/api_service.dart';

class PrescriptionScopedModel extends Model {
  static PrescriptionScopedModel of(BuildContext context) =>
      ScopedModel.of<PrescriptionScopedModel>(context);

  PrescriptionScopedModel._();

  static PrescriptionScopedModel instance = PrescriptionScopedModel._();
  PrescriptionScopedModel() {
    getMyPrescriptions();
  }
  List<Prescription> _prescriptions = [];
  List<Prescription> get prescriptions => _prescriptions;

  ApiService service = ApiService.instance;

  getMyPrescriptions() async {
    _prescriptions = await service.getMyPrescriptions();
    notifyListeners();
  }

  updateProfile({
    String name,
    String mobile,
    String message,
    String deliveryaddress,
    File path,
  }) async {
    var data = {
      "name": name.toString(),
      "mobile": mobile.toString(),
      "message": message.toString(),
      "delivery_address": deliveryaddress.toString(),
      "path": path
    };
    return await service.uploadPrescription(data: data);
  }
}
