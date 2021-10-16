import 'package:flutter/material.dart';
import 'package:loja_virtual/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameControler = TextEditingController();
  final _emailControler = TextEditingController();
  final _passControler = TextEditingController();
  final _adressControler = TextEditingController();
  final _scaffolddKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffolddKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(child: CircularProgressIndicator());
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _nameControler,
                    decoration: InputDecoration(hintText: "Nome Completo"),
                    validator: (text) {
                      if (text.isEmpty) return "Nome inválido";
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailControler,
                    decoration: InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "E-mail inválido";
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passControler,
                    decoration: InputDecoration(hintText: "Senha"),
                    obscureText: true,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return "Senha inválida";
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _adressControler,
                    decoration: InputDecoration(hintText: "Endereço"),
                    validator: (text) {
                      if (text.isEmpty) return "Endereço inválida";
                    },
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Map<String, dynamic> userData = {
                            "name": _nameControler.text,
                            "email": _emailControler.text,
                            "adress": _adressControler.text
                          };
                          model.signUp(
                              userData: userData,
                              pass: _passControler.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                        }
                      },
                      child: Text("Criar Conta",
                          style: TextStyle(
                            fontSize: 18,
                          )),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  void _onSuccess() {
    _scaffolddKey.currentState.showSnackBar(
      SnackBar(
          content: Text("Usuário criado com successo!"),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 2)),
    );
    Future.delayed(Duration(seconds: 2))
        .then((value) => Navigator.of(context).pop());
  }

  void _onFail() {
    _scaffolddKey.currentState.showSnackBar(
      SnackBar(
          content: Text("Falha ao criar usuário!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2)),
    );
  }
}
