import 'package:ecommerce_venda/blocs/login_bloc.dart';
import 'package:ecommerce_venda/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginBloc = LoginBloc();
  TextEditingController controller;


  @override
  void initState() {
    super.initState();
    _loginBloc.outState.listen((state){
      switch (state){
        case LoginState.SUCESS:
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()));
          break;
        case LoginState.FAIL:
          showDialog(context: context,builder: (context)=>AlertDialog(
            title: Text("Erro"),
            content: Text("Você não possuí os privilégios necessários."),
            actions: <Widget>[
              FlatButton(child: Text("Ok"),onPressed: (){Navigator.of(context).pop(context);},)
            ],
          ));
          break;
        case LoginState.LOADING:
        case LoginState.IDLE:
      }
    });
  }


  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: StreamBuilder<LoginState>(
          stream: _loginBloc.outState,
          initialData: LoginState.LOADING,
          builder: (context, snapshot) {
            switch(snapshot.data){
              case LoginState.LOADING:
                return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),),);
              case LoginState.FAIL:
              case LoginState.SUCESS:
              case LoginState.IDLE:
                return Container(
                  margin: EdgeInsets.only(top: 50),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Icon(Icons.store, size: 160, color: Colors.pink),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            CustomInput(Icons.person_outline, "Usuário", controller,TextInputType.emailAddress,false,_loginBloc.outEmail,_loginBloc.changeEmail),
                            SizedBox(
                              height: 20,
                            ),
                            CustomInput(Icons.lock_outline, "Senha", controller,TextInputType.text,true,_loginBloc.outPassword,_loginBloc.changePassword),
                            StreamBuilder<bool>(
                                stream: _loginBloc.outSubmitValid,
                                builder: (context, snapshot) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 30),
                                    width: 300,
                                    height: 60,
                                    color: Colors.pink,
                                    child: RaisedButton(
                                        color: Colors.pink,
                                        disabledColor: Colors.pink[900].withAlpha(200),
                                        textColor: Colors.white,
                                        onPressed: snapshot.hasData ? _loginBloc.submit : null,
                                        child: Text(
                                          "ENTRAR",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300),
                                        )),
                                  );
                                }
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
            }

          }
      ),
    );
  }
}

