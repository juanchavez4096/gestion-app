
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(100),
              child: const CircularProgressIndicator(),
            ) ,
          )
        )
      )

    );
  }
}