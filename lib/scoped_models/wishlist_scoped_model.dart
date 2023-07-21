import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/wishlist_model/wishlist_data_model.dart';
import 'package:singleclinic/services/api_service.dart';

class WishlistModel extends Model {
  static WishlistModel of(BuildContext context) =>
      ScopedModel.of<WishlistModel>(context);
  ApiService service = ApiService.instance;
  WishlistModel._();
  static WishlistModel instance = WishlistModel._();
  List<WishlistData> _wishlistData = [];

  List<WishlistData> get wishlistData => _wishlistData;

  WishlistModel() {
    getWishlist();
  }
  getWishlist() async {
    _wishlistData = await service.getWishlist();
    notifyListeners();
  }
}
