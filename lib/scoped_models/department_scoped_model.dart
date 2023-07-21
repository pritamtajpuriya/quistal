import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/department_model.dart';
import 'package:singleclinic/services/api_service.dart';

class DepartmentScopedModel extends Model{

  List<Department> departmentsList=[];
  static DepartmentScopedModel of(BuildContext context)=>ScopedModel.of<DepartmentScopedModel>(context);
  DepartmentScopedModel._();
  static DepartmentScopedModel instance=DepartmentScopedModel._();
  ApiService _apiService =ApiService.instance;

  getDepartments()async{
    departmentsList=await _apiService.getDepartments();
    notifyListeners();
  }




}