import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import '../providers/auth_provider.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal,
              Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 1],
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 80),
            Container(
              height: 300,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    'EShop',
                    style: TextStyle(
                      fontFamily: 'Anton',
                      fontSize: 50,
                    ),
                  ),
                  Text(
                    'Kenyan Online Shop App',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lato',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: deviceSize.width > 600 ? 2 : 1,
              child: AuthCard(),
            )
          ],
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  AnimationController _animationController;
  Animation<double> _animationOpacity;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 400,
      ),
    );

    _animationOpacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
              title: Text('An Error Occurred'),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Authenticate>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
      } else {
        //Sign Up
        await Provider.of<Authenticate>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
        );
      }
    } on HttpException catch (e) {
      var errorMessage = 'Authentication Failed!';
      if (e.toString().contains('EMAIL_EXISTS')) {
        errorMessage =
            'The email address is already in use by another account.';
      } else if (e.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address.';
      } else if (e.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage =
            'No record matches credentials provided.\nPlease sign up.';
      } else if (e.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'The password is invalid.';
      } else if (e.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'The password must be 6 characters long or more.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Could not authenticate you. Please try again later';

      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _animationController.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });

      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.all(11),
      color: Colors.transparent,
      elevation: 0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInCirc,
        height: _authMode == AuthMode.Signup ? 400 : 300,
        constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.Signup ? 400 : 300,
        ),
        width: deviceSize.width,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.Signup ? 60: 0,
                    maxHeight: _authMode == AuthMode.Signup ? 120: 0,
                  ),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: FadeTransition(
                    opacity: _animationOpacity,
                    child: TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration:
                          InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match!';
                              }
                              return null;
                            }
                          : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  SizedBox(
                    width: 150,
                    child: RaisedButton(
                      child: Text(
                          _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                      onPressed: _submit,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(8.0),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'New Here? Signup' : 'Already Have An Account? Login'}'),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.all(10),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
