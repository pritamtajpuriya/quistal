import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/common/widgets/horizontal_shimmer_list.dart';
import 'package:singleclinic/modals/hospital_model.dart';
import 'package:singleclinic/scoped_models/product_models.dart';
import 'package:singleclinic/screens/product/product_details_screen.dart';
import 'package:singleclinic/screens/shop/shop_screen.dart';
import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/utils/extensions/padding.dart';
import 'package:singleclinic/utils/helper.dart';

class ApplianceHorizontalList extends StatelessWidget {
  final String title;
  final List<Hospital> applianceList;

  const ApplianceHorizontalList({Key key, this.applianceList, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProductModel>(
      model: ProductModel.instance,
      child: Builder(builder: (context) {
        ProductModel.of(context).getAppliancesList();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins().copyWith(
                        fontSize: 17,
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w700),
                  ),
                  ScopedModel<ProductModel>(
                    model: ProductModel(),
                    child: ScopedModelDescendant<ProductModel>(
                        builder: (context, child, model) {
                      return IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            ProductModel productModel = model;
                            productModel.getProductsByCategory(11.toString());
                            print(productModel);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (con) => ShopScreen(
                                          productMode: productModel,
                                          isFromHome: true,
                                        )));
                            //   ProductModel.of(context).getProductsByCategory(
                            // model.categories[8].id.toString());
                          });
                    }),
                  ),
                ],
              ),
            ),
            ScopedModelDescendant<ProductModel>(builder: (context, v, model) {
              return model.appliances.length > 0
                  ? SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: model.appliances
                            .map(
                              (e) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => ProductDetailsScreen(
                                                product: e,
                                              )));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            getImageUrl(e.photo),
                                            width: 130,
                                            height: 130,
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        e.name,
                                        style: GoogleFonts.poppins(),
                                      ),
                                      e.offeredprice == null
                                          ? Text(
                                              "Rs ${e.price.toString()}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            )
                                          : SizedBox(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Rs ${e.price.toString()}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Colors.red),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Rs ${e.offeredprice.toString()}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ).p(8)
                  : HorizontalSimmerList();
            }),
          ],
        );
      }),
    );
  }
}
