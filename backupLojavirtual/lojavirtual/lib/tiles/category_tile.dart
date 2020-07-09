import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/screens/category_screen.dart';
class CategoryTile extends StatelessWidget {

final DocumentSnapshot snapshot;

CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
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
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context)=> CategoryScreen(snapshot))
  );
},
    );
  }
}