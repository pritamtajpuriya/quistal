import 'package:flutter/material.dart';

showLoaderDialog(BuildContext context){
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return Center(child: Container(
        height: 100, width: 100,
        decoration: BoxDecoration(
            color: Colors.transparent,
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Theme.of(context).primaryColorLight,),
      ));
    },
  );
}
