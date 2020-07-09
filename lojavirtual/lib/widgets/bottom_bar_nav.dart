import 'package:flutter/material.dart';
import 'package:lojavirtual/screens/home_screen.dart';
 
class BottomBarNav extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
//        color: Color.fromRGBO(58, 66, 86, 1.0),
      color: Colors.red[400],
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomeScreen())
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.format_list_bulleted, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.location_on, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}