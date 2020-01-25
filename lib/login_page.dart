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
          title: Text("Login Page Flutter Firebase"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(20.0),
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          Text(
                            'Login Information',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                              onSaved: (value) => _email = value,
                              keyboardType: TextInputType.emailAddress,
                              autovalidate: true,
                              decoration:
                                  InputDecoration(labelText: "Email Address")),
                          TextFormField(
                              onSaved: (value) => _password = value,
                              obscureText: true,
                              decoration:
                                  InputDecoration(labelText: "Password")),
                          SizedBox(height: 20.0),
                          _isLoading
                              ? CircularProgressIndicator()
                              : RaisedButton(
                                  child: Text("LOGIN"),
                                  onPressed: () async {
                                    // save the fields..
                                    final form = _formKey.currentState;
                                    form.save();

                                    // Validate will return true if is valid, or false if invalid.
                                    if (form.validate()) {
                                      try {
                                        setState(() {
                                          _isLoading = true;
                                          print('state trur');
                                        });
                                        await Provider.of<AuthService>(context,
                                                listen: false)
                                            .loginUser(
                                                email: _email,
                                                password: _password,
                                                context: context);
                                        setState(() {
                                          _isLoading = false;
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
