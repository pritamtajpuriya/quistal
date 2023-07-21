import 'package:flutter/material.dart';
// import 'printable_data.dart';
import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:singleclinic/screens/appointment/pdf_widget/printable_data.dart';

class SaveBtnBuilder extends StatelessWidget {
  final String name;
  final String age;
  final String gender;
  final String location;
  final String relation;
  final String doctorName;
  final String dob;
  final String phone;
  final String email;

  const SaveBtnBuilder(
      {Key key,
      this.name,
      this.age,
      this.gender,
      this.location,
      this.relation,
      this.doctorName,
      this.dob,
      this.phone,
      this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(relation);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.indigo,
        primary: Colors.indigo,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: () => printDoc(
          name, age, gender, location, relation, doctorName, dob, phone, email),
      child: const Text(
        "Save as PDF",
        style: TextStyle(color: Colors.white, fontSize: 20.00),
      ),
    );
  }

  Future<void> printDoc(String name, String age, String gender, String location,
      String relation, doctorName, dob, phone, email) async {
    final image = await imageFromAssetBundle(
      "assets/logo.png",
    );

    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableData(image, name, age, gender, location,
              relation, doctorName, dob, phone, email);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}
