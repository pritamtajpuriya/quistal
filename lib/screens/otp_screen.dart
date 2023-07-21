// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:singleclinic/main.dart';
import 'package:singleclinic/screens/new_password_screen.dart';

class OTPScreen extends StatefulWidget {
  String email;
  OTPScreen({
    Key key,
    @required this.email,
  }) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String OTP;

  List<TextEditingController> _pinControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  List<FocusNode> _focusNodes = List.generate(
    6,
    (_) => FocusNode(),
  );

  void _onSubmit() {
    print('OTP: ${_pinControllers.map((c) => c.text).join()}');
    OTP = _pinControllers.map((c) => c.text).join().toString();
    print(OTP);
    callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter your OTP',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                6,
                (index) => Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: _pinControllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1) {
                        int nextIndex = index + 1;
                        if (nextIndex < 6) {
                          FocusScope.of(context).requestFocus(
                            _focusNodes[nextIndex],
                          );
                        } else {
                          _onSubmit();
                          print('summit');
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  callApi() async {
    print(widget.email);
    var request = await http.post(
        Uri.parse(
            '$SERVER_ADDRESS/api/verify-token?email=${widget.email}&code=${OTP}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        });

    // http.StreamedResponse response = await request.send();

    print(request.statusCode);

    if (request.statusCode == 200) {
      final jsonResponse = jsonDecode(request.body);
      // Navigator.pop(context);
      if (jsonResponse['status'] == false) {
        final snackBar = SnackBar(
          content: Text('Wrong OTP Code.'),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Dismiss',
            disabledTextColor: Colors.white,
            textColor: Colors.yellow,
            onPressed: () {
              //Do whatever you want
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewPasswordScreen(
                    email: '${widget.email}',
                    otp: '${OTP}',
                  )),
        );
      }
    } else {
      print(request.reasonPhrase);
      print('error');
    }
  }
}
