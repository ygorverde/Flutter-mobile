import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/tabs/home_tab.dart';
import 'package:lojavirtual/tabs/news_tab.dart';

import 'package:lojavirtual/tabs/orders_tab.dart';
import 'package:lojavirtual/tabs/places_tab.dart';
import 'package:lojavirtual/tabs/products_tab.dart';
import 'package:lojavirtual/widgets/bottom_bar_nav.dart';
import 'package:lojavirtual/widgets/cart_button.dart';
import 'package:lojavirtual/widgets/custom_drawer.dart';
 
class HomeScreen extends StatelessWidget {
  final _pageController = PageController();
 
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[ 
        Scaffold(
          body: HomeTab(), //preciso passar o produto aqui
          drawer: CustomDrawer(_pageController),
          bottomNavigationBar: BottomBarNav(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          //placestab
          appBar: AppBar(
            title: Text("Lojas"),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        ),
                Scaffold(
          //placestab
          appBar: AppBar(
            title: Text("Novidades"),
            centerTitle: true,
          ),
          body: NewsTab(),
          drawer: CustomDrawer(_pageController),
        ),
      ],
    );
  }
}