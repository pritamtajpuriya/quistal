import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:singleclinic/utils/colors.dart';


class HeadingTile extends StatelessWidget {
  final String title;
  final String route;
  const HeadingTile({Key key,this.title,this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins().copyWith(fontSize: 17,color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.w700),
          ),
          IconButton(
            onPressed: () {
             Navigator.pushNamed(context,route);
            },
            icon: Icon(
              Icons.arrow_forward_ios_outlined,
              color: primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
