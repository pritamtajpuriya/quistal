import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/category_model.dart';
import 'package:singleclinic/modals/product_model.dart';
import 'package:singleclinic/services/api_service.dart';

class ProductModel extends Model {
  static ProductModel of(BuildContext context) =>
      ScopedModel.of<ProductModel>(context);

  ProductModel._();

  static ProductModel instance = ProductModel._();
  ProductModel() {
    getMedicinesList();
    getCategoriesList();
    getProducts();
    getAppliancesList();
  }
  List<Product> _products = [];
  List<Product> _medicines = [];
  List<Product> _appliances = [];
  List<Category> _categories = [];
  List<Product> get products => _products;
  List<Product> get medicines => _medicines;
  List<Product> get appliances => _appliances;
  List<Category> get categories => _categories;

  ApiService service = ApiService.instance;

  getMedicinesList() async {
    _medicines = await service.getProducts(data: {"category_id": "2"});
    notifyListeners();
  }

   getAppliancesList() async {
    _appliances = await service.getProducts(data: {"category_id": "11"});
    notifyListeners();
  }


  getProducts() async {
    _products = await service.getProducts(data: {"category_id": "2"});
    _products = _products + await service.getProducts(data: {"category_id": "1"});
    notifyListeners();
  }

  getAllProducts() async {
    _products = await service.getAllProducts();
    notifyListeners();
  }
  getCategoriesList() async {
    _categories = await service.getCategories();
    notifyListeners();
  }

  getProductsByCategory(String id) async {
    _products = await service.getProducts(data: {"category_id": id});
    notifyListeners();
  }

  getProductsBySubCategory(String id) async {

    _products = await service.getSubCategoryProducts(data: {"sub_category_id": id});
    notifyListeners();

  }
}