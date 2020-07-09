import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/data/product_data.dart';
import 'package:lojavirtual/screens/category_screen.dart';
import 'package:lojavirtual/screens/product_screen.dart';
import 'package:url_launcher/url_launcher.dart';


class NewsTile extends StatelessWidget {

final DocumentSnapshot snapshot;

NewsTile(this.snapshot);


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[


          SizedBox(
            height: 140.0,
           child: Image.network(
             snapshot.data["image"],
             fit: BoxFit.cover,
           ), 
          ),


          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  snapshot.data["title"],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
              ],
            ),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
              child: Text("Acessar Produto"),
              textColor: Colors.blue,
              padding: EdgeInsets.zero,
              onPressed: (){
               Navigator.of(context).push(
    MaterialPageRoute(builder: (context)=> ProductScreen(ProductData.fromDocument(snapshot)))
  );
              },
              
              ),
            ],
          ),
        ],
      ),
    );
  }
}