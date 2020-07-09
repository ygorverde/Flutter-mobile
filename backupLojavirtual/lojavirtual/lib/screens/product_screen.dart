import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/data/cart_product.dart';
import 'package:lojavirtual/data/product_data.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/login_screen.dart';

import 'cart_screen.dart';

class ProductScreen extends StatefulWidget {

final ProductData product;
ProductScreen(this.product);


  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

final ProductData product;

String size;

_ProductScreenState(this.product);


  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url){
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: true,
              autoplayDuration: Duration(seconds: 5),
              animationDuration: Duration(seconds: 3),
              animationCurve: Curves.fastOutSlowIn,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text(product.title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  "Tamanho",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.0),
              SizedBox(
                height: 34.0,
                child: GridView(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.5,
                    ),
                    children: product.sizes.map(
                      (s){
                        return GestureDetector(
                          onTap: (){
                            setState(() {
                              size = s;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                color: s == size ? Colors.red[500] : Colors.grey[500],
                                width: 3.0,
                              )
                            ),
                            width: 50.0,
                            alignment: Alignment.center,
                            child: Text(s),
                          ),
                        );
                      }
                    ).toList(),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 40.0,
                width: 400.0,
                child: RaisedButton(
                  onPressed: size != null ? 
                  (){
                    if(UserModel.of(context).isLoggedIn()){

                      CartProduct cartProduct = CartProduct();
                      cartProduct.size = size;
                      cartProduct.quantity = 1;
                      cartProduct.pid = product.id;
                      cartProduct.category = product.category;
                      cartProduct.productData = product;

                                            CartModel.of(context).addCartItem(cartProduct);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>CartScreen())
                      );
                    
                    } else{
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>LoginScreen())
                      );
                    }
                  } : null, 
                child: Text(UserModel.of(context).isLoggedIn() ? "Adicionar ao carrinho"
                : "Entre para comprar",
                style: TextStyle(fontSize: 18.0),
                ),
                color: primaryColor,
                textColor: Colors.white,
              ),
              ),
              SizedBox(height: 16.0,),
               Text(
                  "Descrição:",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 16.0
                  ),
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}