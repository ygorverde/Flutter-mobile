import 'package:flutter/material.dart';

void main() {

  runApp(MaterialApp(
      title: "Contador de pessoas",
      home: Column(
        children: <Widget>[
          Text(
            "Pessoas: 0",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        
        ],
      )));
}
