import 'package:bitdex/constants/appcolors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


bool _obscureText = true;

// final passwordController = TextEditingController();

class MultiController {
  final _textController3 = TextEditingController();
  final passwordController = TextEditingController();
}

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  bool _hasInput1 = false;
  bool _hasInput2 = false;
  bool _hasInput3 = false;

  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();
  final _textController3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController1.addListener(_onTextChanged1);
    _textController2.addListener(_onTextChanged2);
    _textController3.addListener(_onTextChanged3);
  }

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    _textController3.dispose();
    super.dispose();
  }

  void _onTextChanged1() {
    setState(() {
      _hasInput1 = _textController1.text.trim().isNotEmpty;
    });
  }

  void _onTextChanged2() {
    setState(() {
      _hasInput2 = _textController2.text.trim().isNotEmpty;
    });
  }

  void _onTextChanged3() {
    setState(() {
      _hasInput3 = _textController3.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
          width: double.infinity,
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 200.0,
              ),
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                child: SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _textController1,
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
                        prefixIcon: Icon(Icons.person),
                        prefixIconColor: AppColors.black,
                        prefixStyle: TextStyle(color: AppColors.black),
                        hintText: 'Name',
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
              Container(
                child: SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _textController2,
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
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: AppColors.black,
                        ),
                      ),
                      maxLines: 1,
                    )),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                child: SizedBox(
                    width: 300,
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      controller: _textController3,
                      obscureText: _obscureText,
                      style: const TextStyle(
                        color: AppColors.black,
                      ),
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                          color: AppColors.red,
                        ),
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
                        fillColor: AppColors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        prefixIcon: const Icon(Icons.password),
                        prefixIconColor: AppColors.black,
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          color: AppColors.black,
                        ),
                      ),
                      maxLines: 1,
                    )),
              ),
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
                  onPressed: _hasInput1 && _hasInput2 && _hasInput3
                      ? () {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: _textController2.text,
                            password: _textController3.text,
                          )
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('User registered successfully'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/homepage',
                                (route) =>
                                    false, // remove all routes except homepage
                              );
                            });
                          }).onError((error, stackTrace) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Failed to register user: $error'),
                              ),
                            );
                            print('Failed to sign up user: $error');
                          });
                        }
                      : null,
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 0.0,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 90.0,
                  ),
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: AppColors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
