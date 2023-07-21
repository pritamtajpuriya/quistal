import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/cart_model.dart';
import 'package:singleclinic/services/api_service.dart';

class CartModel extends Model {
  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  CartModel._();

  static CartModel instance = CartModel._();
  CartModel() {
    //getCartList();
  }
  List<Cart> _cart = [];
  List<Cart> get cart => _cart;

  ApiService service = ApiService.instance;

  getSumAmount() {
    //cart.reduce((value, element) => null)
  }

  getCartList() async {
    _cart = await service.getCart();
    notifyListeners();
  }

  addToCart(int id, int quantity) async {
    //FormData formData = FormData.fromMap({"id": id, "quantity": quantity});
    dynamic data = await service.addToCart(
        data: {"id": id.toString(), "quantity": quantity.toString()});
    notifyListeners();
  }

  setQuantiti(String id, String quantity) async {
    //FormData formData = FormData.fromMap({"id": id, "quantity": quantity});
    try {
      dynamic data = await service.setQuantity(
          data: {"id": id.toString(), "quantity": quantity.toString()});
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  removeFromCart(String id) async {
    //FormData formData = FormData.fromMap({"id": id, "quantity": quantity});
    try {
      dynamic data = await service.removeFromCart(data: {"id": id.toString()});
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  confirmCashOnDelivery(String address, String city, String zipCode) async {
    //FormData formData = FormData.fromMap({"id": id, "quantity": quantity});
    dynamic data = await service.confirmCashOnDelivery(
        data: {"address": address, "city": city, "zip_code": zipCode});
    notifyListeners();
  }
}
