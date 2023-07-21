import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/settings_model.dart';
import 'package:singleclinic/services/api_service.dart';

class SettingsScopedModel extends Model {
  static SettingsScopedModel of(BuildContext context) =>
      ScopedModel.of<SettingsScopedModel>(context);
  SettingsScopedModel._();
  static SettingsScopedModel instance = SettingsScopedModel._();

  Settings settings;
  ApiService service = ApiService.instance;
  SettingsScopedModel() {
    getSettings();
  }

  getSettings() async {
    settings = await service.getSettings();
    notifyListeners();
  }
}
