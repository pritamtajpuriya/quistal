import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/AllText.dart';
import 'package:singleclinic/main.dart';
import 'package:singleclinic/scoped_models/cart_scoped_model.dart';
import 'package:singleclinic/scoped_models/wishlist_scoped_model.dart';
import 'package:singleclinic/screens/home/HomeScreen.dart';
import 'package:singleclinic/utils/helper.dart';
import 'package:http/http.dart' as http;

class WishlistScreen extends StatefulWidget {
  WishlistScreen({Key key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  del(index) async {
    processingDialog('Please wait product removing');
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var request = await http.post(
        Uri.parse('$SERVER_ADDRESS/api/wishlist/remove?id=${index}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}',
        });

    // http.StreamedResponse response = await request.send();
    if (request.statusCode == 200) {
      final jsonResponse = jsonDecode(request.body);
      print(jsonResponse);
      Navigator.pop(context);
    } else {
      print('Error removing wishlist products');
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<WishlistModel>(
        model: WishlistModel.instance,
        child: Builder(builder: (context) {
          WishlistModel.of(context).getWishlist();
          return ScopedModelDescendant<WishlistModel>(
              builder: (context, _, model) {
            return Scaffold(
              backgroundColor: Color(0xfff6f6f6),
              appBar: AppBar(
                title: Text(
                  "My Wishlist",
                  style: GoogleFonts.poppins().copyWith(color: Colors.black),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => HomeScreen())));
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
              body: model.wishlistData.length == 0
                  ? Center(
                      child: Text('There is no whistlist item'),
                    )
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemCount: model.wishlistData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                getImageUrl(model
                                                    .wishlistData[index].photo),
                                                width: 100,
                                                fit: BoxFit.cover,
                                                height: 100,
                                              )),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          // width: 150,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 120,
                                                child: Text(
                                                  model.wishlistData[index].name,
                                                  style: TextStyle(fontSize: 19),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'Quantity: ${model.wishlistData[index].quantity.toString()}',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              SizedBox(
                                                width: 120,
                                                child: Text(
                                                  model.wishlistData[index]
                                                      .description
                                                      .toString(),
                                                  style: GoogleFonts.poppins()
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                model.wishlistData[index]
                                                            .offerPrice
                                                            .toString() ==
                                                        'null'
                                                    ? model.wishlistData[index]
                                                        .price
                                                        .toString()
                                                    : model.wishlistData[index]
                                                        .offerPrice
                                                        .toString(),
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                         SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: IconButton(
                                            icon: Icon(Icons.shopping_bag,
                                            color: Colors.green,
                                            ),
                                            onPressed: () async{
                                              // Add your delete functionality here.
                                                CartModel cartModel = CartModel();
                          await cartModel.addToCart(
                             model.wishlistData[index].id, model.wishlistData[index].quantity);
                          var pref = await SharedPreferences.getInstance();
                                              del(model.wishlistData[index].id);
                                              setState(() {});
                                              print('${index} wishlist delete');
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40.0,
                                          height: 50.0,
                                          child: IconButton(
                                            icon: Icon(Icons.delete),
                                            color: Colors.red,
                                            onPressed: () {
                                              // Add your delete functionality here.
                                              del(model.wishlistData[index].id);
                                              setState(() {});
                                              print('${index} wishlist delete');
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Divider(),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            );
          });
        }));
  }

  errorDialog(message) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.error,
                  size: 80,
                  color: Colors.red,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  message,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  processingDialog(message) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(LOADING),
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 2,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(color: LIGHT_GREY_TEXT, fontSize: 14),
                  ),
                )
              ],
            ),
          );
        });
  }
}
