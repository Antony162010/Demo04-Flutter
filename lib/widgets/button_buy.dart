import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:Biconik/screens/ProductScreen.dart';

class ButtonPersonal extends StatelessWidget {
  String buttonText = "Navigate";

  ButtonPersonal(this.buttonText);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        // margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
        height: 50.0,
        width: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: LinearGradient(
            colors: [
              Color(0xFF4268D3),
              Color(0xFF584CD1),
            ],
            begin: FractionalOffset(0.2, 0.0),
            end: FractionalOffset(1.0, 0.6),
            stops: [0.0, 0.6],
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 18.0, fontFamily: "Lato", color: Colors.white),
          ),
        ),
      ),
    );
  }
}
