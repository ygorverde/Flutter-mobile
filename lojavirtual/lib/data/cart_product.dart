import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/data/product_data.dart';

class CartProduct{

String cid; //
String category;
String pid; //Produto Items

int quantity;
String size;

ProductData productData;

CartProduct();

CartProduct.fromDocument(DocumentSnapshot document){
cid = document.documentID;
category = document.data["category"];
pid = document.data["pid"];
quantity = document.data["quantity"];
size = document.data["size"];
}

Map<String, dynamic> toMap(){//transforma em mapa
return{
"category": category,
"pid": pid,
"quantity": quantity,
"size": size,
"product": productData.toResumedMap()
  };

}  



}