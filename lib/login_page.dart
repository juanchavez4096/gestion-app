import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';

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
                            'Login Information',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 20.0),
                          TextFormField(
                              onSaved: (value) => _email = value,
                              keyboardType: TextInputType.emailAddress,
                              autovalidate: true,
                              decoration:
                                  const InputDecoration(labelText: "Email Address")),
                          TextFormField(
                              onSaved: (value) => _password = value,
                              obscureText: true,
                              decoration: const InputDecoration(labelText: "Password")),
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
                                      try {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        Provider.of<AuthService>(context,
                                                listen: false)
                                            .loginUser(
                                                email: _email,
                                                password: _password,
                                                context: context).then((_) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        });

                                      } catch (e) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
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
