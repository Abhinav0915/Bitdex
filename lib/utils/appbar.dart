import 'package:flutter/material.dart';

class Appbar {
  static AppBar getAppBar(String title) {
    return AppBar(
      automaticallyImplyLeading: false,
      shadowColor: Colors.black,
      backgroundColor: Colors.purple,
      centerTitle: true,
      title: Text(title,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 4)),
    );
  }
}
