import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/main.dart';
import 'package:singleclinic/modals/product_model.dart';
import 'package:singleclinic/scoped_models/cart_scoped_model.dart';
import 'package:singleclinic/scoped_models/product_models.dart';
import 'package:singleclinic/screens/LoginScreen.dart';
import 'package:singleclinic/screens/cart/cart_screen.dart';
import 'package:singleclinic/screens/shop/shop_screen.dart';
import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/utils/helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({Key key, this.product}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String _name;
  String _phone;
  String _email;
  String _message;
  void _showFormPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Get Quotes'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  _name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  ],
 
                onChanged: (value) {
                  _phone = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  _email = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Message'),
                onChanged: (value) {
                  _message = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Get Quote'),
              onPressed: () {
                if (_name == null ||
                    _phone == null ||
                    _email == null ||
                    _message == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Please fill all the form fields",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else{
                    print(_name);
                print(_phone);
                print(_email);
                print(_message);
                quotesApi();
                final snackBar = SnackBar(
                  content: Text('Quotes Added'),
                  backgroundColor: Colors.teal,
                  behavior: SnackBarBehavior.floating,
                  action: SnackBarAction(
                    label: 'Dismiss',
                    disabledTextColor: Colors.white,
                    textColor: Colors.yellow,
                    onPressed: () {
                      //Do whatever you want
                    },
                  ),
                );
                _name = null;
                _message = null;
                _email = null;
                _phone = null;

                }
              
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  quotesApi() async {
    var request = await http.post(
        Uri.parse(
            '$SERVER_ADDRESS/api/quote-public/store?name=${_name}&phone=${_phone}&email=${_email}&product_id=${widget.product.id}&message=${_message}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        });
    if (request.statusCode == 200) {
      final jsonResponse = jsonDecode(request.body);
      print(jsonResponse['message']);
      final snackBar = SnackBar(
        content: Text('${jsonResponse['message']}'),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Dismiss',
          disabledTextColor: Colors.white,
          textColor: Colors.yellow,
          onPressed: () {
            //Do whatever you want
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
      setState(() {});
    } else {
      print('Error posting quotes');
    }
  }

  addWishlist() async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var request = await http.post(
        Uri.parse(
            '$SERVER_ADDRESS/api/add-to-wishlist?product_id=${widget.product.id}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}',
        });
    if (request.statusCode == 200) {
      final jsonResponse = jsonDecode(request.body);
      print(jsonResponse['message']);
      // print(request.body['message']);
      final snackBar = SnackBar(
        content: Text('${jsonResponse['message']}'),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Dismiss',
          disabledTextColor: Colors.white,
          textColor: Colors.yellow,
          onPressed: () {
            //Do whatever you want
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // print('done');
      // Navigator.pop(context);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: ((context) => OrderScreen())));

      setState(() {});
    } else {
      final jsonResponse = jsonDecode(request.body);
      print(jsonResponse['message']);
      // print(request.body['message']);
      final snackBar = SnackBar(
        content: Text('Login To Add TO Wishlist'),
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
                  builder: (context) => LoginScreen(),
                ));
            //Do whatever you want
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(token);
      print(widget.product.id);
      print('Error at wishlist');
    }
  }

  bool inwishlist = false;
  colorwishlist() async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var request = await http.post(
        Uri.parse(
            '$SERVER_ADDRESS/api/add-to-wishlist?product_id=${widget.product.id}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}',
        });

    if (request.statusCode == 200) {
      final jsonResponse = jsonDecode(request.body);
      print(jsonResponse['message']);
      if (jsonResponse['message'] == 'This product is added to Wishlist') {
        inwishlist = true;
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    colorwishlist();
    print(inwishlist);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String valQuantily = "1";
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          widget.product.name,
          style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              inwishlist == true
                  ? CupertinoIcons.heart_fill
                  : CupertinoIcons.heart,
              size: 30,
              color: primaryColor,
            ),
            onPressed: () {
              addWishlist();
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: () {
              ProductModel productModel = ProductModel();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => ShopScreen(productMode: productModel)));
            },
            style: ElevatedButton.styleFrom(
                primary: primaryColor, padding: EdgeInsets.all(20)),
            child: Text("Continue Shopping",
                style: GoogleFonts.poppins().copyWith(color: Colors.white))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              CarouselSlider(
                options: CarouselOptions(
                    height: 300.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    viewportFraction: 1),
                items: [0, 1, 2]
                    .map((e) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              getImageUrl(widget.product.photo),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.product.name,
                style: GoogleFonts.poppins()
                    .copyWith(color: Colors.black, fontSize: 19),
              ),
              Text(
                widget.product.type,
                style: GoogleFonts.poppins()
                    .copyWith(color: Colors.black, fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2))),
                    child: Builder(builder: (context) {
                      return DropdownButton(
                        value: valQuantily,
                        items: List<String>.generate(widget.product.quantity,
                            (int index) => '${index + 1}').map((val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(
                              val,
                              style: GoogleFonts.poppins()
                                  .copyWith(color: Colors.black, fontSize: 17),
                            ),
                          );
                        }).toList(),
                        underline: SizedBox(),
                        isExpanded: true,
                        onChanged: (String value) {
                          valQuantily = value;
                          (context as Element).markNeedsBuild();
                        },
                      );
                    }),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          _showFormPopUp();
                        },
                        child: Text("Get Quotes"),
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          CartModel cartModel = CartModel();
                          await cartModel.addToCart(
                              widget.product.id, int.parse(valQuantily));
                          var pref = await SharedPreferences.getInstance();
                          String token = pref.getString("token");
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
                                        builder: (context) => LoginScreen(),
                                      ));
                                  //Do whatever you want
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            final snackBar = SnackBar(
                              content: Text('Added To Cart'),
                              backgroundColor: Colors.teal,
                              behavior: SnackBarBehavior.floating,
                              action: SnackBarAction(
                                label: 'View',
                                disabledTextColor: Colors.white,
                                textColor: Colors.yellow,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CartScreen(),
                                      ));
                                  //Do whatever you want
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Text("Add to cart"),
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
              Text("Description"),
              SizedBox(
                height: 8,
              ),
              Text(widget.product.description),
              Divider(),
              Text("Price"),
              SizedBox(
                height: 8,
              ),
              widget.product.offeredprice == null
                  ? Text(
                      "Rs ${widget.product.price.toString()}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  : Row(
                      children: [
                        Text(
                          "Rs ${widget.product.price.toString()}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.red),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Rs ${widget.product.offeredprice.toString()}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
