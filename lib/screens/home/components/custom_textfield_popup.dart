import 'package:flutter/material.dart';

customTextFieldForDialog({String title, var controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20,30,0,8),
        child: Text(title, style: TextStyle(fontSize: 16),),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          controller: controller,
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
  );
}