import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/scoped_models/prescription_scoped_model.dart';
import 'package:singleclinic/screens/home/components/custom_textfield_popup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import '../../utils/colors.dart';

class UploadPrescription extends StatefulWidget {
  const UploadPrescription({Key key}) : super(key: key);

  @override
  State<UploadPrescription> createState() => _UploadPrescriptionState();
}

class _UploadPrescriptionState extends State<UploadPrescription> {
  TextEditingController prescriptionNameController = TextEditingController();
  TextEditingController prescriptionMobileController = TextEditingController();
  TextEditingController prescriptionMessageController = TextEditingController();
  TextEditingController prescriptionAddressController = TextEditingController();
  TextEditingController prescriptionDeliveryAddressController =
      TextEditingController();
  var imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Prescription"),
      ),
      body: ScopedModel<PrescriptionScopedModel>(
        model: PrescriptionScopedModel.instance,
        child: ScopedModelDescendant<PrescriptionScopedModel>(
            builder: (context, _, model) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   height: 50,
                //   // width: screenWidth / 1.3,
                //   decoration: BoxDecoration(
                //     color: primaryColor,
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(10.0),
                //     child: Align(
                //       alignment: Alignment.centerLeft,
                //       child: Text(
                //         "Upload Prescription",
                //         style: TextStyle(fontSize: 18),
                //       ),
                //     ),
                //   ),
                // ),
                customTextFieldForDialog(
                    title: "Name *", controller: prescriptionNameController),
                Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20,30,0,8),
        child: Text("Mobile *", style: TextStyle(fontSize: 16),),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          controller: prescriptionMobileController,
           keyboardType: TextInputType.number,
  inputFormatters: <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly,
  ],
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2
                  )
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.lightBlue,
                      width: 2
                  )
              )
          ),
        ),
      ),
    ],
  ),
                // customTextFieldForDialog(
                //     title: "Mobile", controller: prescriptionMobileController),
                customTextFieldForDialog(
                    title: "Message",
                    controller: prescriptionMessageController),
                customTextFieldForDialog(
                    title: "Delivery Address *",
                    controller: prescriptionDeliveryAddressController),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 10, 0),
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Prescription Image"),
                          SizedBox(height: 10,),
                          GestureDetector(
                            onTap: () async {
                              PickedFile pickedFile =
                                  await ImagePicker().getImage(
                                source: ImageSource.gallery,
                                maxWidth: 500,
                                maxHeight: 500,
                              );
                              if (pickedFile != null) {
                                imageFile = File(pickedFile.path);
                                setState(() {});
                              }
                            },
                            child: Container(
                              // height: screenWidth / 11,
                              width: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.black)),
                              child: Center(
                                child: Text("Choose File"),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      imageFile != null
                          ? Container(
                              width: 80,
                              height: 110,
                              // width: screenWidth / 1.1,
                              child: Image.file(
                                imageFile,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              child: Center(
                                child: Text("No file choosen"),
                              ),
                            )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                  child: GestureDetector(
                    onTap: () async {
                     
                      
                      if (prescriptionNameController.text == "" ||
                          prescriptionMobileController.text == "" ||
                          // prescriptionMessageController.text == "" ||
                          prescriptionDeliveryAddressController.text == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Please fill all the form fields",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }else{
                         Response userResponse = await model.updateProfile(
                        name: prescriptionNameController.text,
                        mobile: prescriptionMobileController.text,
                        message: prescriptionMessageController.text,
                        deliveryaddress:
                            prescriptionDeliveryAddressController.text,
                        path: imageFile,

                        
                      );
                      showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Upload Successful'),
        content: Text('Your prescription has been uploaded successfully.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
                      }
                     
                     
                    },
                    child: Center(
                      child: Container(
                        height: 40,
                        width: 230,
                        decoration: BoxDecoration(color: Colors.orange),
                        child: Center(
                          child: Text(
                            "Upload Now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
