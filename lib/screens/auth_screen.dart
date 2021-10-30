import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wafar_cash/models/http_exception.dart';

import '../services/auth.dart';

enum AuthMode { SIGNUP, LOGIN }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(227, 83, 53, 1).withOpacity(0.9),
                  Color.fromRGBO(128, 0, 128, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: SingleChildScrollView(
                child: AuthCard(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.SIGNUP;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'name': '',
    'phone': '',
    'country': '',
    'age': '',
    'gender': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  //Method to show error message
  void _showErrorDialog(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      textAlign: TextAlign.center,
    )));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();

    //update UI
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.LOGIN) {
        await context
            .read<AuthService>()
            .login(_authData['email'], _authData['password']);
      } else {
        await context.read<AuthService>().signup(_authData);
      }
    } on FirebaseAuthException catch (error) {
    } on HttpException catch (error) {
      var errorMessage = 'Authentication problem.';
      if (error.toString().contains('EMAIL_EXISTS')) {
        throw HttpException('This email address is already used.');
      } else if (error.toString().contains('INVALID_EMAIL')) {
        throw HttpException('This is an invalid email.');
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        throw HttpException('This password is weak.');
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        throw HttpException('Could not find this email address.');
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        throw HttpException('The password is invalid.');
      }

      print('Failed with error code: $error');
      print(error.toString());

      _showErrorDialog(error.message);
    } catch (error) {
      var errorMessage = AppLocalizations.of(context).msg_auth_problem;
      _showErrorDialog(errorMessage);
    }

    //update UI
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.LOGIN) {
      setState(() {
        _authMode = AuthMode.SIGNUP;
      });
    } else {
      setState(() {
        _authMode = AuthMode.LOGIN;
      });
    }
  }

  String _gender = 'ذكر';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.SIGNUP
            ? deviceSize.height * 0.9
            : deviceSize.height * 0.7,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.SIGNUP ? 320 : 260),
        width: deviceSize.width * 0.85,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/app-logo.png',
                  height: 150,
                  width: 150,
                ),
                if (_authMode == AuthMode.SIGNUP)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'الاسم'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'الاسم مطلوب';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['name'] = value;
                    },
                  ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).email),
                  keyboardType: TextInputType.emailAddress,
                  textDirection: TextDirection.ltr,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'البريد الالكتروني مطلوب';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).password),
                  textDirection: TextDirection.ltr,
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return AppLocalizations.of(context).msg_short_password;
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                if (_authMode == AuthMode.SIGNUP)
                  TextFormField(
                    enabled: _authMode == AuthMode.SIGNUP,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).confirm_password),
                    textDirection: TextDirection.ltr,
                    obscureText: true,
                    validator: _authMode == AuthMode.SIGNUP
                        ? (value) {
                            if (value != _passwordController.text) {
                              return AppLocalizations.of(context)
                                  .msg_passwords_match;
                            } else {
                              return null;
                            }
                          }
                        : null,
                  ),
                if (_authMode == AuthMode.SIGNUP)
                  DropdownButtonFormField<String>(
                    // value: selectedGender,
                    hint: Text('البلد'),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (String newValue) {
                      setState(() {
                        _gender = newValue;
                      });
                    },
                    items: <String>[
                      'الأردن',
                      'الإمارات',
                      'البحرين',
                      'السعودية',
                      'الكويت',
                      'سلطنة عمان',
                      'قطر',
                      'مصر',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'برجاء اختيار البلد';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['country'] = value;
                    },
                  ),
                if (_authMode == AuthMode.SIGNUP)
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'رقم الهاتف (اختياري)'),
                    keyboardType: TextInputType.number,
                    textDirection: TextDirection.ltr,
                    onSaved: (value) {
                      _authData['phone'] = value;
                    },
                  ),
                if (_authMode == AuthMode.SIGNUP)
                  DropdownButtonFormField<String>(
                    // value: selectedGender,
                    hint: Text('النوع (اختياري)'),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (String newValue) {
                      setState(() {
                        _gender = newValue;
                      });
                    },
                    items: <String>['ذكر', 'أنثى']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onSaved: (value) {
                      _authData['gender'] = value == null ? 'ذكر' : value;
                    },
                  ),
                if (_authMode == AuthMode.SIGNUP)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'السن (اختياري)'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _authData['age'] = value;
                    },
                  ),
                SizedBox(height: 20),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child: Text(_authMode == AuthMode.LOGIN
                        ? AppLocalizations.of(context).login
                        : AppLocalizations.of(context).sign_up),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                SizedBox(height: 10),
                MaterialButton(
                  child: Text(
                      '${_authMode == AuthMode.LOGIN ? AppLocalizations.of(context).sign_up : AppLocalizations.of(context).login}' +
                          AppLocalizations.of(context).instead),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
