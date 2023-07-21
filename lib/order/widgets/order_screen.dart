import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/AllText.dart';
import 'package:singleclinic/main.dart';
import 'package:singleclinic/order/order_screen.dart';

import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/utils/helper.dart';

import '../../modals/order_model.dart';
import 'package:http/http.dart' as http;

class OrderdScreen extends StatefulWidget {
  final Order order;
  const OrderdScreen({Key key, this.order}) : super(key: key);

  @override
  State<OrderdScreen> createState() => _OrderdScreenState();
}

class _OrderdScreenState extends State<OrderdScreen> {
  cancelOrder() async {
    processingDialog('Please wait while sending email');
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var request = await http.post(
        Uri.parse(
            '$SERVER_ADDRESS/api/order/cancel-order?id=${widget.order.id}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}',
        });

    // http.StreamedResponse response = await request.send();
    if (request.statusCode == 200) {
      final jsonResponse = jsonDecode(request.body);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => OrderScreen())));

      setState(() {});
    } else {
      print('Error at cancel Order');
    }
  }

  @override
  Widget build(BuildContext context) {
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
          "Order Details",
          // order.orderDetail[0].product.name,
          style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
        ),
      ),
      bottomNavigationBar: widget.order.status == 'Cancelled'
          ? Container(
              width: 50,
              height: 50,
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  cancelOrder();
                },
                child: Text("Cancel Order"),
                style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: widget.order.orderDetail.length,
                itemBuilder: (BuildContext context, int index) {
                  print(index);
                  return Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  getImageUrl(widget
                                      .order.orderDetail[index].product.photo),
                                  width: 100,
                                  fit: BoxFit.cover,
                                  height: 100,
                                )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.orderDetail[index].product.name,
                                  style: TextStyle(fontSize: 19),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Quantity: ${widget.order.orderDetail[index].product.quantity.toString()}',
                                  style: GoogleFonts.poppins()
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  widget.order.orderDetail[index].product
                                      .description
                                      .toString(),
                                  style: GoogleFonts.poppins()
                                      .copyWith(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  widget.order.orderDetail[index].amount,
                                  style: GoogleFonts.poppins()
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
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
              SizedBox(
                height: 8,
              ),
              Text(
                "Status: " + widget.order.status,
                style: GoogleFonts.poppins()
                    .copyWith(color: primaryColor, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.order.orderDetail.length > 1
                    ? widget.order.orderDetail.length.toString() + " Products"
                    : widget.order.orderDetail.length.toString() + " Product",
                style: GoogleFonts.poppins()
                    .copyWith(color: primaryColor, fontWeight: FontWeight.bold),
              ),
              Text(
                "Total Price: " + widget.order.totalPrice.toString(),
                style: GoogleFonts.poppins()
                    .copyWith(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
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
