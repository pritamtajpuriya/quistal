import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:singleclinic/modals/cart_model.dart';
import 'package:singleclinic/scoped_models/cart_scoped_model.dart';
import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/utils/helper.dart';

class OrderItemVertical extends StatelessWidget {
    OrderItemVertical({Key key, this.cart}) : super(key: key);
  Cart cart;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom:
                BorderSide(width: 1, color: Colors.grey.withOpacity(0.5)))),
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
                      getImageUrl(cart.product.photo),
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
                      cart.product.name,
                      style: TextStyle(fontSize: 19),
                    ),
                    SizedBox(height: 8),
                    cart.product.offeredprice == null
                                          ? Text(
                                              "Rs ${cart.product.price.toString()}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            )
                                          : SizedBox(
                                            child: Row(
                                                children: [
                                                  Text(
                                                    "Rs ${cart.product.price.toString()}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10,
                                                        decoration: TextDecoration
                                                            .lineThrough,
                                                        color: Colors.red),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Rs ${cart.product.offeredprice.toString()}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                          ),
                    // Text(
                    //   cart.product.price,
                    //   style: GoogleFonts.poppins()
                    //       .copyWith(fontWeight: FontWeight.bold),
                    // ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                        cart.product.quantity.toString() + " Tablets in Strip"),
                  ],
                ),
              ),
              Builder(builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () async {
                          await CartModel.of(context)
                              .removeFromCart(cart.productId.toString());
                          await CartModel.of(context).getCartList();
                        },
                        icon: Icon(
                          CupertinoIcons.delete,
                          color: primaryColor,
                        )),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              cart.quantity = cart.quantity - 1;
                              if (cart.product.quantity >= cart.quantity) {
                                await CartModel.of(context).setQuantiti(
                                    cart.id.toString(),
                                    cart.quantity.toString());
                                (context as Element).markNeedsBuild();
                                await CartModel.of(context).getCartList();
                              } else if (cart.quantity < 0) {}
                            },
                            icon: Icon(
                              Icons.indeterminate_check_box_rounded,
                              color: primaryColor,
                            )),
                        Text(
                          cart.quantity.toString(),
                          style: GoogleFonts.poppins().copyWith(
                              color: primaryColor, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () async {
                              cart.quantity = cart.quantity + 1;
                              if (cart.product.quantity >= cart.quantity) {
                                await CartModel.of(context).setQuantiti(
                                    cart.id.toString(),
                                    cart.quantity.toString());
                                (context as Element).markNeedsBuild();
                                await CartModel.of(context).getCartList();
                              } else {}
                            },
                            icon: Icon(
                              Icons.add_box_sharp,
                              color: primaryColor,
                            ))
                      ],
                    ),
                  ],
                );
              })
            ],
          ),
        ));
  }
}