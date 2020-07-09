import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtual/data/cart_product.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class CartModel extends Model{

UserModel user;

List <CartProduct> products = [];

String couponCode;
int discountPercentage = 0;

bool isLoading = false;

CartModel(this.user){
  if(user.isLoggedIn())
  _loadCartItems();
}

static CartModel of(BuildContext context)=> //pode acessar de qualquer parte do app
ScopedModel.of<CartModel>(context);

void addCartItem(CartProduct cartProduct){
  products.add(cartProduct);
  Firestore.instance.collection("users").document(user.firebaseUser.uid)
  .collection("cart").add(cartProduct.toMap()).then((doc){
cartProduct.cid = doc.documentID; //CID poderá ser utilizado para alteração
  });

notifyListeners();

}

void updatePrices(){
  notifyListeners();
}

void removeCartItem(CartProduct cartProduct){
Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cartProduct.cid).delete();//remove do database
products.remove(cartProduct);//remove do carrinho
notifyListeners();

}

void decProduct(CartProduct cartProduct){
cartProduct.quantity--;
Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart")
.document(cartProduct.cid).updateData(cartProduct.toMap());
notifyListeners();
}

void incProduct(CartProduct cartProduct){
cartProduct.quantity++;
Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart")
.document(cartProduct.cid).updateData(cartProduct.toMap());
notifyListeners();
}

void setCoupon(String couponcode, int discountPercentage){
  this.couponCode = couponCode;
  this.discountPercentage = discountPercentage;
}

double getProductsPrice(){
double price = 0.0;
for(CartProduct c in products){
  if(c.productData != null)
  price += c.quantity * c.productData.price;
}
return price;
}

double getShipPrice(){
return 9.99;
}

double getDiscount(){
return getProductsPrice() * discountPercentage / 100;
}

void _loadCartItems()async{
QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart")
.getDocuments();
products = query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

notifyListeners();
}

Future<String> finishOrder() async{ //Finalizar pedido
if(products.length == 0) return null;
isLoading = true;
notifyListeners();
double productsPrice = getProductsPrice();
double shipPrice = getShipPrice();
double discount = getDiscount();

DocumentReference refOrder = await Firestore.instance.collection("orders").add(
  {
    "clientId": user.firebaseUser.uid,
    "products": products.map((cartProduct) => cartProduct.toMap()).toList(),
    "shipPrice": shipPrice,
    "discount": discount,
    "totalPrice": productsPrice - discount + shipPrice,
    "status": 1,
  }
);

await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("orders").document(refOrder.documentID)
.setData({
  "orderId": refOrder.documentID
  }
);

QuerySnapshot query = await Firestore.instance.collection("users").document(refOrder.documentID)
.collection("cart").getDocuments();

for(DocumentSnapshot doc in query.documents){
  doc.reference.delete();
}
products.clear();
couponCode = null;
discountPercentage = 0;
isLoading = false;
products.clear();
notifyListeners();
return refOrder.documentID;
}


}

