import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/data/product_data.dart';
import 'package:lojavirtual/screens/product_screen.dart';
class HomeTile extends StatelessWidget { //Categorias de produto em linhas


final ProductData product;
final DocumentSnapshot snapshot;

HomeTile(this.snapshot, this.product);

  @override
  Widget build(BuildContext context) {
    Firestore.instance.collection("home").getDocuments();
    return ListTile(
leading: CircleAvatar(
radius: 25.0,
backgroundColor: Colors.transparent,
backgroundImage: NetworkImage(snapshot.data["icon"]),
),
title: Text(snapshot.data["title"],
style: TextStyle(
 fontSize: 20.0,
 fontWeight: FontWeight.w400,
),

),
trailing: Icon(Icons.keyboard_arrow_right),
onTap: (){
  print(product.id);
  Navigator.of(context).push(
MaterialPageRoute(builder: (context)=>ProductScreen(ProductData.fromDocument(snapshot)))
  );
},
    );
  }
}