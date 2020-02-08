import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gestion Costos Operativos'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 20.0),
                          const Text(
                            'Identifiquese',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            onSaved: (value) => _email = value,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(),
                              ),
                            ),
                            validator: (val) {
                              if(val.length == 0) {
                                return "El email no puede estar vacio";
                              }else if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(val)){
                                return 'El email es inválido';
                              }else{
                                return null;
                              }
                            },
                          ),
                          Padding(padding: EdgeInsets.all(5),),
                          TextFormField(
                              onSaved: (value) => _password = value,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Contraseña",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                              validator: (val) {
                                if(val.length == 0) {
                                  return "La contraseña no puede estar vacía";
                                }else{
                                  return null;
                                }
                              }),
                          const SizedBox(height: 20.0),
                          _isLoading
                              ? const CircularProgressIndicator()
                              : RaisedButton(
                                  child: const Text("LOGIN"),
                                  onPressed: () async {
                                    final form = _formKey.currentState;
                                    form.save();

                                    // Validate will return true if is valid, or false if invalid.
                                    if (form.validate()) {

                                        setState(() {
                                          _isLoading = true;
                                        });
                                        Provider.of<AuthService>(context,
                                                listen: false)
                                            .loginUser(
                                                email: _email,
                                                password: _password,
                                                context: context)
                                            .then((_) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }).catchError( (error, stacktrace) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        } );

                                    }
                                  }),
                        ],
                      ),
                    )) // <= NEW

                ),
          ),
        ));
  }
}
