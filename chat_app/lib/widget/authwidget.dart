import 'dart:io';

import 'package:flutter/material.dart';

import 'imagepicker.dart';

class auth extends StatefulWidget {
  auth({Key? key, required this.authsubmit, required this.loading, required this.loginsubmit})
      : super(key: key);
  final bool loading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
    File _userimage,
  ) authsubmit;
  final void Function(
    String email,
    String password,
    BuildContext context,
  ) loginsubmit; 
  @override
  State<auth> createState() => _authState();
}

class _authState extends State<auth> {
  final _formkey = GlobalKey<FormState>();

  String _email = '';

  String _password = '';

  String _username = '';

  bool _islogin = true;
  
  late File _userimage;
  
  void imagepick(File pickedImage) {
    _userimage = pickedImage;
  }
  void _loginsubmit (){ 
    final isValid =_formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){ 
      _formkey.currentState!.save();
      widget.loginsubmit(_email,_password,context);
    }
  }

  void _signupsubmit() {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_userimage == null && !_islogin) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Please take an image',
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF837DFF),
      ));
    }
    if (isValid) {
      _formkey.currentState!.save();
      widget.authsubmit(
        _email.trim(),
        _password.trim(),
        _username.trim(),
        _islogin,
        context,
        _userimage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 321,
              height: 253,
              padding: const EdgeInsets.only(top: 10),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: const Image(
                image: AssetImage('images/loginimagescreen.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                _islogin ? 'Login' : 'SingUp',
                style: const TextStyle(fontSize: 30, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Card(
              color: Theme.of(context).canvasColor,
              elevation: 0,
              margin: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!_islogin) userimage(pickfn: imagepick,),
                      TextFormField(
                        key: const ValueKey('email'),
                        style: const TextStyle(color: Colors.white),
                        validator: ((value) {
                          if (value == null || !value.contains('@')) {
                            return 'Enter a valid email';
                          } else {
                            return null;
                          }
                        }),
                        onSaved: ((newValue) => _email = newValue!),
                        decoration: const InputDecoration(
                            labelText: "Email",
                            labelStyle: const TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      if (!_islogin)
                        TextFormField(
                          key: const ValueKey('username'),
                          style: const TextStyle(color: Colors.white),
                          validator: ((value) {
                            if (value == null || value.length < 4) {
                              return 'Enter at  least 4 characters';
                            } else {
                              return null;
                            }
                          }),
                          onSaved: ((newValu) => _username = newValu!),
                          decoration: const InputDecoration(
                              labelText: "Username",
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white))),
                          keyboardType: TextInputType.name,
                        ),
                      TextFormField(
                        key: const ValueKey('password'),
                        style: const TextStyle(color: Colors.white),
                        validator: ((value) {
                          if (value == null || value.length < 7) {
                            return 'your password is too short';
                          } else {
                            return null;
                          }
                        }),
                        onSaved: ((newVale) => _password = newVale!),
                        decoration: const InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      if (widget.loading)
CircularProgressIndicator(
          color: Color.fromARGB(211, 251, 179, 97),
        ),                      if (!widget.loading)
                        ElevatedButton(
                            onPressed: _islogin?    _loginsubmit  : _signupsubmit,
                           style: ElevatedButton.styleFrom(
                                fixedSize: const Size(266, 49),
                                primary:
                                    const Color(0xFF837DFF),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(200))),
                            child: Text(
                              _islogin ? 'Login' : 'Sing Up',
                              style: const TextStyle(
                                  fontSize: 23, color: Colors.black),
                            )),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _islogin = !_islogin;
                            });
                          },
                          child: Text(
                            _islogin ? 'Register' : 'I already have an account',
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: _islogin ? 20 : 18,
                                fontWeight: FontWeight.w300),
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
