import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/scoped_models/cart_scoped_model.dart';
import 'package:singleclinic/screens/cart/widgets/cart_item_vertical_widget.dart';
import 'package:singleclinic/screens/shop/shop_screen.dart';
import 'package:singleclinic/utils/colors.dart';

import '../../AllText.dart';
import '../../main.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key key}) : super(key: key);
  //CartModel cartModel = CartModel();
  @override
  Widget build(BuildContext context) {
    //cartModel.getCartList();
    final address = TextEditingController();
    final city = TextEditingController();
    final zipCode = TextEditingController();
    return ScopedModel<CartModel>(
        model: CartModel.instance,
        child: Builder(builder: (context) {
          CartModel.of(context).getCartList();
          return ScopedModelDescendant<CartModel>(builder: (context, _, model) {
            return Scaffold(
              backgroundColor: Color(0xfff6f6f6),
              appBar: AppBar(
                title: Text(
                  "Cart",
                  style: GoogleFonts.poppins().copyWith(color: Colors.black),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
              bottomNavigationBar: InkWell(
                onTap: () async {
                  if (address.text == "" && city.text == "") {
                    final snackBar = SnackBar(
                      content: Text('Error please provide address'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      // action: SnackBarAction(
                      //   label: '',
                      //   disabledTextColor: Colors.white,
                      //   textColor: Colors.yellow,
                      //   onPressed: () {
                      //
                      //     //Do whatever you want
                      //   },
                      // ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    final snackBar = SnackBar(
                      content: Text('Order Placed'),
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

                    processingDialog(PLEASE_WAIT_WHILE_ORDER, context);
                    await CartModel.of(context).confirmCashOnDelivery(
                        address.text, city.text, zipCode.text);

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Order placed'),
                          content: Text('Successfully purchased the item'),
                          actions: [
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (con) => ShopScreen()));
                              },
                            ),
                          ],
                        );
                      },
                    );
                    // Navigator.pop(context);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (con) => ShopScreen()));

                  }

// Use the showAlert function to show the alert dialog
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 60,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                      child: Text(
                    "Proceed to Buy",
                    style: GoogleFonts.poppins()
                        .copyWith(color: Colors.white, fontSize: 20),
                  )),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      itemBuilder: (context, index) =>
                          OrderItemVertical(cart: model.cart[index]),
                      itemCount: model.cart.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),

                    Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Address"),
                          Expanded(
                            child: TextField(
                              controller: address,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                  hintText: "Enter your address",
                                  border: InputBorder.none,
                                  hintMaxLines: 2,
                                  hintStyle: GoogleFonts.poppins().copyWith(
                                      color: Colors.grey.withOpacity(0.8))),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("City"),
                          Expanded(
                            child: TextField(
                              controller: city,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                  hintText: "Enter your city",
                                  border: InputBorder.none,
                                  hintMaxLines: 1,
                                  hintStyle: GoogleFonts.poppins().copyWith(
                                      color: Colors.grey.withOpacity(0.8))),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Zip code"),
                          Expanded(
                            child: TextField(
                              controller: zipCode,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                  hintText: "Enter zip code",
                                  border: InputBorder.none,
                                  hintMaxLines: 1,
                                  hintStyle: GoogleFonts.poppins().copyWith(
                                      color: Colors.grey.withOpacity(0.8))),
                            ),
                          )
                        ],
                      ),
                    ),
                    //Additional Note
                    // Container(
                    //   margin: EdgeInsets.all(8),
                    //   padding: EdgeInsets.all(8),
                    //   height: 200,
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(8)),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text("Additional Text"),
                    //       Expanded(
                    //         child: TextField(
                    //           keyboardType: TextInputType.multiline,
                    //           maxLines: null,
                    //           decoration: InputDecoration(
                    //               hintText:
                    //                   "Enter any additional text regarding your order",
                    //               border: InputBorder.none,
                    //               hintMaxLines: 4,
                    //               hintStyle: GoogleFonts.poppins()
                    //                   .copyWith(
                    //                       color: Colors.grey
                    //                           .withOpacity(0.8))),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),

                    // Container(
                    //   width: double.infinity,
                    //   padding: EdgeInsets.all(12),
                    //   margin: EdgeInsets.all(8),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(16),
                    //       color: Colors.grey.withOpacity(0.2)),
                    //   child: Row(
                    //     children: [
                    //       Icon(Icons.local_offer_outlined, size: 35),
                    //       SizedBox(
                    //         width: 8,
                    //       ),
                    //       Text(
                    //         "Apply Coupon",
                    //         style: GoogleFonts.poppins().copyWith(
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 19),
                    //       ),
                    //       Spacer(),
                    //       Icon(
                    //         CupertinoIcons.arrow_right_circle,
                    //         size: 35,
                    //         color: primaryColor,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   width: double.infinity,
                    //   padding: EdgeInsets.all(12),
                    //   margin: EdgeInsets.all(8),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(16),
                    //       color: Colors.grey.withOpacity(0.2)),
                    //   child: Row(
                    //     children: [
                    //       Icon(Icons.account_balance_wallet_outlined,
                    //           size: 35),
                    //       SizedBox(
                    //         width: 8,
                    //       ),
                    //       Text(
                    //         "Wallet",
                    //         style: GoogleFonts.poppins().copyWith(
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 19),
                    //       ),
                    //       Spacer(),
                    //       Text(
                    //         "\$100",
                    //         style: GoogleFonts.poppins().copyWith(
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 16),
                    //       ),
                    //       Checkbox(value: false, onChanged: (value) {})
                    //     ],
                    //   ),
                    // ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cart Value",
                            style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          Text(
                            // "\$400",
                            "Rs " +
                                model.cart
                                    .fold(
                                        0,
                                        (previousValue, element) =>
                                            previousValue +
                                            double.parse(element.amount))
                                    .toString(),
                            style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ],
                      ),
                    ),

                    // Container(
                    //   width: double.infinity,
                    //   padding: EdgeInsets.all(12),
                    //   decoration:
                    //       BoxDecoration(color: Colors.grey.withOpacity(0.2)),
                    //   child: Row(
                    //     children: [
                    //       Icon(
                    //         Icons.location_on_outlined,
                    //         color: primaryColor,
                    //       ),
                    //       SizedBox(
                    //         width: 8,
                    //       ),
                    //       Expanded(
                    //           child: Text(
                    //         "Birtanagar Nepal 3024, 34 N.H Highway",
                    //         style: GoogleFonts.poppins().copyWith(
                    //             fontWeight: FontWeight.w500, fontSize: 16),
                    //       )),
                    //       Text(
                    //         "Change",
                    //         style: GoogleFonts.poppins().copyWith(
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 16,
                    //             color: Colors.blue),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          });
        }));
  }

  errorDialog(message, context) {
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

  processingDialog(message, context) {
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
