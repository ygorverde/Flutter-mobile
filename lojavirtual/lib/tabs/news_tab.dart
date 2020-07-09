import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/tiles/category_tile.dart';
import 'package:lojavirtual/tiles/news_tile.dart';

class NewsTab extends StatelessWidget { //CAMISETAS, CALÇAS, CAMISAS.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("home").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {

          var dividedTiles = ListTile.divideTiles(
                  tiles: snapshot.data.documents.map((doc) {
                    return NewsTile(doc);
                    
                  }).toList(),
                  color: Colors.black)
              .toList();
          return ListView(
            children: dividedTiles,
          );
        }
      },
    );
  }
}
