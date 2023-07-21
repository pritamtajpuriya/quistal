// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/screens/LoginScreen.dart';

class PleaseLogin extends StatefulWidget {
  String Feature;
  PleaseLogin({
    Key key,
    @required this.Feature,
  }) : super(key: key);

  @override
  State<PleaseLogin> createState() => _PleaseLoginState();
}

class _PleaseLoginState extends State<PleaseLogin> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String token;

  shredPre() async {
    var pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
    final snackBar = SnackBar(
      content: Text('Login To Use This ${widget.Feature} Feature'),
      backgroundColor: Colors.teal,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Login',
        disabledTextColor: Colors.white,
        textColor: Colors.yellow,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (con) => LoginScreen()));
          //Do whatever you want
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    shredPre();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff00BE9C),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 35,
          ),
        ),
        title: Text('Login To Use ${widget.Feature} Feature'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image(
          image: AssetImage('assets/pleaseLogin.png'),
        ),
      ),
    );
  }
}
