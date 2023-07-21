import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/common/widgets/LazyLoaderFooter.dart';
import 'package:singleclinic/common/widgets/drawer.dart';
import 'package:singleclinic/modals/Doctor_model.dart';
import 'package:singleclinic/modals/product_model.dart';
import 'package:singleclinic/scoped_models/doctors_model.dart';
import 'package:singleclinic/screens/appointment/appointment_booking_screen.dart';
import 'package:singleclinic/screens/doctors/widget/doctor_item_widget_vertical.dart';
import 'package:singleclinic/screens/product/product_details_screen.dart';
import 'package:singleclinic/screens/shop/widgets/shop_category_item.dart';
import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/utils/helper.dart';

import '../../../scoped_models/product_models.dart';

class SearhMedical extends StatefulWidget {
  static const routeName = "SearhMedical";
  final Map<String, String> filtersMap;

  const SearhMedical({Key key, this.filtersMap}) : super(key: key);

  @override
  State<SearhMedical> createState() => _SearhMedicalState();
}

class _SearhMedicalState extends State<SearhMedical> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController searchController = TextEditingController();
  List<Product> searchedDoctors;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff6f6f6),
      appBar: AppBar(
        title: Text(
          "Search Medicines",
          style: GoogleFonts.poppins().copyWith(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
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
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios),
        //   color: Colors.black,
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      drawer: DrawerWidget(),
      body: ScopedModel<ProductModel>(
          model: ProductModel.instance,
          child: Builder(builder: (context) {
            ProductModel.of(context).getAllProducts();
            return ScopedModelDescendant<ProductModel>(
                builder: (context, _, model) {
              if (searchedDoctors?.length != null) {
                print("searching");
                return searchedDoctors.length > 0
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            searchField(model),
                            ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (c) =>
                                                  ProductDetailsScreen(
                                                    product:
                                                        searchedDoctors[index],
                                                  )));
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(.2),
                                                  spreadRadius: 2,
                                                  blurRadius: 2)
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 70,
                                                height: 70,
                                                child: ClipRRect(
                                                  child: Image.network(
                                                    getImageUrl(
                                                        searchedDoctors[index]
                                                            .photo),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      searchedDoctors[index]
                                                              .name ??
                                                          "",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .poppins()
                                                                  .fontFamily),
                                                    ),
                                                    Text("\Rs" +
                                                            searchedDoctors[
                                                                    index]
                                                                .price ??
                                                        ""),
                                                    SizedBox(
                                                        height: 30,
                                                        child: Text(
                                                          searchedDoctors[index]
                                                                  .description ??
                                                              "",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              // Column(
                                              //   children: [
                                              //     IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_sharp,color: primaryColor,)),
                                              //     IconButton(onPressed: (){}, icon: RotatedBox(child: Icon(Icons.arrow_circle_down,color: primaryColor,),quarterTurns: -1)),
                                              //
                                              //   ],
                                              // )
                                            ],
                                          ),
                                        )),
                                  )),
                              itemCount: searchedDoctors.length,
                            ),
                          ],
                        ),
                      )
                    : Center(child: CircularProgressIndicator());
              } else {
                print("default");
                return model.products.length > 0
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            searchField(model),
                            ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (c) =>
                                                  ProductDetailsScreen(
                                                    product:
                                                        model.products[index],
                                                  )));
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(.2),
                                                  spreadRadius: 2,
                                                  blurRadius: 2)
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 70,
                                                height: 70,
                                                child: ClipRRect(
                                                  child: Image.network(
                                                    getImageUrl(model
                                                        .products[index].photo),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      model.products[index]
                                                              .name ??
                                                          "",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .poppins()
                                                                  .fontFamily),
                                                    ),
                                                    Text("\Rs " +
                                                            model
                                                                .products[index]
                                                                .price ??
                                                        ""),
                                                    SizedBox(
                                                        height: 30,
                                                        child: Text(
                                                          model.products[index]
                                                                  .description ??
                                                              "",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              // Column(
                                              //   children: [
                                              //     IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_sharp,color: primaryColor,)),
                                              //     IconButton(onPressed: (){}, icon: RotatedBox(child: Icon(Icons.arrow_circle_down,color: primaryColor,),quarterTurns: -1)),
                                              //
                                              //   ],
                                              // )
                                            ],
                                          ),
                                        )),
                                  )),

                              // Container(),
                              //     DoctorItemVertical(
                              //   doctor: model.products[index].,
                              //   onTap: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (c) =>
                              //                 DoctorAppointmentScreen(
                              //                   doctor:
                              //                       model.products.[index],
                              //                 )));
                              //   },
                              // ),
                              itemCount: model.products.length,
                            ),
                          ],
                        ),
                      )
                    : Center(child: CircularProgressIndicator());
              }
            });
          })),
    );
  }

  searchDoctors(String doctorName, ProductModel model) {
    searchedDoctors = [];
    model.products.forEach((e) {
      if (e.name.toLowerCase().contains(doctorName.toLowerCase())) {
        setState(() {
          searchedDoctors.add(e);
        });
      }
    });
  }

  searchField(ProductModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 7,
                  offset: Offset(3, 3))
            ]),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none)),
          onChanged: (value) {
            searchDoctors(value, model);
          },
        ),
      ),
    );
  }
}
