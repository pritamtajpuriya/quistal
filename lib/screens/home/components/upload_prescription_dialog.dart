import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/scoped_models/prescription_scoped_model.dart';
import 'package:singleclinic/screens/home/components/custom_textfield_popup.dart';
import 'package:image_picker/image_picker.dart';

showUploadPrescriptionDialog({
  var context,
  var screenWidth,
  var primaryColor,
  var prescriptionNameController,
  var prescriptionMobileController,
  var prescriptionMessageController,
  var prescriptionDeliveryAddressController,
  var imageFile,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return ScopedModel<PrescriptionScopedModel>(
          model: PrescriptionScopedModel.instance,
          child: ScopedModelDescendant<PrescriptionScopedModel>(
              builder: (context, _, model) {
            return AlertDialog(
              scrollable: true,
              backgroundColor: Colors.grey.shade300,
              contentPadding: EdgeInsets.zero,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: screenWidth / 1.3,
                    decoration: BoxDecoration(
                      color: primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Upload Prescription",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  customTextFieldForDialog(
                      title: "Name", controller: prescriptionNameController),
                  customTextFieldForDialog(
                      title: "Mobile",
                      controller: prescriptionMobileController),
                  customTextFieldForDialog(
                      title: "Message",
                      controller: prescriptionMessageController),
                  customTextFieldForDialog(
                      title: "Delivery Address",
                      controller: prescriptionDeliveryAddressController),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Profile Image"),
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
                                }
                              },
                              child: Container(
                                height: screenWidth / 11,
                                width: screenWidth / 3,
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
                                width: screenWidth / 1.1,
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
                        Response userResponse = await model.updateProfile(
                          name: prescriptionNameController.text,
                          mobile: prescriptionMobileController.text,
                          message: prescriptionMessageController.text,
                          deliveryaddress:
                              prescriptionDeliveryAddressController.text,
                          path: imageFile,
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: screenWidth / 9,
                        width: screenWidth / 2.7,
                        decoration: BoxDecoration(color: Colors.orange),
                        child: Center(
                          child: Text(
                            "Upload Now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        );
     
      });
}
