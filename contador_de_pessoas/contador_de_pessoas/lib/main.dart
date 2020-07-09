import 'package:flutter/material.dart';

void main() {//STATELESS NÃO RECEBE ATUALIZAÇÕES
  runApp(MaterialApp(
      title: "contador de pessoas",
      home: Home()));
}






class Home extends StatefulWidget {//STATTEFUL QUE RECEBE ATUALIZAÇÕES
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

String _infoText = "Pode entrar!";
int _people = 0;


void _changePeople(int delta){
setState(() {
  _people+= delta;
if(_people < 0){
  _infoText = "Mundo invertido!";
}else if(_people <=10){
  _infoText = "Pode entrar!";
}else{
  _infoText = "Lotado!";
}

});
}

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Image.asset(
            "images/restaurante.jpg",
            fit: BoxFit.cover,
            height: 200, width: 700,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "$_people",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Text(
                        "-1",
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                      onPressed: () {
                        _changePeople(-1);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Text(
                        "+1",
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                      onPressed: () {
                        _changePeople(1);
                      },
                    ),
                  ),
                ],
              ),
              Text(
                "$_infoText",
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 30.0),
              )
            ],
          )
        ],
      );
  }
}