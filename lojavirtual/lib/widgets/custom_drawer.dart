import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/login_screen.dart';
import 'package:lojavirtual/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);




  @override
  
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(color: Colors.white10
              /*gradient: LinearGradient(colors: [
            Color.fromARGB(255, 203, 236, 241),
            Colors.white
          ], begin: Alignment.topCenter,
           end: Alignment.bottomCenter
           )*/
              ),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: 20.0,
                        left: 8.0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 55),
                          child: ScopedModelDescendant<UserModel>(
                            builder: (context, child, model){
                              return Column(
                                children: <Widget>[
                                  CircleAvatar(
                                    maxRadius: 40.0,
                                    backgroundImage: NetworkImage(model.firebaseUser.toString()),
                                  ),
                                ],
                              );
                            },
                          ),
                         /* child: CircleAvatar(
                            maxRadius: 40,
                            backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ-9sjCSSxT3SMUUuCiQOA4A9Zi1UqIw2oQh4Cz_0VwW90yuDlU"),
                          ),*/
                        ) 
                        ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              child: Text(
                                  !model.isLoggedIn()
                                      ? "Entre ou Cadastre-se"
                                      : "Sair",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                              onTap: () {
                                if (!model.isLoggedIn())
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                                else
                                  model.signOut();
                              },
                            )
                          ],
                        );
                      }),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.location_on, "Lojas", pageController, 2),
                                DrawerTile(Icons.card_travel, "Meus Pedidos", pageController, 3),
                                DrawerTile(Icons.new_releases, "Novidades", pageController, 4),
            ],
          )
        ],
      ),
    );
  }
}
