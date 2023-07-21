// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:singleclinic/main.dart';
import 'package:singleclinic/screens/LoginScreen.dart';

class NewPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;
  NewPasswordScreen({
    Key key,
    @required this.email,
    @required this.otp,
  }) : super(key: key);

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Password'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter new password',
                ),
                validator: (value) {
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
                onSaved: (value) => _password = value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 150,
                child: ElevatedButton(
                  
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      callApi();
                      // showDialog(
                      //   context: context,
                      //   builder: (context) => AlertDialog(
                      //     title: Text('Password'),
                      //     content: Text('Your new password is $_password'),
                      //     actions: [
                      //       TextButton(
                      //         onPressed: () => Navigator.of(context).pop(),
                      //         child: Text('OK'),
                      //       ),
                      //     ],
                      //   ),
                      // );
                    }
                  },
                  child: Text('Save'),
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
    print(widget.otp);
    print('${_password}');
    var request = await http.post(
        Uri.parse(
            '$SERVER_ADDRESS/api/update-password?email=${widget.email}&code=${widget.otp}&password=${_password}&c_password=${_password}'),
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
          content: Text('To many requests.'),
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
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Password'),
            content: Text('Your new password is $_password'),
            actions: [
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                ),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      print(request.reasonPhrase);
      print('error');
    }
  }
}
