import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/hospital_model.dart';
import 'package:singleclinic/services/api_service.dart';
import 'package:singleclinic/utils/AppExceptions.dart';

class HospitalScopedModel extends Model {
  static HospitalScopedModel of(BuildContext context) =>
      ScopedModel.of<HospitalScopedModel>(context);

  HospitalScopedModel._();

  static HospitalScopedModel instance = HospitalScopedModel._();
  List<Hospital> _hospitalList = [];

  List<Hospital> get hospitalList => _hospitalList;

  int _currentPage = 1;
  RefreshController hospitalRefreshController = RefreshController();

  ApiService _apiService = ApiService.instance;

  getHospitalList(Map<String,String> data, {bool isRefresh = false}) async {
    print("Getting hospitals");
    if (isRefresh) {
      print("Refreshing list");
      _currentPage = 1;
      hospitalList.clear();
    }
    data["page"] = _currentPage.toString();
    print(data);
    try {
      var list = await _apiService.getHospitals(data );
      _currentPage++;
      hospitalList.addAll(list);
    } on NoMoreResult catch (_) {
      print("No more data");
      hospitalRefreshController.footerMode.value = LoadStatus.noMore;
    }
    notifyListeners();
  }

  onReload() {
    getHospitalList({});
  }
}
