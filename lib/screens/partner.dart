import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:singleclinic/main.dart';
import 'package:singleclinic/screens/web_view.dart';
import 'package:singleclinic/utils/colors.dart';

class Partner extends StatefulWidget {
  Partner({Key key, this.url}) : super(key: key);
  final url;

  @override
  State<Partner> createState() => _PartnerState();
}

class _PartnerState extends State<Partner> {
  void handleWebViews(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }

  String becomeASellerUrl = "https://questal.in/become-a-seller";
  String becomeOurHealthPartnerUrl =
      "https://questal.in/become-a-health-partner";
  String becomeOurDoctorUrl = "https://questal.in/become-a-doctor";
  String uploadPrescURL = "https://questal.in/upload-prescription";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Become Our Partner'),
          leading: IconButton(
              onPressed: (() => Navigator.pop(context)),
              icon: Icon(Icons.arrow_back)),
        ),
        backgroundColor: LIGHT_GREY_SCREEN_BG,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Image(image: AssetImage('assets/partner.jpeg')),
                Text(
                    'Sansar Health is an essential tool that can significantly improve the efficiency and convenience of booking appointments for patients and healthcare providers. Our appointment booking system is designed to simplify the booking process, enabling patients to schedule appointments with their preferred doctors at their convenience, from anywhere, and at any time. With our system, patients can easily browse through available appointment slots, select the time and date that works best for them, and book the appointment with just a few clicks. Healthcare providers can easily manage their schedules, block off times when they are unavailable, and accept or decline appointments. Our system also allows for automated appointment reminders, reducing the number of no-shows and last-minute cancellations. By implementing our doctor appointment booking system, healthcare providers can save time, increase patient satisfaction, and improve overall office productivity. Join us today and experience the convenience and efficiency of our modern and user-friendly appointment booking system.',
                    style: TextStyle(
                        color: BLACK,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: (() => handleWebViews(context, becomeOurDoctorUrl)),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                      "Become our Doctor",
                      style:
                          GoogleFonts.poppins().copyWith(color: primaryColor),
                    )),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: (() => handleWebViews(context, becomeASellerUrl)),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                      "Become a Seller",
                      style:
                          GoogleFonts.poppins().copyWith(color: primaryColor),
                    )),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: (() =>
                      handleWebViews(context, becomeOurHealthPartnerUrl)),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                      "Become our Health Partner",
                      style:
                          GoogleFonts.poppins().copyWith(color: primaryColor),
                    )),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
