
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lojavirtual/data/product_data.dart';
import 'package:lojavirtual/screens/cart_screen.dart';
import 'package:lojavirtual/screens/category_screen.dart';
import 'package:lojavirtual/screens/product_screen.dart';
import 'package:lojavirtual/tiles/category_tile.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    Widget _buildBodyBack() => Container( 
          decoration: BoxDecoration(
            color: Colors.black,
          ),
        );


    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(	
          
          slivers: <Widget>[
            SliverAppBar(
              actions: <Widget>[
                IconButton(
                  
                  icon: Icon(Icons.shopping_cart),
                  onPressed: (){
                            Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>CartScreen())
        );
                  }
                ),
              ],
              floating: false,
              snap: false,
              backgroundColor: Colors.black,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("ySHOES", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25, color: Colors.grey[400]),
                ),
                centerTitle: true,
              ),
            ),

            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance.collection("home").orderBy("pos").getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return SliverToBoxAdapter(
                      child: Container(
                    height: 200.0,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                  );
                else
                  return SliverStaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0.5,
                    crossAxisSpacing: 1.0,
                    staggeredTiles: snapshot.data.documents.map((doc) {
                      return StaggeredTile.count(doc.data["x"], doc.data["y"]);
                    }).toList(),
                    
                    children: snapshot.data.documents.map((doc) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
    MaterialPageRoute(builder: (context)=> ProductScreen(ProductData.fromDocument(doc)))
  );
            },
                         child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage, 
                          image: doc.data["image"],
                          fit: BoxFit.cover,
                          ),
                      );
                    }).toList(),
                  );
              },
            ),
          ],
        ),
      ],
    );
  }
}
