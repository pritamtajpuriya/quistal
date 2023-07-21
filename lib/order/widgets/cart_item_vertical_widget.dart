import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:singleclinic/modals/order_model.dart';
import 'package:singleclinic/order/widgets/order_screen.dart';
import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/utils/helper.dart';

class CartItemVertical extends StatelessWidget {
  CartItemVertical({Key key, this.order}) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => OrderdScreen(
                      order: order,
                    )));
      },
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Colors.grey.withOpacity(0.5)))),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        getImageUrl(order.orderDetail[0].product.photo),
                        width: 50,
                        fit: BoxFit.cover,
                        height: 50,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.orderDetail[0].product.name,
                        style: TextStyle(fontSize: 19),
                      ),
                      SizedBox(height: 8),
                      Text(
                        order.orderDetail[0].product.quantity.toString(),
                        style: GoogleFonts.poppins()
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        order.orderDetail[0].amount,
                        style: GoogleFonts.poppins()
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Total Price: " + order.totalPrice.toString(),
                        style: GoogleFonts.poppins().copyWith(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Builder(builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // IconButton(
                      //     onPressed: () async {
                      //       await CartModel.of(context)
                      //           .removeFromCart(cart.productId.toString());
                      //       await CartModel.of(context).getCartList();
                      //     },
                      //     icon: Icon(
                      //       CupertinoIcons.delete,
                      //       color: primaryColor,
                      //     )),
                      Text(
                        "Status: " + order.status,
                        style: GoogleFonts.poppins().copyWith(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        order.orderDetail.length > 1
                            ? order.orderDetail.length.toString() + " Products"
                            : order.orderDetail.length.toString() + " Product",
                        style: GoogleFonts.poppins().copyWith(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )
                    ],
                  );
                })
              ],
            ),
          )),
    );
  }
}
