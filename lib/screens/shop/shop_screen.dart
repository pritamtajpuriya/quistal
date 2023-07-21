import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/common/widgets/drawer.dart';
import 'package:singleclinic/scoped_models/product_models.dart';
import 'package:singleclinic/screens/LoginScreen.dart';
import 'package:singleclinic/screens/cart/cart_screen.dart';
import 'package:singleclinic/screens/product/product_details_screen.dart';
import 'package:singleclinic/screens/shop/shop_category_screen.dart';
import 'package:singleclinic/screens/shop/widgets/product_horizontal_item.dart';
import 'package:singleclinic/screens/shop/widgets/shop_category_item.dart';
import 'package:singleclinic/screens/shop/widgets/shop_search_bar.dart';
import 'package:singleclinic/utils/colors.dart';

import '../../scoped_models/cart_scoped_model.dart';
import '../../scoped_models/wishlist_scoped_model.dart';
import '../../wishlist_screen.dart';

class ShopScreen extends StatefulWidget {
  ProductModel productMode;
  bool isFromHome;
  static const routeName = "medicineList";

  ShopScreen({Key key, this.productMode, this.isFromHome}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String token;

  shredPre() async {
    var pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
  }

  @override
  void initState() {
    shredPre();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.productMode == null) {
      widget.productMode = ProductModel();
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff6f6f6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffFAFAFA),
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            size: 30,
            color: primaryColor,
          ),
        ),
        title: Row(
          children: [
            Image.asset(
              "assets/app_icon.png",
              width: 50,
              height: 100,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sansar Health",
                    style: TextStyle(
                        color: Color(0xff9EA7B1),
                        fontWeight: FontWeight.bold,
                        fontFamily: "dyna")),
              ],
            )
          ],
        ),
        actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Stack(
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        if (token == null) {
                          final snackBar = SnackBar(
                            content: Text('Login To Add To Cart'),
                            backgroundColor: Colors.teal,
                            behavior: SnackBarBehavior.floating,
                            action: SnackBarAction(
                              label: 'Login',
                              disabledTextColor: Colors.white,
                              textColor: Colors.yellow,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (con) => LoginScreen()));
                                //Do whatever you want
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (con) => WishlistScreen()));
                        }

                        // print(model.cart.length);
                      },
                      icon: Icon(
                        CupertinoIcons.heart,
                        color: Colors.teal,
                        size: 35,
                      )), //Container
                  Positioned(
                    top: 10,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white),
                      child: Center(
                          child: ScopedModel<WishlistModel>(
                              model: WishlistModel.instance,
                              child: Builder(builder: (context) {
                                WishlistModel.of(context).getWishlist();
                                return ScopedModelDescendant<WishlistModel>(
                                    builder: (context, _, model) {
                                  if (token == null) {
                                    return Text('0',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor));
                                  } else {
                                    print('object');
                                    print(WishlistModel.of(context)
                                        .wishlistData
                                        .length
                                        .toString());
                                    return Text(
                                        WishlistModel.of(context)
                                            .wishlistData
                                            .length
                                            .toString(),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor));
                                  }
                                  // model.getCartList();
                                });
                              }))),
                    ),
                  ),
                ],
              ),
            ),
          
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      if (token == null) {
                        final snackBar = SnackBar(
                          content: Text('Login To Add To Cart'),
                          backgroundColor: Colors.teal,
                          behavior: SnackBarBehavior.floating,
                          action: SnackBarAction(
                            label: 'Login',
                            disabledTextColor: Colors.white,
                            textColor: Colors.yellow,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (con) => LoginScreen()));
                              //Do whatever you want
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (con) => CartScreen()));
                      }

                      // print(model.cart.length);
                    },
                    icon: Icon(
                      CupertinoIcons.bag,
                      color: Colors.teal,
                      size: 35,
                    )), //Container
                Positioned(
                  top: 10,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                    child: Center(
                        child: ScopedModel<CartModel>(
                            model: CartModel.instance,
                            child: Builder(builder: (context) {
                              CartModel.of(context).getCartList();
                              return ScopedModelDescendant<CartModel>(
                                  builder: (context, _, model) {
                                if (token == null) {
                                  return Text('0',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor));
                                } else {
                                  return Text(
                                      CartModel.of(context)
                                          .cart
                                          .length
                                          .toString(),
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor));
                                }
                                // model.getCartList();
                              });
                            }))),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: ScopedModel<ProductModel>(
          model: widget.productMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShopSearchBar(),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Categories",
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => ShopCategoryScreen()));
                              },
                              child: Text("View all")),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ScopedModelDescendant<ProductModel>(
                          builder: (context, s, model) {
                        return ListView.builder(
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ShopCategoryItem(
                              category: model.categories[index],
                              onTap: () {
                                if (model.categories[index].subCategories
                                        .length >
                                    0) {
                                  ProductModel.of(context)
                                      .getProductsByCategory(model
                                          .categories[index].id
                                          .toString());
                                  return showDialog(
                                      context: context,
                                      builder: (buildContext) {
                                        return AlertDialog(
                                          title: Text("Sub Categories"),
                                          content: SizedBox(
                                            height: 300,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: model
                                                    .categories[index]
                                                    .subCategories
                                                    .length,
                                                itemBuilder:
                                                    (subContext, subIndex) {
                                                  var currentItem = model
                                                      .categories[index]
                                                      .subCategories[subIndex];
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 20.0),
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          try {
                                                            ProductModel.of(
                                                                    context)
                                                                .getProductsBySubCategory(
                                                                    currentItem
                                                                        .id
                                                                        .toString());
                                                            Navigator.pop(
                                                                context);
                                                          } catch (e) {
                                                            print(e);
                                                          }
                                                        },
                                                        child: Text(
                                                            currentItem.name)),
                                                  );
                                                }),
                                          ),
                                        );
                                      });
                                } else {
                                  print('empty');
                                }
                              },
                            ),
                          ),
                          itemCount: model.categories.length,
                          scrollDirection: Axis.horizontal,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              ScopedModelDescendant<ProductModel>(builder: (context, s, model) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ProductHorizontalItem(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => ProductDetailsScreen(
                                    product: widget.isFromHome == true
                                        ? widget.productMode.products[index]
                                        : model.products[index],
                                  )));
                    },
                    product: model.products[index],
                  ),
                  itemCount: widget.isFromHome == true
                      ? widget.productMode.products.length
                      : model.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1 / 1.4,
                      crossAxisCount: 2,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
