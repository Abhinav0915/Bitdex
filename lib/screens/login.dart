import 'dart:developer';

import 'package:bitdex/constants/appcolors.dart';
import 'package:bitdex/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool _obscureText = true;
bool _isLoggedIn = false;

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool _hasInput4 = false;
  bool _hasInput5 = false;

  final _textController4 = TextEditingController();
  final _textController5 = TextEditingController();

  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _textController4.addListener(_onTextChanged4);
    _textController5.addListener(_onTextChanged5);
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        _isLoggedIn = _prefs?.getBool('loggedIn') ?? false;
      });
    });
  }

  @override
  void dispose() {
    _textController4.dispose();
    _textController5.dispose();
    super.dispose();
  }

  void _onTextChanged4() {
    setState(() {
      _hasInput4 = _textController4.text.trim().isNotEmpty;
    });
  }

  void _onTextChanged5() {
    setState(() {
      _hasInput5 = _textController5.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = _prefs?.getBool('loggedIn') ?? false;
    if (isLoggedIn) {
      return homepage();
    } else {
      return Scaffold(
          backgroundColor: AppColors.black,
          body: SingleChildScrollView(
              child: Container(
            margin: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            width: double.infinity,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 200.0,
                ),
                const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  child: SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _textController4,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                          color: AppColors.black,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 16.0),
                          isDense: true,
                          filled: true,
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          prefixIcon: Icon(Icons.mail),
                          prefixIconColor: AppColors.black,
                          prefixStyle: TextStyle(color: AppColors.black),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        maxLines: 1,
                      )),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _textController5,
                      textInputAction: TextInputAction.done,
                      obscureText: _obscureText,
                      style: const TextStyle(
                        color: AppColors.black,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 16.0),
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        prefixIcon: const Icon(Icons.key),
                        prefixIconColor: Colors.black,
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          color: AppColors.black,
                        ),
                      ),
                      maxLines: 1,
                    )),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: 250.0,
                  height: 45.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      primary: AppColors.purple,
                      onPrimary: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: _hasInput4 && _hasInput5
                        ? () {
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: _textController4.text,
                              password: _textController5.text,
                            )
                                .then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const homepage()));
                              _prefs?.setBool('loggedIn',
                                  true); // save the authentication state
                              setState(() {
                                _isLoggedIn = true;
                              });
                            }).catchError((error) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: AppColors.red,
                                      title: Text("Login Failed"),
                                      content: Text(error.message),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text("OK"),
                                          onPressed: () {
                                            print("OK");
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            });
                          }
                        : null,
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 140.0,
                    ),
                    const Text(
                      'New User?',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )));
    }
  }
}
