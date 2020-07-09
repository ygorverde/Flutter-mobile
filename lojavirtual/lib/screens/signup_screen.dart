import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';


class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
final _formKey = GlobalKey<FormState>();
final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text("CRIAR UMA NOVA CONTA"),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {

          if(model.isLoading)
          return Center(child: CircularProgressIndicator(),);

            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(hintText: "Nome Completo"),
                    controller: _nameController,
                    validator: (text) {
                      if (text.isEmpty) return "Preencha este campo";
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Endereço"),
                    controller: _addressController,
                    validator: (text) {
                      if (text.isEmpty) return "Preencha este campo";
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(hintText: "E-mail"),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "Endereço inválido";
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Senha"),
                    controller: _passController,
                    obscureText: true,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return "Senha inválida";
                    },
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                        child: Text(
                          "Criar conta",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            
                            Map<String, dynamic> userData = {
                              "name": _nameController.text,
                              "email": _emailController.text,
                              "address": _passController.text
                            };

                            model.signUp(
                                userData: userData,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail
                                );
                          }
                        }),
                  ),
                  SizedBox(height: 35.0),
                ],
              ),
            );
          },
        ));
  }

void _onSuccess(){
_scaffoldKey.currentState.showSnackBar(
  SnackBar(
    content: Text(
      "Usuário criado com sucesso!"
    , style: TextStyle(
      fontSize: 18.0,
    ),
    textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.green,
    duration: Duration(seconds: 4),
  )
);
Future.delayed(Duration(seconds: 2)).then((_){
Navigator.of(context).pop();
});
}

void _onFail(){

_scaffoldKey.currentState.showSnackBar(
  SnackBar(
    content: Text(
      "Falha ao criar o usuário"
    ),
    backgroundColor: Colors.redAccent,
    duration: Duration(seconds: 2),
  )
);


}
}

